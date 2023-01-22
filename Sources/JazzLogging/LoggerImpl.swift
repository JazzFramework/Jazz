internal final class LoggerImpl: Logger {
    private var loggerProvider: LoggerProvider;
    private var currentLevel: LogLevel = .verbose;

    internal init(loggerProvider: LoggerProvider) {
        self.loggerProvider = loggerProvider;
    }

    public final func set(logLevel: LogLevel) {
        currentLevel = logLevel;
    }

    public final func verbose(_ message: String, _ args: Any...) {
        publishLog(.verbose, message, args);
    }

    public final func debug(_ message: String, _ args: Any...) {
        publishLog(.debug, message, args);
    }

    public final func info(_ message: String, _ args: Any...) {
        publishLog(.info, message, args);
    }

    public final func warning(_ message: String, _ args: Any...) {
        publishLog(.warning, message, args);
    }

    public final func error(_ message: String, _ args: Any...) {
        publishLog(.error, message, args);
    }

    public final func fatal(_ message: String, _ args: Any...) {
        publishLog(.fatal, message, args);
    }

    private func publishLog(_ logLevel: LogLevel, _ message: String, _ args: Any...) {
        if (logLevel.rawValue >= currentLevel.rawValue) {
            loggerProvider.log(logLevel, message, args);
        }
    }
}