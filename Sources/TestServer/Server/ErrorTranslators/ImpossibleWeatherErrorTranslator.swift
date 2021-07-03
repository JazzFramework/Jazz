import Server;

public class ImpossibleWeatherErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case WeatherErrors.impossible = error {
            return true;
        }

        return false;
    }

    public override func Handle(error: Error) -> ApiError {
        return ApiError(
            withCode: 400,
            withTitle: "Impossible Weather",
            withDetails: "Impossible Weather. Cannot Process.",
            withMetadata: [
                "Key1": "Value1",
                "Key2": "Value2",
                "Key3": "Value3"
            ]
        );
    }
}