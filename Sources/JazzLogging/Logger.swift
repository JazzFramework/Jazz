public protocol Logger {
    func set(logLevel: LogLevel);

    func verbose(_ message: String, _ args: Any...);

    func debug(_ message: String, _ args: Any...);

    func info(_ message: String, _ args: Any...);

    func warning(_ message: String, _ args: Any...);

    func error(_ message: String, _ args: Any...);

    func fatal(_ message: String, _ args: Any...);
}