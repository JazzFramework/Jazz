import Configuration;

open class ServerInitializer {
    public required init() {}

    open func Initialize(
        for app: ServerApp,
        with configurationBuilder: ConfigurationBuilder
    ) throws {}
}