public final class Event<T> {
    private let type: String;
    private let value: T;

    public init(type: String, value: T) {
        self.type = type;
        self.value = value;
    }

    public final func getType() -> String {
        return type;
    }

    public final func getValue() -> T {
        return value;
    }
}