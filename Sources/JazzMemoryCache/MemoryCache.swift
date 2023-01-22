import Foundation;

import JazzCore;

public final class MemoryCache<TKey: Hashable, TValue>: Cache<TKey, TValue> {
    private let options: MemoryCacheOptions;
    private var data: [TKey: MemoryCacheEntry<TValue>];
    private var lock: NSLock;

    public init(options: MemoryCacheOptions) {
        self.options = options;
        self.data = [:];
        self.lock = NSLock();
    }

    public func start() async {
        /*
        DispatchQueue.global(qos: .background).async {
            while true {
                sleep(60);

                self.CleanUp();
            }
        }
        */
    }

    public final override func fetch(for key: TKey) async -> TValue? {
        if let entry = data[key] {
            return entry.getValue();
        }

        return nil;
    }

    public final override func cache(for key: TKey, with value: TValue) async {
        lock.withLock() {
            data[key] = MemoryCacheEntry(value);
        }
    }

    public final override func remove(for key: TKey) async {
        _ = lock.withLock() {
            data.removeValue(forKey: key);
        }
    }
/*
    private func CleanUp() async
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
            await Remove(for: key);
        }

        for (key, _) in _data {
            if (_data.count <= _options.MaxCacheSize)
            {
                break;
            }

            keysToRemove.append(key);
        }

        for key in keysToRemove {
            await Remove(for: key);
        }
    }
*/
}