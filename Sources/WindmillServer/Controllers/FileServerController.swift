import WindmillCore;

public final class FileServerController: Controller {
    private final let path: String;
    private final let local: String;

    private final let fileCache: Cache<String, ResultContext>;

    public init(path: String, local: String, fileCache: Cache<String, ResultContext>) {
        self.path = path;
        self.local = local;
        self.fileCache = fileCache;

        super.init();
    }

    public final override func getMethod() -> HttpMethod {
        return .get;
    }

    public final override func getRoute() -> String {
        return path;
    }

    public final override func logic(withRequest request: RequestContext) async throws -> ResultContext {
        let key: String = "";

        if let result = await fileCache.fetch(for: key) {
            return result;
        }

        let fileResult: ResultContext = FileServerController.getResultContext(key);

        await fileCache.cache(for: key, with: fileResult);

        return fileResult;
    }

    private static func getResultContext(_ key: String) -> ResultContext {
        return ResultContextBuilder()
            .with(statusCode: 200)
            .build();
    }
}