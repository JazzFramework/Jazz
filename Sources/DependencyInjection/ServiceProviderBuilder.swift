public class ServiceProviderBuilder {
    private var _types: [String: (ServiceProvider) throws -> Any];

    public init() {
        _types = [:];
    }

    public func Register<T>(_ logic: @escaping (ServiceProvider) throws -> T) throws -> ServiceProviderBuilder {
        let type: String = String(describing: T.self);

        _types[type] = logic;

        return self;
    }

    public func Build() -> ServiceProvider {
        return ServiceProvider(withTypes: _types);
    }
}