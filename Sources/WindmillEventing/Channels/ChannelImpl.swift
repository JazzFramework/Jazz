import Foundation;

internal final class ChannelImpl: Channel {
    private var _subscriptions: [Subscription: Any];

    internal init () {
        _subscriptions = [:]
    }

    public final func publish<T: Any>(event: Event<T>) async {
        DispatchQueue.global(qos: .userInitiated).async {
            for (_, logic) in self._subscriptions {
                if let typedLogic = logic as? ((Event<T>) async -> Void) {
                    Task {
                        await typedLogic(event);
                    }
                }
            }
        }
    }
    
    public final func subscribe<T>(subscription: Subscription, _ logic: @escaping (Event<T>) async -> Void) async {
        _subscriptions[subscription] = logic;
    }
    
    public final func unsubscribe(subscription: Subscription) async {
        if let _ = _subscriptions[subscription] {
            _subscriptions.removeValue(forKey: subscription);
        }
    }
    
    public final func getSubscriptionCount() -> Int {
        return _subscriptions.count;
    }
}