import ExampleCommon;
import ExampleServer;

public class UpdateWeatherAction: UpdateWeather {
    private let _repo: WeatherRepository;

    public init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Update(weather: Weather) throws -> Weather {
        return try _repo.Update(weather);
    }
}