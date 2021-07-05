public protocol CreateWeatherAction {
    func Create(weather: Weather) throws -> Weather;
};