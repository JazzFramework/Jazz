public final class Dimension {
    private let key: String;
    private let value: String;

    internal init(key: String, value: String) {
        self.key = key;
        self.value = value;
    }

    public final func getKey() -> String {
        return key;
    }

    public final func getValue() -> String {
        return value;
    }
}