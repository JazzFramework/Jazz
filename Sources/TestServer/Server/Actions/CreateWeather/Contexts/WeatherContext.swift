import Context

internal class WeatherContext: BaseContext {
    internal let Value: Weather;

    internal init(_ value: Weather) {
        Value = value;
    }
}