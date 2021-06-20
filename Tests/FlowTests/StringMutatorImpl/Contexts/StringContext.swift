import Context

internal class StringContext: BaseContext {
    public let Value: String;

    internal init(_ value: String) {
        Value = value;
    }
}