import Configuration;
import Server;

import ExampleServer;

public class ActionsInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return CreateWeatherActionBuilder(
                    with: try sp.FetchType()
                )
                    .Build() as CreateWeather;
            })

            .WireUp(singleton: { sp in
                return DeleteWeatherAction(
                    with: try sp.FetchType()
                ) as DeleteWeather;
            })

            .WireUp(singleton: { sp in
                return GetWeatherAction(
                    with: try sp.FetchType()
                ) as GetWeather;
            })

            .WireUp(singleton: { sp in
                return GetWeathersAction(
                    with: try sp.FetchType()
                ) as GetWeathers;
            })

            .WireUp(singleton: { sp in
                return UpdateWeatherAction(
                    with: try sp.FetchType()
                ) as UpdateWeather;
            });
    }
}