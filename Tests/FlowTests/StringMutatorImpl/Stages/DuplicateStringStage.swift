import Context
import Flow

internal class DuplicateStringStage: BaseStage {
    internal static let NAME: String = "\(DuplicateStringStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(DuplicateStringStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(DuplicateStringStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, StringContext>;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, StringContext>,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;

        super.init(withTransactions: transactions);
    }

    public override func Execute(for context: FlowContext) -> StageResult {
        guard let stringContext: StringContext = _contextResolver.Resolve(for: context) else {
            return DuplicateStringStage.MISSING_CONTEXT_RESULT;
        }

        let mutatedValue: String = "\(stringContext.Value)\(stringContext.Value)";

        context.Adopt(subcontext: StringContext(mutatedValue));

        return DuplicateStringStage.SUCCESS_RESULT;
    }
}