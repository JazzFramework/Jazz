import Context;
import Flow;

public class CreateWeatherActionBuilder {
    private static let WEATHER_CONTEXT_RESOLVER: ContextResolver<FlowContext, WeatherContext> =
        ContextResolver<FlowContext, WeatherContext>();

    private let _repository: WeatherRepository;

    public init(with repository: WeatherRepository) {
        _repository = repository;
    }

    public func Build() -> CreateWeather {
        return CreateWeatherAction(
            withFlow: BuildFlow(),
            withResultResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER
        );
    }

    private func BuildFlow() -> Flow {
        return FlowBuilder()
            .With(stage: BuildValidateWeatherStage(), withName: ValidateWeatherStage.NAME)
            .With(stage: BuildSetWeatherIdStage(), withName: SetWeatherIdStage.NAME)
            .With(stage: BuildPersistWeatherStage(), withName: PersistWeatherStage.NAME)
            .With(initialStage: ValidateWeatherStage.NAME)
            .Build();
    }

    private func BuildValidateWeatherStage() -> ValidateWeatherStage {
        return ValidateWeatherStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withTransactions: [
                ValidateWeatherStage.SUCCESS_RESULT: SetWeatherIdStage.NAME
            ]
        );
    }

    private func BuildSetWeatherIdStage() -> SetWeatherIdStage {
        return SetWeatherIdStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withTransactions: [
                SetWeatherIdStage.SUCCESS_RESULT: PersistWeatherStage.NAME
            ]
        );
    }

    private func BuildPersistWeatherStage() -> PersistWeatherStage {
        return PersistWeatherStage(
            withContextResolver: CreateWeatherActionBuilder.WEATHER_CONTEXT_RESOLVER,
            withRepository: _repository,
            withTransactions: [:]
        );
    }
}