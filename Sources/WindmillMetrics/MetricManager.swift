public protocol MetricManager {
    func publish(metric: Metric) async;

    func recordTime<T>(for dimensions: [Dimension], _ logic: () async throws -> T) async throws -> T;
}