import Configuration;

public protocol Initializer {
    func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws;
}