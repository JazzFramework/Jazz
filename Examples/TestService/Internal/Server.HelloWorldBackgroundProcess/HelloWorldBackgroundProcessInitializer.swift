import Configuration;
import Server;

public class HelloWorldBackgroundProcessInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = configurationBuilder
            .With(decoder: AppConfigV1JsonCodec())
            .With(
                file: "appsettings.json",
                for: AppConfigV1JsonCodec.SupportedMediaType
            );

        _ = try app
            .WireUp(backgroundProcess: { sp in
                return HelloWorldBackgroundProcess(
                    with: try sp.FetchType(),
                    with: try sp.FetchType(),
                    with: try sp.FetchType()
                );
            });
    }
}