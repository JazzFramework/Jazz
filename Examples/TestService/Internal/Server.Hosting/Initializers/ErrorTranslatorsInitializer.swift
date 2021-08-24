import Server;

public class ErrorTranslatorsInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(errorTranslator: { _ in
                return WeatherInvalidTempErrorTranslator();
            });
    }
}