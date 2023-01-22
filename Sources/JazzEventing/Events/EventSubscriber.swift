public protocol EventSubscriber {
    func subscribe<T>(on name: String, _ logic: @escaping (Event<T>) async -> Void) async -> Subscription;
    func unsubscribe(from name: String, _ subscription: Subscription) async;
}