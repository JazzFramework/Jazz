public struct StageResult: Hashable {
    private let _id: String;

    public init(as id: String) {
        _id = id;
    }

    public func GetId() -> String {
        return _id;
    }

    public static func == (left: StageResult, right: StageResult) -> Bool {
        return left.GetId() == right.GetId();
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(_id);
    }
}