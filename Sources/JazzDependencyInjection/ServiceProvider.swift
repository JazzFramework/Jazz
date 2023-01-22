public final class ServiceProvider {
    private let types: [String: [(ServiceProvider) async throws -> Any]];
    private var builtTypes: [String: [Any]];

    internal init(withTypes types: [String: [(ServiceProvider) async throws -> Any]]) {
        self.types = types;
        self.builtTypes = [:];
   }

    public final func fetchTypes<T>() async throws -> [T] {
        return try await fetchTypes(Constants.EMPTY_STRING);
    }

    public final func fetchTypes<T>(_ name: String) async throws -> [T] {
        return try await getCollection(name);
    }

    public final func fetchType<T>() async throws -> T {
        return try await fetchType(Constants.EMPTY_STRING);
    }

    public final func fetchType<T>(_ name: String) async throws -> T {
        if let instance: T = try await get(name) {
            return instance;
        }

        throw WireErrors.missingType(type: String(describing: T.self));
    }

    private func get<T>(_ name: String) async throws -> T? {
        let results: [T] = try await getCollection(name);

        if let result = results.first {
            return result;
        }

        return nil;
    }

    private func getCollection<T>(_ name: String) async throws -> [T] {
        let key: String =
            name != Constants.EMPTY_STRING ?
                "\(Constants.CUSTOM_NAME)\(String(describing: T.self))\(name)" :
                String(describing: T.self);

        if let cached = builtTypes[key] {
            if let cachedTypes = cached as? [T] {
                return cachedTypes;
            }
        }

        if let instanceBuilders = types[key] {
            for instanceBuilder in instanceBuilders {
                let instance = try await instanceBuilder(self);

                if let instanceType = instance as? T {
                    if var builtType = builtTypes[key] {
                        builtType.append(instanceType);

                        builtTypes[key] = builtType;
                    } else {
                        builtTypes[key] = [instanceType];
                    }
                }
            }
        }

        if let result = builtTypes[key] as? [T] {
            return result;
        }

        return [];
    }
}