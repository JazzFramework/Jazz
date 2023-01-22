import JazzConfiguration;

open class ServerInitializer {
    public required init() {}

    open func initialize(
        for app: ServerApp,
        with configurationBuilder: ConfigurationBuilder
    ) throws {}
}