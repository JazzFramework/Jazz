public protocol LoggerProvider {
    func log(_ level: LogLevel, _ message: String, _ args: Any...);
}