import Foundation;

public final class InitializerBuilder {
    private var _bundle: Bundle?;
    private var _filename: String = "initializers";

    public init () {}

    public final func with(bundle: Bundle) -> InitializerBuilder {
        _bundle = bundle;

        return self;
    }

    public final func with(filename: String) -> InitializerBuilder {
        _filename = filename;

        return self;
    }

    public final func build() throws -> [String] {
        if let bundle = _bundle {
            if let path = bundle.path(forResource: _filename, ofType: nil) {
                let file = try String(contentsOfFile: path)

                let text: [String] = file.components(separatedBy: "\n");

                return text;
            }
        }

        return [];
    }
}