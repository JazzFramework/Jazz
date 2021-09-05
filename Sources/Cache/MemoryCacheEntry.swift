import Foundation;

internal class MemoryCacheEntry<TValue> {
    private let _value: TValue;

    private var _lastAccess: Date;

    internal init(_ value: TValue) {
        _value = value;
        _lastAccess = Date();
    }

    internal func GetValue() -> TValue {
        _lastAccess = Date();

        return _value;
    }

    internal func GetLastAccess() -> Date {
        return _lastAccess;
    }
}