public class ServiceProvider {
    private let _types: [String: (ServiceProvider) throws -> Any];
    private var _builtTypes: [String: Any];

    internal init(withTypes types: [String: (ServiceProvider) throws -> Any]) {
        _types = types;
        _builtTypes = [:];
    }

    public func Get<T>() throws -> T? {
        let key: String = String(describing: T.self);

        if let cached = _builtTypes[key] {
            if let cachedType = cached as? T {
                return cachedType;
            }
        }

        if let instanceBuilder = _types[key] {
            let instance = try instanceBuilder(self);

            if let instanceType = instance as? T {
                _builtTypes[key] = instanceType;

                return instanceType;
            }
        }

        return nil;
    }

    public func FetchType<T>() throws -> T {
        if let instance: T = try Get() {
            return instance;
        }

        throw WireErrors.missingType(type: String(describing: T.self));
    }
}