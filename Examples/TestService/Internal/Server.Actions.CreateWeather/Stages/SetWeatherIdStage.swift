import Foundation;

import Context;
import Flow;

internal final class SetWeatherIdStage: BaseStage {
    internal static let NAME: String = "\(SetWeatherIdStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(SetWeatherIdStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(SetWeatherIdStage.NAME) missing context");

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
            return SetWeatherIdStage.MISSING_CONTEXT_RESULT;
        }

        weatherContext.Value.Set(id: UUID().uuidString);

        return SetWeatherIdStage.SUCCESS_RESULT;
    }
}