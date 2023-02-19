import JazzConfiguration;
import JazzCore;

public final class EventInitializer: Initializer {
    public required init() {}

    public override final func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { _, _ in ChannelManagerImpl() as ChannelManager })
            .wireUp(singleton: { _, sp in EventPublisherImpl(channelManager: try await sp.fetchType()) as EventPublisher; })
            .wireUp(singleton: { _, sp in EventSubscriberImpl(channelManager: try await sp.fetchType()) as EventSubscriber; });
    }
}