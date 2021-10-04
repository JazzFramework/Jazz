import Foundation;

internal final class MetricManagerImpl : MetricManager {
    private var metricManagerProvider: MetricManagerProvider;

    internal init(metricManagerProvider: MetricManagerProvider) {
        self.metricManagerProvider = metricManagerProvider;
    }

    public func publish(metric: Metric) async {
        await metricManagerProvider.publish(metric: metric);
    }
    
    public func recordTime<T>(
        for dimensions: [Dimension],
        _ logic: () async throws -> T
    ) async throws -> T {
        var ret: T? = nil;

        let executionTime: Duration = try await ContinuousClock().measure {
            ret = try await logic();
        }

        await publish(metric:
            MetricBuilder()
                .with(dimensions: dimensions)
                .with(value: Decimal(executionTime.components.attoseconds))
                .with(unit: .attoseconds)
                .build()
        );

        return ret!;
    }
}