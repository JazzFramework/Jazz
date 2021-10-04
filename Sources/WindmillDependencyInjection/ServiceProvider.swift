public final class ServiceProvider {
    private let types: [String: (ServiceProvider) async throws -> Any];
    private var builtTypes: [String: Any];

    internal init(withTypes types: [String: (ServiceProvider) async throws -> Any]) {
        self.types = types;
        self.builtTypes = [:];
   }

    public final func fetchType<T>() async throws -> T {
        if let instance: T = try await get("") {
            return instance;
        }

        throw WireErrors.missingType(type: String(describing: T.self));
    }

    public final func fetchType<T>(_ name: String) async throws -> T {
        if let instance: T = try await get(name) {
            return instance;
        }

        throw WireErrors.missingType(type: String(describing: T.self));
    }

    private func get<T>(_ name: String) async throws -> T? {
        let key: String = name != "" ? "CUSTOM_NAME=\(name)" : String(describing: T.self);

        if let cached = builtTypes[key] {
            if let cachedType = cached as? T {
                return cachedType;
            }
        }

        if let instanceBuilder = types[key] {
            let instance = try await instanceBuilder(self);

            if let instanceType = instance as? T {
                builtTypes[key] = instanceType;

                return instanceType;
            }
        }

        return nil;
    }
}