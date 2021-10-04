internal final class EventPublisherImpl: EventPublisher {
    private let channelManager: ChannelManager;

    internal init(channelManager: ChannelManager) {
        self.channelManager = channelManager;
    }

    public final func publish<T>(event: Event<T>, on channel: String) async {
        let channel: Channel = channelManager.getChannel(name: channel);

        await channel.publish(event: event);
    }
}