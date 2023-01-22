public struct FlowResult: Hashable {
    private let stageResult: StageResult;

    public init(as stageResult: StageResult) {
        self.stageResult = stageResult;
    }

    public func getStageResult() -> StageResult {
        return stageResult;
    }

    public static func == (left: FlowResult, right: FlowResult) -> Bool {
        return left.getStageResult().getId() == right.getStageResult().getId();
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(stageResult);
    }
}