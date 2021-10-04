import Context

internal class StringContext: BaseContext {
    public let value: String;

    internal init(_ value: String) {
        self.value = value;
    }
}