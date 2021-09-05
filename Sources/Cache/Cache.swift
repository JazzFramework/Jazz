open class Cache<TKey: Hashable, TValue> {
    open func Fetch(for key: TKey) -> TValue? {
        return nil;
    }

    open func Cache(for key: TKey, with value: TValue) {
    }

    open func Remove(for key: TKey) {
    }
}