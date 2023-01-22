internal protocol Channel {
    func publish<T>(event: Event<T>) async;
    func subscribe<T>(subscription: Subscription, _ logic: @escaping (Event<T>) async -> Void) async;
    func unsubscribe(subscription: Subscription) async;
    func getSubscriptionCount() -> Int;
}