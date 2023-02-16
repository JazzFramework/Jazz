import JazzContext
import JazzFlow

internal class ReverseStage: BaseStage {
    internal static let NAME: String = "\(ReverseStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(ReverseStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(ReverseStage.NAME) missing context");

    private final let contextResolver: ContextResolver<FlowContext, StringContext>;

    internal init(
        withContextResolver contextResolver: ContextResolver<FlowContext, StringContext>,
        withTransactions transactions: [StageResult:String]
    ) {
        self.contextResolver = contextResolver;

        super.init(withTransactions: transactions);
    }

    public override func execute(for context: FlowContext) async throws -> StageResult {
        guard let stringContext: StringContext = contextResolver.resolve(for: context) else {
            return ReverseStage.MISSING_CONTEXT_RESULT;
        }

        let mutatedValue: String = String(stringContext.value.reversed());

        context.adopt(subcontext: StringContext(mutatedValue));

        return ReverseStage.SUCCESS_RESULT;
    }
}