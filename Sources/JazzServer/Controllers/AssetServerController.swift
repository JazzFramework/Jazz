import Foundation;

public final class AssetServerController: Controller {
    private final let path: String;
    private final let local: String;
    private final let bundle: Bundle;

    public init(path: String, local: String, bundle: Bundle) {
        self.path = path;
        self.local = local;
        self.bundle = bundle;

        super.init();
    }

    public final override func getMethod() -> HttpMethod {
        return .get;
    }

    public final override func getRoute() -> String {
        return path;
    }

    public final override func logic(withRequest request: RequestContext, intoResult result: ResultContext) async throws {
        let path: String = request.getRouteParameter(key: "path");
        let file: String = path == "" ? local: "\(local)/\(path)";

        let ext = file.components(separatedBy: ".").last;

        if let path = bundle.path(forResource: file, ofType: nil) {
            if let inputStream = InputStream(fileAtPath: path) {
                result.set(statusCode: 200);
                result.set(headerKey: "Content-Type", headerValue: MimeTypes.mimeType(ext: ext));

                result.getOutputStream().write(inputStream);
            } else {
                result.set(statusCode: 404);
            }
        } else {
            result.set(statusCode: 404);
        }
    }
}