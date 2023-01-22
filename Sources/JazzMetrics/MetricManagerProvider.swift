public protocol MetricManagerProvider {
    func publish(metric: Metric) async;
}