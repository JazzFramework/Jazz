open class BaseStage {
    private let transactions: [StageResult:String];

    public init(withTransactions transactions: [StageResult:String]) {
        self.transactions = transactions;
    }

    open func execute(for context: FlowContext) async throws -> StageResult {
        return StageResult(as: "success");
    }

    final public func getNextStage(for result: StageResult) -> String? {
        return transactions[result];
    }
}