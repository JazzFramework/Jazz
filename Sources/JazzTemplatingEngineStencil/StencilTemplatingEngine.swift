import Foundation;

import Stencil;

import JazzServer;

internal final class StencilTemplatingEngine: TemplatingEngine {
    private let environment: Environment;

    internal init(bundle: Bundle) {
        self.environment = Environment(loader: BundleViewLoader(bundle: bundle));
    }

    public final func run(template: String, _ data: [String: Any]) async throws -> HtmlStream {
        let content: String = try environment.renderTemplate(name: template, context: data);

        return StencilHtmlStream(html: content);
    }

    public final func templateExist(_ template: String) -> Bool {
        do {
            _ = try environment.loadTemplate(name: template);

            return true;
        } catch {
            return false;
        }
    }
}