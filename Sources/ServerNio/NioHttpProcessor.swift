import Foundation;

import NIOHTTP1;

import MicroExpress;

import Codec;
import Server;

public class NioHttpProcessor: HttpProcessor {
    private let _defaultHost = "127.0.0.1";
    private let _defaultPort = 8080;

    private let _app: Express;

    private var _encoders: [Encoder];
    private var _decoders: [Decoder];
    private var _errorTranslators: [ErrorTranslator];

    public init() {
        _app = Express();

        _encoders = [];
        _decoders = [];
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
                    try controller.Logic(withRequest: try self.Build(request: req));

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

    public func WireUp(errorTranslator: ErrorTranslator) -> HttpProcessor {
        _errorTranslators.append(errorTranslator);

        return self;
    }

    public func WireUp(middleware: Server.Middleware) -> HttpProcessor {
        return self;
    }

    public func WireUp(encoder: Encoder) -> HttpProcessor {
        _encoders.append(encoder);

        return self;
    }

    public func WireUp(decoder: Decoder) -> HttpProcessor {
        _decoders.append(decoder);

        return self;
    }

    public func Start() throws {
        _app.listen(_defaultPort);
    }

    private func Build(request: IncomingMessage) throws -> RequestContext {
        let builder: RequestContextBuilder = RequestContextBuilder();

        if let mediaType: MediaType = self.GetMediaType(for: "content-type", in: request) {
            if let decoder = self._decoders.first(where: { $0.CanHandle(mediaType: mediaType) }) {
            {
                let streams: BoundStreams = BoundStreams();

                let body = decoder.Decode(data: streams.input, for: mediaType);

                builder.With(body: body);               
            }
            else
            {
                throw HttpErrors.unsupportedMediaType;
            }
        }

        return builder.Build();
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
    ) -> MediaType? {
        if let header: MediaType = request.header.headers[property].first {
            return MediaType(parseFrom: header);
        }

        return nil;
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
            for encoder in self._encoders {
                for mediaType in mediaTypes {
                    if
                        encoder.CanHandle(mediaType: mediaType) &&
                        encoder.CanHandle(data: body)
                    {
                        let streams: BoundStreams = BoundStreams();

                        if encoder.Encode(data: body, for: mediaType, into: streams.output) {
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
                let result: ResultContext = errorTranslator.Handle(error: error);
                let status: HTTPResponseStatus =
                    .custom(code: result.GetStatusCode(), reasonPhrase: "");

                res.status = status;
                do {
                    try self.Handle(
                        result: result,
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