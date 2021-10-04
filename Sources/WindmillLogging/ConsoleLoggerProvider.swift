import Foundation;

internal final class ConsoleLoggerProvider: LoggerProvider {
    private let utcDateFormatter: DateFormatter;

    internal init() {
        utcDateFormatter = DateFormatter();

        utcDateFormatter.dateStyle = .medium;
        utcDateFormatter.timeStyle = .medium;
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC");
    }

    public func log(_ level: LogLevel, _ message: String, _ args: Any...) async {
        let date: Date = Date();
        let dateTimeStr: String = utcDateFormatter.string(from: date);

        print("[\(level)] [\(dateTimeStr)] \(message)", args);
    }
}