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

    public func execute(withInput input: String) async throws -> String {
        let context = FlowContext();

        context.adopt(subcontext: StringContext(input));

        let result = try await _flow.execute(for: context);

        return try process(result: result, withContext: context);
    }

    private func process(
        result: FlowResult,
        withContext context: FlowContext
    ) throws -> String {
        switch (result.getStageResult().getId())
        {
            case DuplicateStringStage.SUCCESS_RESULT.getId():
                if let stringContext: StringContext = _resultResolver.resolve(for: context) {
                    return stringContext.value;
                }
                break;
            default:
                throw StringMutatorError.Unknown;
        }

        throw StringMutatorError.Unknown;
    }
}