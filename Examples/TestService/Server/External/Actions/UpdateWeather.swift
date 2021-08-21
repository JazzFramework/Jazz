import ExampleServerCommon;

public protocol UpdateWeather {
    func Update(weather: Weather) throws -> Weather;
};