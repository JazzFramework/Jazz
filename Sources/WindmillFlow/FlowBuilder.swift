public class FlowBuilder {
    private var _stages: [String:BaseStage] = [:];
    private var _initialStage: String = "";

    public init() {
    }

    public func with(stage: BaseStage, withName name: String) -> FlowBuilder {
        _stages[name] = stage;

        return self;
    }

    public func with(initialStage: String) -> FlowBuilder {
        _initialStage = initialStage;

        return self;
    }

    public func build() -> Flow {
        return Flow(hasStages: _stages, withInitialStage: _initialStage);
    }
}