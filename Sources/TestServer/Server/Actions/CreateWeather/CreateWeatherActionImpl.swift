public class CreateWeatherActionImpl: CreateWeatherAction {
    private let _repo: WeatherRepository;

    public init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Create(weather: Weather) throws -> Weather {
        return try _repo.Create(weather);
    }
}