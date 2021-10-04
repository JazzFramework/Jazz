import WindmillConfiguration;

public final class DefaultCodecsInitializer: ServerInitializer {
    public required init() {}

    public override final func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(transcoder: { _ in
                return ApiErrorV1JsonCodec();
            })
            .wireUp(transcoder: { _ in
                return HtmlCodec();
            });
    }
}