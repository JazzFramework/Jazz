open class HtmlController: Controller {
    private let templatingEngine: TemplatingEngine;

    public init(templatingEngine: TemplatingEngine) {
        self.templatingEngine = templatingEngine;
    }

    public final override func logic(withRequest request: RequestContext, intoResult result: ResultContext) async throws {
        let webControllerResult: HtmlControllerResult = try await logic(withRequest: request);

        result.set(statusCode: webControllerResult.getStatusCode());

        try await result.set(body: webControllerResult.getBody());

        for (key, values) in webControllerResult.getHeaders() {
            for value in values {
                result.set(headerKey: key, headerValue: value);
            }
        }
    }

    open func logic(withRequest request: RequestContext) async throws -> HtmlControllerResult {
        return HtmlControllerResultBuilder()
            .with(statusCode: 500)
            .build();
    }

    public final func template(
        _ template: String,
        _ data: [String: Any],
        headers: [String:[String]] = [:]
    ) async throws -> HtmlControllerResult {
        let body: HtmlStream = try await templatingEngine.run(template: template, data);

        return HtmlControllerResultBuilder()
            .with(statusCode: 200)
            .with(body: body)
            .with(headers: headers)
            .build();
    }

    public final func redirect(url: String, headers: [String:[String]] = [:]) -> HtmlControllerResult {
        return HtmlControllerResultBuilder()
            .with(statusCode: 307)
            .with(headers: headers)
            .with(headers: [HttpHeaders.LOCATION: [url]])
            .build();
    }

    public final func permanentRedirect(url: String, headers: [String:[String]] = [:]) -> HtmlControllerResult {
        return HtmlControllerResultBuilder()
            .with(statusCode: 308)
            .with(headers: headers)
            .with(headers: [HttpHeaders.LOCATION: [url]])
            .build();
    }
}