public struct StageResult: Hashable {
    private let id: String;

    public init(as id: String) {
        self.id = id;
    }

    public func getId() -> String {
        return id;
    }

    public static func == (left: StageResult, right: StageResult) -> Bool {
        return left.getId() == right.getId();
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id);
    }
}