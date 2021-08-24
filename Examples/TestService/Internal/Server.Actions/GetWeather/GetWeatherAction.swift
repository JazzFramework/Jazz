import DataAccess;

import ExampleCommon;
import ExampleServer;

internal class GetWeatherAction: GetWeather {
    private let _repo: WeatherRepository;

    internal init(with repo: WeatherRepository) {
        _repo = repo;
    }

    public func Get(weatherId: String) throws -> Weather {
        return try _repo.Get(id: weatherId);
    }
}