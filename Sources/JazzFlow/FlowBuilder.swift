public class FlowBuilder {
    private var stages: [String:BaseStage] = [:];
    private var initialStage: String = "";

    public init() {
    }

    public func with(stage: BaseStage, withName name: String) -> FlowBuilder {
        stages[name] = stage;

        return self;
    }

    public func with(initialStage: String) -> FlowBuilder {
        self.initialStage = initialStage;

        return self;
    }

    public func build() -> Flow {
        return Flow(hasStages: stages, withInitialStage: initialStage);
    }
}