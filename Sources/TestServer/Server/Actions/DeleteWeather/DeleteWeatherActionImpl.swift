public class DeleteWeatherActionImpl: DeleteWeatherAction {
    private let _repo: WeatherRepository;

    public init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Delete(weatherId: String) throws {
        try _repo.Delete(id: weatherId);
    }
}