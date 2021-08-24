public class DefaultCodecsInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(transcoder: { _ in
                return ApiErrorV1JsonCodec();
            });
    }
}