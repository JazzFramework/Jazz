import DataAccess;

public class GetWeathersActionImpl: GetWeathersAction {
    private let _repo: WeatherRepository;

    public init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Get() throws -> [Weather] {
        return try _repo.Get();
    }
}