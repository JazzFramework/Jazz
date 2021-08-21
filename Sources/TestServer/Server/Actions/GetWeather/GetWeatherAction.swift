import DataAccess;

public class GetWeatherAction: GetWeather {
    private let _repo: WeatherRepository;

    public init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Get(weatherId: String) throws -> Weather {
        return try _repo.Get(id: weatherId);
    }
}