import Context
import Flow

internal class StringMutatorAction: StringMutator {
    private let _flow: Flow;
    private let _resultResolver: ContextResolver<FlowContext, StringContext>;

    internal init(
        withFlow flow: Flow,
        withResultResolver resultResolver: ContextResolver<FlowContext, StringContext>
    ) {
        _flow = flow;
        _resultResolver = resultResolver;
    }

    public func Execute(withInput input: String) throws -> String {
        let context = FlowContext();

        context.Adopt(subcontext: StringContext(input));

        let result = _flow.Execute(for: context);

        return try Process(result: result, withContext: context);
    }

    private func Process(
        result: FlowResult,
        withContext context: FlowContext
    ) throws -> String {
        switch (result.GetStageResult().GetId())
        {
            case DuplicateStringStage.SUCCESS_RESULT.GetId():
                if let stringContext: StringContext = _resultResolver.Resolve(for: context) {
                    return stringContext.GetValue();
                }
                break;
            default:
                throw StringMutatorError.Unknown;
        }

        throw StringMutatorError.Unknown;
    }
}