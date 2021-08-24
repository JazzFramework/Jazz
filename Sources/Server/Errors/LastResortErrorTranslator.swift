internal final class LastResortErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        return true;
    }

    public override func Translate(error: Error) -> ApiError {
        return BuildUnknownError();
    }
}