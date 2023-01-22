import JazzCodec;

internal final class NotAcceptableErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case CodecErrors.cantEncode = error {
            return true;
        }

        if case HttpErrors.notAcceptable = error {
            return true;
        }

        return false
    }

    public override func translate(error: Error) -> ServerError {
        return ServerErrorBuilder()
            .with(code: 406)
            .with(title: "Not Acceptable")
            .with(details: "Not Acceptable")
            .build();
    }
}