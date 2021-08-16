import Context

internal class WeatherContext: BaseContext {
    public let Value: Weather;

    internal init(_ value: Weather) {
        Value = value;
    }
}