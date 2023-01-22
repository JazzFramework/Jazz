import JazzCodec;
import JazzConfiguration;
import JazzServer;

public final class StencilTemplatingEngineInitializer: ServerInitializer {
    public required init() {}

    public override final func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: {
                sp in return StencilTemplatingEngine(bundle: try await sp.fetchType()) as TemplatingEngine;
            });
    }
}