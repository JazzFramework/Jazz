import Foundation;

internal final class ChannelImpl: Channel {
    private var subscriptions: [Subscription: Any];

    internal init () {
        subscriptions = [:]
    }

    public final func publish<T: Any>(event: Event<T>) async {
        DispatchQueue.global(qos: .userInitiated).async {
            for (_, logic) in self.subscriptions {
                if let typedLogic = logic as? ((Event<T>) async -> Void) {
                    Task {
                        await typedLogic(event);
                    }
                }
            }
        }
    }
    
    public final func subscribe<T>(subscription: Subscription, _ logic: @escaping (Event<T>) async -> Void) async {
        subscriptions[subscription] = logic;
    }
    
    public final func unsubscribe(subscription: Subscription) async {
        if let _ = subscriptions[subscription] {
            subscriptions.removeValue(forKey: subscription);
        }
    }
    
    public final func getSubscriptionCount() -> Int {
        return subscriptions.count;
    }
}