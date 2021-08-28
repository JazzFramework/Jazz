import Configuration;

public class DefaultCodecsInitializer: Initializer {
    public required init() {}

    public override final func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(transcoder: { _ in
                return ApiErrorV1JsonCodec();
            });
    }
}