public protocol Logger {
    func set(logLevel: LogLevel);

    func verbose(_ message: String, _ args: Any...) async;

    func debug(_ message: String, _ args: Any...) async;

    func info(_ message: String, _ args: Any...) async;

    func warning(_ message: String, _ args: Any...) async;

    func error(_ message: String, _ args: Any...) async;

    func fatal(_ message: String, _ args: Any...) async;
}