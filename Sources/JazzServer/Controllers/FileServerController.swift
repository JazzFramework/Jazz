import Foundation;

public final class FileServerController: Controller {
    private final let path: String;
    private final let local: String;

    public init(path: String, local: String) {
        self.path = path;
        self.local = local;

        super.init();
    }

    public final override func getMethod() -> HttpMethod {
        return .get;
    }

    public final override func getRoute() -> String {
        return path;
    }

    public final override func logic(withRequest request: RequestContext, intoResult result: ResultContext) async throws {
        var path: String = request.getRouteParameter(key: "path");
        if path == "" {
            path = "index.html";
        }

        let file: String = "\(local)/\(path)";
        let ext = file.components(separatedBy: ".").last;

        if !FileManager.default.fileExists(atPath: file) {
            result.set(statusCode: 404);
        } else if let inputStream: InputStream = InputStream(fileAtPath: file) {
            result.set(statusCode: 200);
            result.set(headerKey: "Content-Type", headerValue: MimeTypes.mimeType(ext: ext));

            result.getOutputStream().write(inputStream);
        } else {
            result.set(statusCode: 404);
        }
    }
}