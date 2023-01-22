import Foundation;

public final class InitializerBuilder {
    private var bundle: Bundle?;
    private var filename: String = "initializers";

    public init () {}

    public final func with(bundle: Bundle) -> InitializerBuilder {
        self.bundle = bundle;

        return self;
    }

    public final func with(filename: String) -> InitializerBuilder {
        self.filename = filename;

        return self;
    }

    public final func build() throws -> [String] {
        if let bundle = bundle, let path = bundle.path(forResource: filename, ofType: nil) {
            let file = try String(contentsOfFile: path)

            return file.components(separatedBy: "\n")
                .map {
                    line in
                        line
                            .components(separatedBy: "#")[0]
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                }
                .filter { initializer in initializer != "" };
        }

        return [];
    }
}