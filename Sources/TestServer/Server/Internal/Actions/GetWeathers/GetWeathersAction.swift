import DataAccess;

public class GetWeathersAction: GetWeathers {
    private let _repo: WeatherRepository;

    public init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Get() throws -> [Weather] {
        return try _repo.Get();
    }
}