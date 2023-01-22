import JazzConfiguration;
import JazzCore;

public final class EventInitializer: Initializer {
    public required init() {}

    public override final func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { _ in ChannelManagerImpl() as ChannelManager })
            .wireUp(singleton: { sp in EventPublisherImpl(channelManager: try await sp.fetchType()) as EventPublisher; })
            .wireUp(singleton: { sp in EventSubscriberImpl(channelManager: try await sp.fetchType()) as EventSubscriber; });
    }
}