import Context
import Flow

public class StringMutatorActionBuilder {
    private static let STRING_CONTEXT_RESOLVER: ContextResolver<FlowContext, StringContext> =
        ContextResolver<FlowContext, StringContext>();

    public init() {
    }

    public func build() -> StringMutator {
        return StringMutatorAction(
            withFlow: buildFlow(),
            withResultResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER
        );
    }

    private func buildFlow() -> Flow {
        return FlowBuilder()
            .with(stage: buildToUpperStage(), withName: ToUpperStage.NAME)
            .with(stage: buildReverseStage(), withName: ReverseStage.NAME)
            .with(stage: buildDuplicateStringStage(), withName: DuplicateStringStage.NAME)
            .with(initialStage: ToUpperStage.NAME)
            .build();
    }

    private func buildToUpperStage() -> ToUpperStage {
        return ToUpperStage(
            withContextResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER,
            withTransactions: [
                ToUpperStage.SUCCESS_RESULT: ReverseStage.NAME
            ]
        );
    }

    private func buildReverseStage() -> ReverseStage {
        return ReverseStage(
            withContextResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER,
            withTransactions: [
                ReverseStage.SUCCESS_RESULT: DuplicateStringStage.NAME
            ]
        );
    }

    private func buildDuplicateStringStage() -> DuplicateStringStage {
        return DuplicateStringStage(
            withContextResolver: StringMutatorActionBuilder.STRING_CONTEXT_RESOLVER,
            withTransactions: [:]
        );
    }
}