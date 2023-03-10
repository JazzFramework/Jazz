import JazzContext
import JazzFlow

internal class ToUpperStage: BaseStage {
    internal static let NAME: String = "\(ToUpperStage.self)"

    internal static let SUCCESS_RESULT: StageResult =
        StageResult(as: "\(ToUpperStage.NAME) success");

    internal static let MISSING_CONTEXT_RESULT: StageResult =
        StageResult(as: "\(ToUpperStage.NAME) missing context");

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
            return ToUpperStage.MISSING_CONTEXT_RESULT;
        }

        let mutatedValue: String = stringContext.value.uppercased();

        context.adopt(subcontext: StringContext(mutatedValue));

        return ToUpperStage.SUCCESS_RESULT;
    }
}