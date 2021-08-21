import ExampleServer;
import ExampleServerDataAccess;

public class DeleteWeatherAction: DeleteWeather {
    private let _repo: WeatherRepository;

    public init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Delete(weatherId: String) throws {
        try _repo.Delete(id: weatherId);
    }
}