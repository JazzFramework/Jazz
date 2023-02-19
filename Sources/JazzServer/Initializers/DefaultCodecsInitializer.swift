import JazzConfiguration;

public final class DefaultCodecsInitializer: ServerInitializer {
    public required init() {}

    public override final func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(transcoder: { _, _ in
                return ServerErrorV1JsonCodec();
            })
            .wireUp(transcoder: { _, sp in
                return ServerErrorV1HtmlCodec(templatingEngine: try await sp.fetchType());
            })
            .wireUp(transcoder: { _, _ in
                return HtmlCodec();
            });
    }
}