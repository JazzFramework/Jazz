import WindmillConfiguration;

internal final class DefaultErrorTranslatorsInitializer: ServerInitializer {
    public required init() {}

    public override final func initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(errorTranslator: { _ in
                return DataNotFoundErrorTranslator();
            })

            .wireUp(errorTranslator: { _ in
                return NotAcceptableErrorTranslator();
            })

            .wireUp(errorTranslator: { _ in
                return UnsupportedMediaTypeErrorTranslator();
            })

            .wireUp(errorTranslator: { _ in
                return MissingBodyErrorTranslator();
            })

            .wireUp(errorTranslator: { _ in
                return LastResortErrorTranslator();
            });
    }
}