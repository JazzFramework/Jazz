import Context;
import Flow;

import ExampleServerCommon;
import ExampleServerDataAccess;

internal class PersistWeatherStage: BaseStage {
    internal static let NAME: String = "\(PersistWeatherStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(PersistWeatherStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(PersistWeatherStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, WeatherContext>;
    private let _repository: WeatherRepository;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, WeatherContext>,
        withRepository repository: WeatherRepository,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;
        _repository = repository;

        super.init(withTransactions: transactions);
    }

    public override func Execute(for context: FlowContext) -> StageResult {
        guard let weatherContext: WeatherContext = _contextResolver.Resolve(for: context) else {
            return PersistWeatherStage.MISSING_CONTEXT_RESULT;
        }

        let result: Weather = try! _repository.Create(weatherContext.Value);

        context.Adopt(subcontext: WeatherContext(result));

        return PersistWeatherStage.SUCCESS_RESULT;
    }
}