public final class IdQueryCriterion: QueryCriterion {
    private let id: String;

    public init(_ id: String) {
        self.id = id;
    }

    public final func getId() -> String {
        return id;
    }
}