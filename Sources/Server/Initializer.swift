import Configuration;

open class Initializer {
    public required init() {}

    open func Initialize(
        for app: App,
        with configurationBuilder: ConfigurationBuilder
    ) throws {}
}