public final class MaxResultsHint: QueryHint {
    private let count: Int;

    public init(_ count: Int) {
        self.count = count;
    }

    public final func getCount() -> Int {
        return count;
    }
}