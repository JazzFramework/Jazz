internal final class NoopMetricManagerProvider: MetricManagerProvider {
    public func publish(metric: Metric) async {}
}