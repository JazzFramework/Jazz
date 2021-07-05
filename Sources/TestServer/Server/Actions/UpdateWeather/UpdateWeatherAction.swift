public protocol UpdateWeatherAction {
    func Update(weather: Weather) throws -> Weather;
};