public protocol GetWeatherAction {
    func Get(weatherId: String) throws -> Weather;
};