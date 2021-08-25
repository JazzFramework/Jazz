public protocol Configuration {
    func Fetch<TConfig>() -> TConfig?;
}