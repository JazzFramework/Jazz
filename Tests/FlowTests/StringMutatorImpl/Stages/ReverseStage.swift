import Context
import Flow

internal class ReverseStage: BaseStage {
    internal static let NAME: String = "\(ReverseStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(ReverseStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(ReverseStage.NAME) missing context");

    private let _contextResolver: ContextResolver<FlowContext, StringContext>;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, StringContext>,
        withTransactions transactions: [StageResult:String]
    ) {
        _contextResolver = contextResolver;

        super.init(withTransactions: transactions);
    }

    public override func execute(for context: FlowContext) async throws -> StageResult {
        guard let stringContext: StringContext = _contextResolver.Resolve(for: context) else {
            return ReverseStage.MISSING_CONTEXT_RESULT;
        }

        let mutatedValue: String = String(stringContext.value.reversed());

        context.adopt(subcontext: StringContext(mutatedValue));

        return ReverseStage.SUCCESS_RESULT;
    }
}