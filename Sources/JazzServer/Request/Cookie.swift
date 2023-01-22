public final class Cookie {
    private final let name: String;
    private final let value: String;

    public init(name: String, value: String) {
        self.name = name;
        self.value = value;
    }

    public final func getName() -> String {
        return name;
    }

    public final func getValue() -> String {
        return value;
    }
}