import Foundation;

internal final class ChannelManagerImpl: ChannelManager {
    private var _lock: NSLock;
    private var _channels: [String:Channel];

    internal init() {
        _lock = NSLock();
        _channels = [:];
    }

    public final func getChannel(name: String) -> Channel {
        return _lock.withLock() {
            if let channel = _channels[name] {
                return channel;
            }

            let channel = ChannelImpl();

            _channels[name] = channel;

            return channel;
        }
    }

    public final func cleanChannel(name: String) {
        _lock.withLock() {
            if let channel = _channels[name] {
                if channel.getSubscriptionCount() == 0 {
                    _channels.removeValue(forKey: name);
                }
            }
        }
    }
}