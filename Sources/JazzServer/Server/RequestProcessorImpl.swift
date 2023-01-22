import JazzCodec;

internal final class RequestProcessorImpl: RequestProcessor {
    private let controllers: [Controller];
    private let middlewares: [Middleware];
    private let errorTranslators: [ErrorTranslator];

    internal init(
        middlewares: [Middleware],
        controllers: [Controller],
        errorTranslators: [ErrorTranslator]
    ) {
        self.middlewares = middlewares;
        self.controllers = controllers;
        self.errorTranslators = errorTranslators;
    }

    public final func process(request: RequestContext, result: ResultContext) async {
        do {
            let controller: Controller = try getController(request: request);

            if controller is Authenticates {
                try processAuthentication(request);
            }

            if controller is Authorizes {
                try processAuthorization(request);
            }

            let logic: (RequestContext, ResultContext) async throws -> () = getLogic(controller.logic);

            try await logic(request, result);
        } catch {
            await handle(error: error, result: result);
        }
    }

    private func getController(request: RequestContext) throws -> Controller {
        let controller: Controller? = controllers
            .filter { $0.getMethod() == request.getMethod() && RequestProcessorImpl.doesRouteMatch($0, request) }
            .sorted { $0.getRoute().count > $1.getRoute().count }
            .first;

        guard let controller = controller else {
            throw HttpErrors.notFoundError;
        }

        return controller;
    }

    private static func doesRouteMatch(_ controller: Controller, _ request: RequestContext) -> Bool {
        let routeComponents = controller.getRoute().components(separatedBy: "/");
        let urlComponents = request.getUrl().components(separatedBy: "/");

        if routeComponents.count > urlComponents.count {
            return false;
        }

        var index: Int = 0;

        for (routeComponent, urlComponent) in zip(routeComponents, urlComponents) {
            if routeComponent.starts(with: "/:") {
                let route: String = String(routeComponent.dropFirst());

                if urlComponent.lowercased() != route.lowercased() {
                    return false;
                }
            } else if routeComponent.starts(with: ":") {
                if routeComponent.hasSuffix("+") {
                    let key: String = String(routeComponent.dropFirst().dropLast());
                    let remainder: String = urlComponents[index...].joined(separator: "/");

                    request.updateRouteParameter(key: key, value: remainder);

                    return true;
                } else if routeComponent.hasSuffix("*") {
                    let key: String = String(routeComponent.dropFirst().dropLast());
                    let remainder: String = urlComponents[index...].joined(separator: "/");

                    request.updateRouteParameter(key: key, value: remainder);

                    return true;
                } else {
                    request.updateRouteParameter(key: String(routeComponent.dropFirst()), value: urlComponent);
                }
            } else if urlComponent.lowercased() != routeComponent.lowercased() {
                return false;
            }

            index += 1;
        }

        return true;
    }

    private final func processAuthentication(_ request: RequestContext) throws {
        guard let _: AuthenticationContext = request.fetch() else {
            throw HttpErrors.notAuthenticated;
        }
    }

    private final func processAuthorization(_ request: RequestContext) throws {
        guard let authorizationContext: AuthorizationContext = request.fetch() else {
            throw HttpErrors.notAuthorized;
        }

        let rights: [String] = authorizationContext.getRights();

        if rights.isEmpty {
            throw HttpErrors.notAuthorized;
        }
    }

    //TODO: Only build the middleware collection once, We shouldn't do all this work for each request.
    private func getLogic(
        _ controller: @escaping (RequestContext, ResultContext) async throws -> ()
    ) -> (RequestContext, ResultContext) async throws -> () {
        var logics: [(RequestContext, ResultContext) async throws -> ()] = [
            controller
        ];

        for middleware in middlewares {
            let logic = logics[0];

            let middlewareLogic: (RequestContext, ResultContext) async throws -> () =
                { req, res in
                    try await middleware.logic(for: req, into: res, with: logic);
                };

            logics.insert(middlewareLogic, at: 0);
        }

        return logics[0];
    }

    private func handle(error: Error, result: ResultContext) async {
        //todo: Force error even if accept type doesn't have the media type.
        do {
            for errorTranslator in errorTranslators {
                if errorTranslator.canHandle(error: error) {
                    let serverError: ServerError = errorTranslator.translate(error: error);

                    result.set(statusCode: serverError.getCode());

                    try await result.set(body: serverError);

                    return;
                }
            }

            await RequestProcessorImpl.lastChanceHandle(error: error, result: result);
        } catch {
            await RequestProcessorImpl.lastChanceHandle(error: error, result: result);
        }
    }

    private static func lastChanceHandle(error: Error, result: ResultContext) async {
        //todo: LastChanceErrorHandler
        print("\(error)");

        result.set(statusCode: 500);
    }
}