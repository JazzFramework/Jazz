import Foundation;

internal final class ChannelManagerImpl: ChannelManager {
    private var lock: NSLock;
    private var channels: [String:Channel];

    internal init() {
        lock = NSLock();
        channels = [:];
    }

    public final func getChannel(name: String) -> Channel {
        return lock.withLock() {
            if let channel = channels[name] {
                return channel;
            }

            let channel = ChannelImpl();

            channels[name] = channel;

            return channel;
        }
    }

    public final func cleanChannel(name: String) {
        lock.withLock() {
            if let channel = channels[name] {
                if channel.getSubscriptionCount() == 0 {
                    channels.removeValue(forKey: name);
                }
            }
        }
    }
}