import Server;

public class ImpossibleWeatherErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case WeatherErrors.impossible = error {
            return true;
        }

        return false;
    }

    public override func Handle(error: Error) -> ApiError {
        switch(error) {
            case WeatherErrors.impossible(let reason):
                return ApiError(
                    withCode: 400,
                    withTitle: "Impossible Weather",
                    withDetails: "\(reason)",
                    withMetadata: [
                        "reason": reason
                    ]
                );

            default:
                return BuildUnknownError();
        }
    }
}