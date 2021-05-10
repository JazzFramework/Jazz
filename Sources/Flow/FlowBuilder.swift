public class FlowBuilder {
    private var _stages: [String:BaseStage] = [:];
    private var _initialStage: String = "";

    public init() {
    }

    public func With(stage: BaseStage, withName name: String) -> FlowBuilder {
        _stages[name] = stage;

        return self;
    }

    public func With(initialStage: String) -> FlowBuilder {
        _initialStage = initialStage;

        return self;
    }

    public func Build() -> Flow {
        return Flow(hasStages: _stages, withInitialStage: _initialStage);
    }
}