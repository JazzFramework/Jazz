import JazzConfiguration;
import JazzCore;

public final class MetricInitializer: Initializer {
    public required init() {}

    public override final func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { _, _ in return NoopMetricManagerProvider() as MetricManagerProvider; })
            .wireUp(singleton: { _, sp in return MetricManagerImpl(metricManagerProvider: try await sp.fetchType()) as MetricManager; });
    }
}