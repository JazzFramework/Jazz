public final class PageHint: QueryHint {
    private let page: Int;
    private let size: Int;

    public init(_ page: Int, _ size: Int) {
        self.page = page;
        self.size = size;
    }

    public final func getPage() -> Int {
        return page;
    }

    public final func getSize() -> Int {
        return size;
    }
}