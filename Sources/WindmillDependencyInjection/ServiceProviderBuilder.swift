public final class ServiceProviderBuilder {
    private var types: [String: (ServiceProvider) async throws -> Any];

    public init() {
        types = [:];
    }

    public final func register<T>(_ logic: @escaping (ServiceProvider) async throws -> T) throws -> ServiceProviderBuilder {
        let type: String = String(describing: T.self);

        types[type] = logic;

        return self;
    }

    public final func register<T>(_ name: String, _ logic: @escaping (ServiceProvider) async throws -> T) throws -> ServiceProviderBuilder {
        let type: String = "CUSTOM_NAME=\(name)";

        types[type] = logic;

        return self;
    }

    public final func build() -> ServiceProvider {
        return ServiceProvider(withTypes: types);
    }
}