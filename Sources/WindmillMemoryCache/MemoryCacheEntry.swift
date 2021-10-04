import Foundation;

internal class MemoryCacheEntry<TValue> {
    private let _value: TValue;

    private var _lastAccess: Date;

    internal init(_ value: TValue) {
        _value = value;
        _lastAccess = Date();
    }

    internal func getValue() -> TValue {
        _lastAccess = Date();

        return _value;
    }

    internal func getLastAccess() -> Date {
        return _lastAccess;
    }
}