import Foundation;

import Stencil;

internal final class BundleViewLoader: Loader {
    private let bundle: Bundle;

    public init(bundle: Bundle) {
        self.bundle = bundle;
    }

    func loadTemplate(name: String, environment: Environment) throws -> Template {
        if let path = bundle.path(forResource: name, ofType: nil) {
            let file = try String(contentsOfFile: path);

            return Template(templateString: file, environment: environment);
        }

        throw TemplateDoesNotExist(templateNames: [name], loader: self);
    }
}