internal final class EventSubscriberImpl: EventSubscriber {
    private let channelManager: ChannelManager;

    internal init(channelManager: ChannelManager) {
        self.channelManager = channelManager;
    }

    public final func subscribe<T>(on name: String, _ logic: @escaping (Event<T>) async -> Void) async -> Subscription {
        let subscription: Subscription = Subscription();

        let channel: Channel = channelManager.getChannel(name: name);

        await channel.subscribe(subscription: subscription, logic);

        return subscription;
    }

    public final func unsubscribe(from name: String, _ subscription: Subscription) async {
        let channel: Channel = channelManager.getChannel(name: name);

        await channel.unsubscribe(subscription: subscription);

        channelManager.cleanChannel(name: name);
    }
}