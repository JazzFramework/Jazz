import Configuration;

internal final class DefaultErrorTranslatorsInitializer: ServerInitializer {
    public required init() {}

    public override final func Initialize(for app: ServerApp, with configurationBuilder: ConfigurationBuilder) throws {
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