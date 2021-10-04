import Foundation;

import Hummingbird

import WindmillCodec;
import WindmillServer;

public class HummingbirdHttpProcessor: HttpProcessor {
    private let _app: HBApplication;

    private var _transcoders: [Transcoder];
    private var _middlewares: [WindmillServer.Middleware];
    private var _errorTranslators: [ErrorTranslator];

    public init() {
        _app = HBApplication(configuration: .init(address: .hostname("127.0.0.1", port: 8080)))

        _transcoders = [];
        _middlewares = [];
        _errorTranslators = [];
    }

    public func wireUp(controller: Controller) -> HttpProcessor {
        switch controller.getMethod() {
            case .get:
                _app.router.get(controller.getRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.processRequest(for: request, with: controller);
                }
            case .put:
                _app.router.put(controller.getRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.processRequest(for: request, with: controller);
                }
                break;
            case .post:
                _app.router.post(controller.getRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.processRequest(for: request, with: controller);
                }
                break;
            case .delete:
                _app.router.delete(controller.getRoute(), options: HBRouterMethodOptions()) { request async -> HBResponse in
                    return await self.processRequest(for: request, with: controller);
                }
                break;
        }

        return self;
    }

    private func processRequest(for request: HBRequest, with controller: Controller) async -> HBResponse {
        let acceptMediaTypes: [MediaType] = getMediaTypes(for: "Accept", in: request);

        do
        {
            let requestContext: RequestContext = try await buildRequest(for: request, with: controller);

            let result: ResultContext = try await run(controller: controller.logic, requestContext);

            return try await handle(result: result, with: acceptMediaTypes);
        }
        catch
        {
            return await handle(error: error, with: acceptMediaTypes);
        }
    }

    private func run(
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
                    return try await middleware.logic(for: req, with: logic);
                };

            logics.insert(middlewareLogic, at: 0);
        }

        return try await logics[0](request);
    }

    public func wireUp(errorTranslator: ErrorTranslator) -> HttpProcessor {
        _errorTranslators.append(errorTranslator);

        return self;
    }

    public func wireUp(middleware: WindmillServer.Middleware) -> HttpProcessor {
        _middlewares.append(middleware);

        return self;
    }

    public func wireUp(transcoder: Transcoder) -> HttpProcessor {
        _transcoders.append(transcoder);

        return self;
    }

    public func start() throws {
        try _app.start()

        _app.wait()
    }

    private func buildRequest(
        for request: HBRequest,
        with controller: Controller
    ) async throws -> RequestContext {
        let builder: RequestContextBuilder = RequestContextBuilder()
        
        _ = builder.with(method: convert(method: request.method));
        _ = builder.with(url: request.uri.description);
        _ = builder.with(body: try await parseBody(from: request));

        for (key, value) in request.headers {
            _ = builder.with(header: key, values: [value]);
        }

        for part in controller.getRoute().components(separatedBy: "/") {
            if part.starts(with: ":") {
                let param = String(part.dropFirst());

                if let paramValue = request.parameters[param] {
                    _ = builder.with(route: param, value: paramValue);
                }
            }
        }

        return builder.build();
    }

    private func convert(method: HTTPMethod) -> HttpMethod {

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

    private func parseBody(from request: HBRequest) async throws -> Any? {
        if let buffer = request.body.buffer {
            if let mediaType: MediaType = getMediaType(for: "Content-Type", in: request) {
                for transcoder in self._transcoders {
                    if
                        transcoder.canHandle(mediaType: mediaType)
                    {
                        let streams: BoundStreams = BoundStreams();

                        if let bytes = buffer.getBytes(at: 0, length: buffer.capacity) {
                            _ = streams.output.write(bytes, maxLength: buffer.capacity);

                            if let result = await transcoder.decode(data: streams.input, for: mediaType) {
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

    private func handle(error: Error, with mediaTypes: [MediaType]) async -> HBResponse
    {
        do
        {
            for errorTranslator in _errorTranslators {
                if errorTranslator.canHandle(error: error) {
                    let result: ApiError = errorTranslator.translate(error: error);

                    return try await handle(
                        result: ResultContextBuilder()
                            .with(statusCode: result.getCode())
                            .with(body: result)
                            .build(),
                        with: mediaTypes
                    );
                }
            }
        }
        catch {
            print("\(error)");           
        }

        return HBResponse(status: .internalServerError);
    }

    private func handle(
        result: ResultContext,
        with mediaTypes: [MediaType]
    ) async throws -> HBResponse {
        let status: HTTPResponseStatus = .custom(code: result.getStatusCode(), reasonPhrase: "");

        if let body = result.getBody() {
            for transcoder in self._transcoders {
                for mediaType in mediaTypes {
                    if
                        transcoder.canHandle(mediaType: mediaType) &&
                        transcoder.canHandle(data: body)
                    {
                        let streams: BoundStreams = BoundStreams();

                        if await transcoder.encode(data: body, for: mediaType, into: streams.output) {
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

    private func getMediaType(
        for property: String,
        in request: HBRequest
    ) -> MediaType? {
        if let header = request.headers[property].first {
            return MediaType(parseFrom: header);
        }

        return nil;
    }

    private func getMediaTypes(
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