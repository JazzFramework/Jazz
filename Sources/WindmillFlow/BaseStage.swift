open class BaseStage {
    private let _transactions: [StageResult:String];

    public init(withTransactions transactions: [StageResult:String]) {
        _transactions = transactions;
    }

    open func execute(for context: FlowContext) async throws -> StageResult {
        return StageResult(as: "success");
    }

    final public func getNextStage(for result: StageResult) -> String? {
        return _transactions[result];
    }
}