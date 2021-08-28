import Configuration;
import Server;

public class EndpointsInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(controller: { sp in
                return CreateWeatherController(with: try sp.FetchType());
            })

            .WireUp(controller: { sp in
                return DeleteWeatherController(with: try sp.FetchType());
            })

            .WireUp(controller: { sp in
                return GetWeatherCollectionController(with: try sp.FetchType());
            })

            .WireUp(controller: { sp in
                return GetWeatherController(with: try sp.FetchType());
            })

            .WireUp(controller: { sp in
                return UpdateWeatherController(with: try sp.FetchType());
            });
    }
}