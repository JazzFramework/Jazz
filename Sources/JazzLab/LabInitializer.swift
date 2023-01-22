import JazzConfiguration;
import JazzCore;

public final class LabInitializer: Initializer {
    public required init() {}

    public override final func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { _ in return LabManagerImpl() as LabManager; });
    }
}