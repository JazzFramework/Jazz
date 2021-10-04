public protocol EventPublisher {
    func publish<T>(event: Event<T>, on channel: String) async;
}