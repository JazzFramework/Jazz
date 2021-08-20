import Server;

public class ControllersInitializer: Initializer {
    public func Initialize(for app: App) throws {
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