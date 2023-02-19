internal final class EnvironmentImpl: Environment {
    private let key: String;

    internal init(key: String = "dev") {
        self.key = key.lowercased();
    }

    public final func getKey() -> String { key }
}