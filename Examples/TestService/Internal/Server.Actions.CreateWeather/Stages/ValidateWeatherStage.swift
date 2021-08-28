import Context;
import Flow;

import ExampleServer;

internal final class ValidateWeatherStage: BaseStage {
    internal static let NAME: String = "\(ValidateWeatherStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(ValidateWeatherStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(ValidateWeatherStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, WeatherContext>;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, WeatherContext>,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;

        super.init(withTransactions: transactions);
    }

    public override func Execute(for context: FlowContext) throws -> StageResult {
        guard let weatherContext: WeatherContext = _contextResolver.Resolve(for: context) else {
            return ValidateWeatherStage.MISSING_CONTEXT_RESULT;
        }

        if weatherContext.Value.Temp == "" {
            throw WeatherErrors.invalidTemp(reason: "missing temp");
        }

        return ValidateWeatherStage.SUCCESS_RESULT;
    }
}