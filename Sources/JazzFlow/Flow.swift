/// A class that handles the processing of writed up stages. We refer to these stages wired up in a meaningful way as a flow.
public class Flow {
    /// The max number of stage executation that can be run in a flow before we'll assume we're in an infinte loop.
    static let MAX_ITERATIONS: Int = 5_000;

    /// A StageResult indicating that nothing ran.
    static let NOT_RUN_RESULT: StageResult =
        StageResult(as: "NOT_RUN");

    /// A StageResult indicating that the flow was interrupted because we believe it was stuck in an infinite loop.
    static let TOO_MANY_ITERATIONS_RESULT: StageResult =
        StageResult(as: "TOO_MANY_ITERATIONS");

    /// A dictionary of usable stages for the flow. Keyed by the stage's unique name.
    private let stages: [String:BaseStage];

    /// A string of the unique stage name that will be executed first in the flow
    private let initialStage: String;

    /**
    Constructor

     - Parameters:
        - hasStages: A dictionary of stages keyed by the stage's unique name. These stages will become usable in the flow.
        - withInitialStage: A string of the unique stage name that will be executed first in the flow.
     */
    internal init(hasStages stages: [String:BaseStage], withInitialStage initialStage: String) {
        self.stages = stages;
        self.initialStage = initialStage;
    }

    /**
    Runs the flow for the passed in data contained in a FlowContext.

     - Parameters:
        - for: A flow context that contains the state data used when executing the flow.

    - Returns: A FlowResult containing details related to the flow execution.
     */
    public func execute(for context: FlowContext) async throws -> FlowResult {
        var counter: Int = 0;
        var nextStage: String? = initialStage;
        var result: StageResult = Flow.NOT_RUN_RESULT;

        while nextStage != nil {
            if counter > Flow.MAX_ITERATIONS {
                result = Flow.TOO_MANY_ITERATIONS_RESULT;
                break;
            }

            if let stage = stages[nextStage!] {
                result = try await stage.execute(for: context);

                nextStage = stage.getNextStage(for: result);
            }

            counter += 1;
        }

        return FlowResult(as: result);
    }
}