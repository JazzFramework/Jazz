import Foundation;

public final class MemoryCache<TKey: Hashable, TValue>: Cache<TKey, TValue> {
    private let _options: MemoryCacheOptions;
    private var _data: [TKey: MemoryCacheEntry<TValue>];
    private var _lock: NSLock;

    public init(options: MemoryCacheOptions) {
        _options = options;
        _data = [:];
        _lock = NSLock();
    }

    public func Start() {
        DispatchQueue.global(qos: .background).async {
            while true {
                sleep(60);

                self.CleanUp();
            }
        }
    }

    public final override func Fetch(for key: TKey) -> TValue? {
        if let entry = _data[key] {
            return entry.GetValue();
        }

        return nil;
    }

    public final override func Cache(for key: TKey, with value: TValue) {
        _lock.lock();

        defer {
            _lock.unlock();
        }

        _data[key] = MemoryCacheEntry(value);
    }

    public final override func Remove(for key: TKey) {
        _lock.lock();

        defer {
            _lock.unlock();
        }

        _data.removeValue(forKey: key);
    }

    private func CleanUp()
    {
        let hour: TimeInterval = 60 * 60;
        let anHourAgo: Date = Date() - hour;

        var keysToRemove: [TKey] = [];

        for (key, entry) in _data {
            if (anHourAgo > entry.GetLastAccess())
            {
                keysToRemove.append(key);
            }
        }

        for key in keysToRemove {
            Remove(for: key);
        }

        for (key, _) in _data {
            if (_data.count <= _options.MaxCacheSize)
            {
                break;
            }

            keysToRemove.append(key);
        }

        for key in keysToRemove {
            Remove(for: key);
        }
    }
}