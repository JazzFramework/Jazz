public protocol GetWeatherAction {
    func GetWeather() throws -> Weather;
};