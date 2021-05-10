import Context

internal class StringContext: BaseContext {
    private let _value: String;

    internal init(_ value: String) {
        _value = value;
    }

    public func GetValue() -> String {
        return _value;
    }
}