import Context
import Flow

internal class ToUpperStage: BaseStage {
    internal static let NAME: String = "\(ToUpperStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(ToUpperStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(ToUpperStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, StringContext>;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, StringContext>,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;

        super.init(withTransactions: transactions);
    }

    open override func Execute(for context: FlowContext) -> StageResult {
        guard let stringContext: StringContext = _contextResolver.Resolve(for: context) else {
            return ToUpperStage.MISSING_CONTEXT_RESULT;
        }

        let mutatedValue: String = stringContext.GetValue().uppercased();

        context.Adopt(subcontext: StringContext(mutatedValue));

        return ToUpperStage.SUCCESS_RESULT;
    }
}