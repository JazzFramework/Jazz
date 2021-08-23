internal final class DefaultErrorTranslatorsInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(errorTranslator: { _ in
                return DataNotFoundErrorTranslator();
            })

            .WireUp(errorTranslator: { _ in
                return NotAcceptableErrorTranslator();
            })

            .WireUp(errorTranslator: { _ in
                return UnsupportedMediaTypeErrorTranslator();
            })

            .WireUp(errorTranslator: { _ in
                return MissingBodyErrorTranslator();
            })

            .WireUp(errorTranslator: { _ in
                return LastResortErrorTranslator();
            });
    }
}