internal final class LoggerImpl: Logger {
    private var loggerProvider: LoggerProvider;
    private var currentLevel: LogLevel = .verbose;

    internal init(loggerProvider: LoggerProvider) {
        self.loggerProvider = loggerProvider;
    }

    public final func set(logLevel: LogLevel) {
        currentLevel = logLevel;
    }

    public final func verbose(_ message: String, _ args: Any...) async {
        await publishLog(.verbose, message, args);
    }

    public final func debug(_ message: String, _ args: Any...) async {
        await publishLog(.debug, message, args);
    }

    public final func info(_ message: String, _ args: Any...) async {
        await publishLog(.info, message, args);
    }

    public final func warning(_ message: String, _ args: Any...) async {
        await publishLog(.warning, message, args);
    }

    public final func error(_ message: String, _ args: Any...) async {
        await publishLog(.error, message, args);
    }

    public final func fatal(_ message: String, _ args: Any...) async {
        await publishLog(.fatal, message, args);
    }

    private func publishLog(_ logLevel: LogLevel, _ message: String, _ args: Any...) async {
        if (logLevel.rawValue >= currentLevel.rawValue) {
            await loggerProvider.log(logLevel, message, args);
        }
    }
}