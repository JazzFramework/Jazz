public protocol TemplatingEngine {
    func run(template: String, _ data: [String: Any]) async throws -> HtmlStream;

    func templateExist(_ template: String) -> Bool;
}