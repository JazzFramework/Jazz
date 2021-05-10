import Context
import Flow

public class StringMutatorActionBuilder {
    private static let STRING_CONTEXT_RESOLVER: ContextResolver<FlowContext, StringContext> =
        ContextResolver<FlowContext, StringContext>();

    public init() {
    }

    public func Build() -> StringMutator {
        return StringMutatorAction(
            withFlow: BuildFlow(),
            withResultResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER
        );
    }

    private func BuildFlow() -> Flow {
        return FlowBuilder()
            .With(stage: BuildToUpperStage(), withName: ToUpperStage.NAME)
            .With(stage: BuildReverseStage(), withName: ReverseStage.NAME)
            .With(stage: BuildDuplicateStringStage(), withName: DuplicateStringStage.NAME)
            .With(initialStage: ToUpperStage.NAME)
            .Build();
    }

    private func BuildToUpperStage() -> ToUpperStage {
        return ToUpperStage(
            withContextResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER,
            withTransactions: [
                ToUpperStage.SUCCESS_RESULT: ReverseStage.NAME
            ]
        );
    }

    private func BuildReverseStage() -> ReverseStage {
        return ReverseStage(
            withContextResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER,
            withTransactions: [
                ReverseStage.SUCCESS_RESULT: DuplicateStringStage.NAME
            ]
        );
    }

    private func BuildDuplicateStringStage() -> DuplicateStringStage {
        return DuplicateStringStage(
            withContextResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER,
            withTransactions: [:]
        );
    }
}