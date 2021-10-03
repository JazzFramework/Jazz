import Foundation;

import Hummingbird

import Codec;
import Server;

public class HummingbirdHttpProcessor: HttpProcessor {
    private let _app: HBApplication;

    private var _transcoders: [Transcoder];
    private var _middlewares: [Server.Middleware];
    private var _errorTranslators: [ErrorTranslator];

    public init() {
        _app = HBApplication(configuration: .init(address: .hostname("127.0.0.1", port: 8080)))

        _transcoders = [];
        _middlewares = [];
        _errorTranslators = [];
    }

    public func WireUp(controller: Controller) -> HttpProcessor {
        switch controller.GetMethod() {
            case .get:
                _app.router.get(controller.GetRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.ProcessRequest(for: request, with: controller);
                }
            case .put:
                _app.router.put(controller.GetRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.ProcessRequest(for: request, with: controller);
                }
                break;
            case .post:
                _app.router.post(controller.GetRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.ProcessRequest(for: request, with: controller);
                }
                break;
            case .delete:
                _app.router.delete(controller.GetRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.ProcessRequest(for: request, with: controller);
                }
                break;
        }

        return self;
    }

    private func ProcessRequest(for request: HBRequest, with controller: Controller) async -> HBResponse {
        let acceptMediaTypes: [MediaType] = GetMediaTypes(for: "Accept", in: request);

        do
        {
            let requestContext: RequestContext = try BuildRequest(for: request, with: controller);

            let result: ResultContext = try await Run(controller: controller.Logic, requestContext);

            return try Handle(result: result, with: acceptMediaTypes);
        }
        catch
        {
            return Handle(error: error, with: acceptMediaTypes);
        }
    }

    private func Run(
        controller: @escaping (RequestContext) async throws -> ResultContext,
        _ request: RequestContext
    ) async throws -> ResultContext {
        var logics: [(RequestContext) async throws -> ResultContext] = [
            controller
        ];

        for middleware in _middlewares {
            let logic = logics[0];

            let middlewareLogic: (RequestContext) async throws -> ResultContext =
                { req in
                    return try await middleware.Logic(for: req, with: logic);
                };

            logics.insert(middlewareLogic, at: 0);
        }

        return try await logics[0](request);
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
        try _app.start()

        _app.wait()
    }

    private func BuildRequest(
        for request: HBRequest,
        with controller: Controller
    ) throws -> RequestContext {
        let builder: RequestContextBuilder = RequestContextBuilder()
        
        _ = builder.With(method: Convert(method: request.method));
        _ = builder.With(url: request.uri.description);
        _ = builder.With(body: try ParseBody(from: request));

        for (key, value) in request.headers {
            _ = builder.With(header: key, values: [value]);
        }

        for part in controller.GetRoute().components(separatedBy: "/") {
            if part.starts(with: ":") {
                let param = String(part.dropFirst());

                if let paramValue = request.parameters[param] {
                    _ = builder.With(route: param, value: paramValue);
                }
            }
        }

        return builder.Build();
    }

    private func Convert(method: HTTPMethod) -> HttpMethod {

        switch (method)
        {
            case .GET:
                return .get;
            case .PUT:
                return .put;
            case .POST:
                return .post;
            case .DELETE:
                return .delete;
            default:
                return .get;
        }
    }

    private func ParseBody(from request: HBRequest) throws -> Any? {
        if let buffer = request.body.buffer {
            if let mediaType: MediaType = GetMediaType(for: "Content-Type", in: request) {
                for transcoder in self._transcoders {
                    if
                        transcoder.CanHandle(mediaType: mediaType)
                    {
                        let streams: BoundStreams = BoundStreams();

                        if let bytes = buffer.getBytes(at: 0, length: buffer.capacity) {
                            _ = streams.output.write(bytes, maxLength: buffer.capacity);

                            if let result = transcoder.Decode(data: streams.input, for: mediaType) {
                                return result;
                            }
                        }
                    }
                }
            }

            throw HttpErrors.unsupportedMediaType;
        }

        return nil;
    }

    private func Handle(error: Error, with mediaTypes: [MediaType]) -> HBResponse
    {
        do
        {
            for errorTranslator in _errorTranslators {
                if errorTranslator.CanHandle(error: error) {
                    let result: ApiError = errorTranslator.Translate(error: error);

                    return try Handle(
                        result: ResultContextBuilder()
                            .With(statusCode: result.GetCode())
                            .With(body: result)
                            .Build(),
                        with: mediaTypes
                    );
                }
            }
        }
        catch {}

        return HBResponse(status: .internalServerError);
    }

    private func Handle(result: ResultContext, with mediaTypes: [MediaType]) throws -> HBResponse {
        let status: HTTPResponseStatus = .custom(code: result.GetStatusCode(), reasonPhrase: "");

        if let body = result.GetBody() {
            for transcoder in self._transcoders {
                for mediaType in mediaTypes {
                    if
                        transcoder.CanHandle(mediaType: mediaType) &&
                        transcoder.CanHandle(data: body)
                    {
                        let streams: BoundStreams = BoundStreams();

                        if transcoder.Encode(data: body, for: mediaType, into: streams.output) {
                            let data: Data = try! Data(reading: streams.input);
                            let string: String = String(decoding: data, as: UTF8.self);
                            let byteBuffer = ByteBuffer(string: string);

                            return HBResponse(
                                status: status,
                                headers: [:],
                                body: HBResponseBody.byteBuffer(byteBuffer)
                            );
                        }
                    }
                }
            }

            throw HttpErrors.notAcceptable;
        }

        return HBResponse(status: status);
    }

    private func GetMediaType(
        for property: String,
        in request: HBRequest
    ) -> MediaType? {
        if let header = request.headers[property].first {
            return MediaType(parseFrom: header);
        }

        return nil;
    }

    private func GetMediaTypes(
        for property: String,
        in request: HBRequest
    ) -> [MediaType] {
        var mediaTypes: [MediaType] = [];

        for header in request.headers[property] {
            mediaTypes.append(MediaType(parseFrom: header));
        }

        return mediaTypes;
    }
}