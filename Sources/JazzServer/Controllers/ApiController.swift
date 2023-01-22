open class ApiController: Controller {
    public override init() {
        super.init();
    }

    public final override func logic(withRequest request: RequestContext, intoResult result: ResultContext) async throws {
        let apiControllerResult: ApiControllerResult = try await logic(withRequest: request);

        result.set(statusCode: apiControllerResult.getStatusCode());

        for (key, values) in apiControllerResult.getHeaders() {
            for value in values {
                result.set(headerKey: key, headerValue: value);
            }
        }

        if let body = apiControllerResult.getBody() {
            try await result.set(body: body);
        }
    }

    open func logic(withRequest request: RequestContext) async throws -> ApiControllerResult {
        return ApiControllerResultBuilder()
            .with(statusCode: 500)
            .build();
    }

    public final func ok(body: Any, headers: [String:[String]] = [:]) -> ApiControllerResult {
         ApiControllerResultBuilder()
            .with(statusCode: 200)
            .with(headers: headers)
            .with(body: body)
            .build();
    }

    public final func noContent(headers: [String:[String]] = [:]) -> ApiControllerResult {
        return ApiControllerResultBuilder()
            .with(statusCode: 204)
            .with(headers: headers)
            .build();
    }

    public final func redirect(url: String, headers: [String:[String]] = [:]) -> ApiControllerResult {
        return ApiControllerResultBuilder()
            .with(statusCode: 307)
            .with(headers: headers)
            .with(headers: [HttpHeaders.LOCATION: [url]])
            .build();
    }

    public final func permanentRedirect(url: String, headers: [String:[String]] = [:]) -> ApiControllerResult {
        return ApiControllerResultBuilder()
            .with(statusCode: 308)
            .with(headers: headers)
            .with(headers: [HttpHeaders.LOCATION: [url]])
            .build();
    }
}