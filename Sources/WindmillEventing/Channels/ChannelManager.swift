internal protocol ChannelManager {
    func getChannel(name: String) -> Channel;

    func cleanChannel(name: String);
}