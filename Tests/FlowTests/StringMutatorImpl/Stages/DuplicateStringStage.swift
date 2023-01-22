import JazzContext
import JazzFlow

internal class DuplicateStringStage: BaseStage {
    internal static let NAME: String = "\(DuplicateStringStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(DuplicateStringStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(DuplicateStringStage.NAME) missing context");

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
            return DuplicateStringStage.MISSING_CONTEXT_RESULT;
        }

        let mutatedValue: String = "\(stringContext.value)\(stringContext.value)";

        context.adopt(subcontext: StringContext(mutatedValue));

        return DuplicateStringStage.SUCCESS_RESULT;
    }
}