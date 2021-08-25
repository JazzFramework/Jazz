import Configuration;
import Server;

public class ErrorTranslatorsInitializer: Initializer {
    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(errorTranslator: { _ in
                return WeatherInvalidTempErrorTranslator();
            });
    }
}