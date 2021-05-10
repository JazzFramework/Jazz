public struct FlowResult: Hashable {
    private let _stageResult: StageResult;

    public init(as stageResult: StageResult) {
        _stageResult = stageResult;
    }

    public func GetStageResult() -> StageResult {
        return _stageResult;
    }

    public static func == (left: FlowResult, right: FlowResult) -> Bool {
        return left.GetStageResult().GetId() == right.GetStageResult().GetId();
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(_stageResult);
    }
}