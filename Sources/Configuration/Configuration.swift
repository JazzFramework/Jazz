public protocol Configuration {
    func Fetch<TConfig>() async -> TConfig?;
}