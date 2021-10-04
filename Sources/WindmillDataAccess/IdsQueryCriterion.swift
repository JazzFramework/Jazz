public final class IdsQueryCriterion: QueryCriterion {
    private let ids: [String];

    public init(_ ids: [String]) {
        self.ids = ids;
    }

    public final func getIds() -> [String] {
        return ids;
    }
}