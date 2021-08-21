public protocol GetWeather {
    func Get(weatherId: String) throws -> Weather;
};