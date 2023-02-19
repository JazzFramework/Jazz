import JazzConfiguration;

internal final class DefaultErrorTranslatorsInitializer: ServerInitializer {
    public required init() {}

    public override final func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(errorTranslator: { _, _ in
                return DataNotFoundErrorTranslator();
            })

            .wireUp(errorTranslator: { _, _ in
                return NotAcceptableErrorTranslator();
            })

            .wireUp(errorTranslator: { _, _ in
                return NotAuthorizedErrorTranslator();
            })

            .wireUp(errorTranslator: { _, _ in
                return NotAuthenticatedErrorTranslator();
            })

            .wireUp(errorTranslator: { _, _ in
                return UnsupportedMediaTypeErrorTranslator();
            })

            .wireUp(errorTranslator: { _, _ in
                return MissingBodyErrorTranslator();
            })

            .wireUp(errorTranslator: { _, _ in
                return LastResortErrorTranslator();
            });
    }
}