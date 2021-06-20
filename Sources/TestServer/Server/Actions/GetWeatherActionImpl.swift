public class GetWeatherActionImpl: GetWeatherAction {
    public func GetWeather() throws -> Weather {
        return Weather("2");
    }
}