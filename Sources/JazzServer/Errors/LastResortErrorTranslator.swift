internal final class LastResortErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        return true;
    }

    public override func translate(error: Error) -> ServerError {
        return buildUnknownError();
    }
}