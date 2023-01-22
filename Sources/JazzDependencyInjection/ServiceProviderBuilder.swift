public final class ServiceProviderBuilder {
    private var types: [String: [(ServiceProvider) async throws -> Any]];

    public init() {
        types = [:];
    }

    public final func register<T>(_ logic: @escaping (ServiceProvider) async throws -> T) throws -> ServiceProviderBuilder {
        let type: String = String(describing: T.self);

        return try persistLogic(type, logic);
    }

    public final func register<T>(_ name: String, _ logic: @escaping (ServiceProvider) async throws -> T) throws -> ServiceProviderBuilder {
        let type: String = "\(Constants.CUSTOM_NAME)\(String(describing: T.self))\(name)";

        return try persistLogic(type, logic);
    }

    public final func persistLogic<T>(_ type: String, _ logic: @escaping (ServiceProvider) async throws -> T) throws -> ServiceProviderBuilder {
        if var typeLogics = types[type] {
            typeLogics.append(logic);

            types[type] = typeLogics;
        } else {
            types[type] = [logic];
        }

        return self;
    }

    public final func build() -> ServiceProvider {
        return ServiceProvider(withTypes: types);
    }
}