public class ServiceProvider {
    private let _types: [String: (ServiceProvider) async throws -> Any];
    private var _builtTypes: [String: Any];

    internal init(withTypes types: [String: (ServiceProvider) async throws -> Any]) {
        _types = types;
        _builtTypes = [:];
    }

    public func Get<T>() async throws -> T? {
        let key: String = String(describing: T.self);

        if let cached = _builtTypes[key] {
            if let cachedType = cached as? T {
                return cachedType;
            }
        }

        if let instanceBuilder = _types[key] {
            let instance = try await instanceBuilder(self);

            if let instanceType = instance as? T {
                _builtTypes[key] = instanceType;

                return instanceType;
            }
        }

        return nil;
    }

    public func FetchType<T>() async throws -> T {
        if let instance: T = try await Get() {
            return instance;
        }

        throw WireErrors.missingType(type: String(describing: T.self));
    }
}