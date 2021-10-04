public struct FlowResult: Hashable {
    private let _stageResult: StageResult;

    public init(as stageResult: StageResult) {
        _stageResult = stageResult;
    }

    public func getStageResult() -> StageResult {
        return _stageResult;
    }

    public static func == (left: FlowResult, right: FlowResult) -> Bool {
        return left.getStageResult().getId() == right.getStageResult().getId();
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(_stageResult);
    }
}