import Server;

public class ActionsInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return CreateWeatherActionBuilder(
                    with: try sp.FetchType()
                )
                    .Build() as CreateWeather;
            })

            .WireUp(singleton: { sp in
                return DeleteWeatherActionImpl(
                    with: try sp.FetchType()
                ) as DeleteWeatherAction;
            })

            .WireUp(singleton: { sp in
                return GetWeatherActionImpl(
                    with: try sp.FetchType()
                ) as GetWeatherAction;
            })

            .WireUp(singleton: { sp in
                return GetWeathersActionImpl(
                    with: try sp.FetchType()
                ) as GetWeathersAction;
            })

            .WireUp(singleton: { sp in
                return UpdateWeatherActionImpl(
                    with: try sp.FetchType()
                ) as UpdateWeatherAction;
            });
    }
}