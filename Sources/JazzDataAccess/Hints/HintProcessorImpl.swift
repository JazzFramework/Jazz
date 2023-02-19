 public final class HintProcessorImpl<TResource: Storable>: HintProcessor<TResource> {
    private let hintHandlers: [HintHandler<TResource>]

    public init(hintHandlers: [HintHandler<TResource>]) {
        self.hintHandlers = hintHandlers;
    }

    public override final func handle(for query: Query<TResource>, with hints: [QueryHint]) throws {
        for hint in hints {
            for hintHandler in hintHandlers {
                if hintHandler.canHandle(query) && hintHandler.canHandle(hint) {
                    try hintHandler.handle(for: query, with: hint);
                }
            }
        }
    }
}