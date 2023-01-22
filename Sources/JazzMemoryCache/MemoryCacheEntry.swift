import Foundation;

internal class MemoryCacheEntry<TValue> {
    private let value: TValue;

    private var lastAccess: Date;

    internal init(_ value: TValue) {
        self.value = value;
        lastAccess = Date();
    }

    internal func getValue() -> TValue {
        lastAccess = Date();

        return value;
    }

    internal func getLastAccess() -> Date {
        return lastAccess;
    }
}