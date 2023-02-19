import JazzConfiguration;

public final class ServiceProviderBuilder {
    private var types: [String: [(Configuration, ServiceProvider) async throws -> Any]];

    public init() {
        types = [:];
    }

    public final func register<T>(_ logic: @escaping (Configuration, ServiceProvider) async throws -> T) -> ServiceProviderBuilder {
        let type: String = String(describing: T.self);

        return persistLogic(type, logic);
    }

    public final func register<T>(_ name: String, _ logic: @escaping (Configuration, ServiceProvider) async throws -> T) -> ServiceProviderBuilder {
        let type: String = "\(Constants.CUSTOM_NAME)\(String(describing: T.self))\(name)";

        return persistLogic(type, logic);
    }

    private final func persistLogic<T>(_ type: String, _ logic: @escaping (Configuration, ServiceProvider) async throws -> T) -> ServiceProviderBuilder {
        if var typeLogics = types[type] {
            typeLogics.append(logic);

            types[type] = typeLogics;
        } else {
            types[type] = [logic];
        }

        return self;
    }

    public final func build(configuration: Configuration) -> ServiceProvider {
        return ServiceProviderImpl(configuration: configuration, types: types);
    }
}