public protocol Configuration {
    func fetch<TConfig>() async -> TConfig?;
}