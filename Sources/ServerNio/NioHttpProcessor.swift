import Foundation;

import NIOHTTP1;

import MicroExpress;

import Codec;
import Server;

public class NioHttpProcessor: HttpProcessor {
    private let _defaultHost = "127.0.0.1";
    private let _defaultPort = 8080;

    private let _app: Express;

    private var _transcoders: [Transcoder];
    private var _middlewares: [Server.Middleware];
    private var _errorTranslators: [ErrorTranslator];

    public init() {
        _app = Express();

        _transcoders = [];
        _middlewares = [];
        _errorTranslators = [];
    }

    public func WireUp(controller: Controller) -> HttpProcessor {
        _app.use() { req, res, next in
            let acceptMediaTypes: [MediaType] =
                self.GetMediaTypes(for: "accept", in: req);

            do
            {
                guard
                    self.DoesMethodMatch(controller.GetMethod(), req.header.method),
                    req.header.uri.hasPrefix(controller.GetRoute())
                else
                {
                    return next();
                }

                let result: ResultContext =
                    try self.Run(controller: controller.Logic, self.Build(request: req));

                res.status = .noContent;
                try self.Handle(
                    result: result,
                    with: acceptMediaTypes,
                    targetStatus: .ok,
                    for: res
                );
            }
            catch
            {
                self.Handle(
                    error: error,
                    with: acceptMediaTypes,
                    for: res
                );
            }
        }

        return self;
    }

    private func Run(
        controller: @escaping (RequestContext) throws -> ResultContext,
        _ request: RequestContext
    ) throws -> ResultContext {
        let logic: (RequestContext) throws -> ResultContext =
            controller;

        return try logic(request);
    }

    public func WireUp(errorTranslator: ErrorTranslator) -> HttpProcessor {
        _errorTranslators.append(errorTranslator);

        return self;
    }

    public func WireUp(middleware: Server.Middleware) -> HttpProcessor {
        _middlewares.append(middleware);

        return self;
    }

    public func WireUp(transcoder: Transcoder) -> HttpProcessor {
        _transcoders.append(transcoder);

        return self;
    }

    public func Start() throws {
        _app.listen(_defaultPort);
    }

    private func Build(request: IncomingMessage) -> RequestContext {
        /*
        let mediaType: MediaType =
            self.GetMediaType(for: "content-type", in: request);

        //if let body = result.GetBody() {
            for decoder in self._decoders {
                if
                    decoder.CanHandle(mediaType: mediaType) &&
                    decoder.CanHandle(data: body)
                {
                    let streams: BoundStreams = BoundStreams();
/*
                    if decoder.Encode(data: body, for: mediaType, into: streams.output) {
                        let data: Data = try Data(reading: streams.input);

                        res.status = status;
                        res.send(String(decoding: data, as: UTF8.self));

                        return;
                    }
*/
                    break;
                }
            }

            //res.status = .unsupportedMediaType;
        //}
*/
        return RequestContextBuilder().Build();
    }

    private func DoesMethodMatch(_ method: HttpMethod, _ other: HTTPMethod) -> Bool {
        switch (other) {
            case .GET:
                return method == .get;
            case .POST:
                return method == .post;
            case .PUT:
                return method == .put;
            case .DELETE:
                return method == .delete;

            default:
                return false;
        }
    } 

    private func GetMediaType(
        for property: String,
        in request: IncomingMessage
    ) -> MediaType {
        if let header = request.header.headers[property].first {
            return MediaType(parseFrom: header);
        }

        return MediaType(parseFrom: "");
    }

    private func GetMediaTypes(
        for property: String,
        in request: IncomingMessage
    ) -> [MediaType] {
        var mediaTypes: [MediaType] = [];

        for header in request.header.headers[property] {
            mediaTypes.append(MediaType(parseFrom: header));
        }

        return mediaTypes;
    }

    private func Handle(
        result: ResultContext,
        with mediaTypes: [MediaType],
        targetStatus status: HTTPResponseStatus,
        for res: ServerResponse
    ) throws {
        if let body = result.GetBody() {
            for transcoder in self._transcoders {
                for mediaType in mediaTypes {
                    if
                        transcoder.CanHandle(mediaType: mediaType) &&
                        transcoder.CanHandle(data: body)
                    {
                        let streams: BoundStreams = BoundStreams();

                        if transcoder.Encode(data: body, for: mediaType, into: streams.output) {
                            let data: Data = try Data(reading: streams.input);

                            res.status = status;
                            res.send(String(decoding: data, as: UTF8.self));

                            return;
                        }

                        break;
                    }
                }
            }

            throw HttpErrors.notAcceptable;
        }

        res.send("");
    }

    private func Handle(
        error: Error,
        with mediaTypes: [MediaType],
        for res: ServerResponse
    )
    {
        for errorTranslator in _errorTranslators {
            if errorTranslator.CanHandle(error: error) {
                let result: ApiError = errorTranslator.Handle(error: error);
                let status: HTTPResponseStatus =
                    .custom(code: result.GetCode(), reasonPhrase: "");

                res.status = status;
                do {
                    try self.Handle(
                        result: ResultContextBuilder()
                            .With(statusCode: result.GetCode())
                            .With(body: result)
                            .Build(),
                        with: mediaTypes,
                        targetStatus: status,
                        for: res
                    );
                }
                catch
                {
                    res.send("An error has occured.");
                }
                return;
            }
        }

        res.status = .internalServerError;
        res.send("An error has occured.");
    }
}