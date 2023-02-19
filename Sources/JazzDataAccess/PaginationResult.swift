public final class PaginationResult<TResource: Storable> {
    private final let data: [TResource];
    private final let page: Int;
    private final let total: Int;

    public init(data: [TResource], page: Int, total: Int) {
        self.data = data;
        self.page = page;
        self.total = total;
    }

    public final func getData() -> [TResource] {
        return data;
    }

    public final func getPage() -> Int {
        return page;
    }

    public final func getTotal() -> Int {
        return total;
    }

    public final func getPageSize() -> Int {
        return data.count;
    }
}