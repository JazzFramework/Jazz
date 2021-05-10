import Foundation;

public class ServiceProvider {
    private let _types: [String: (ServiceProvider) -> Any];
    private var _builtTypes: [String: Any];

    public init(withTypes types: [String: (ServiceProvider) -> Any]) {
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

        if let instance = _types[key] {
            if let instanceType = instance as? T {
                _builtTypes[key] = instanceType;

                return instanceType;
            }
        }

        return nil;
    }
}