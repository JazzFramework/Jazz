public protocol CreateWeather {
    func Create(weather: Weather) throws -> Weather;
};