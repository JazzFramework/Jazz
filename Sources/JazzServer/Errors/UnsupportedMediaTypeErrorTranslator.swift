import JazzCodec;

internal final class UnsupportedMediaTypeErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case CodecErrors.cantDecode = error {
            return true;
        }

        if case HttpErrors.unsupportedMediaType = error {
            return true;
        }

        return false
    }

    public override func translate(error: Error) -> ServerError {
        return ServerErrorBuilder()
            .with(code: 415)
            .with(title: "UnsupportedMediaType")
            .with(details: "UnsupportedMediaType")
            .build();
    }
}