import JazzCodec;
import JazzConfiguration;

public final class DefaultServerInitializer: ServerInitializer {
    public required init() {}

    public override final func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        //TODO Split init into multiple
        _ = try app
            .wireUp(singleton: { _, sp in
                return RequestProcessorImpl(
                    middlewares: try await sp.fetchTypes(),
                    controllers: try await sp.fetchTypes(),
                    errorTranslators: try await sp.fetchTypes()
                ) as RequestProcessor;
            })
            .wireUp(singleton: { _, sp in
                return TranscoderCollectionImpl(transcoders: try await sp.fetchTypes()) as TranscoderCollection;
            })
            .wireUp(singleton: { _, sp in return CookieProcessorImpl() as CookieProcessor; });
    }
}