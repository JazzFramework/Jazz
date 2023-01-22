import JazzCodec;

internal final class ServerErrorV1HtmlCodec: Codec<ServerError> {
    private static let BUFFER_SIZE = 1024;

    private final let templatingEngine: TemplatingEngine;

    internal init(templatingEngine: TemplatingEngine) {
        self.templatingEngine = templatingEngine;
    }

    private static let SupportedMediaType: MediaType =
        MediaType(withType: "text", withSubtype: "html");

    public final override func canHandle(data: Any) -> Bool {
        return data is ServerError;
    }

    public final override func canHandle(mediaType: MediaType) -> Bool {
        return ServerErrorV1HtmlCodec.SupportedMediaType == mediaType;
    }

    public final override func decodeType(data: RequestStream, for mediatype: MediaType) async -> ServerError? {
        return nil;
    }

    public final override func encodeType(data: ServerError, into stream: ResultStream, for mediatype: MediaType) async {
        do {
            let htmlStream: HtmlStream = try await templatingEngine.run(template: getTemplateName(data), ["error": data]);

            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: ServerErrorV1HtmlCodec.BUFFER_SIZE);
            defer {
                buffer.deallocate();
            }

            while htmlStream.hasData() {
                let read = htmlStream.read(into: buffer, maxLength: ServerErrorV1HtmlCodec.BUFFER_SIZE);

                if read <= 0 {
                    break;
                }

                stream.write(buffer, maxLength: read);
            }
        } catch {
            print("\(error)");

            //TODO: handle
            stream.write("error");
        }
    }

    private final func getTemplateName(_ data: ServerError) -> String {
        if templatingEngine.templateExist("Views/Errors/\(data.getCode()).html") {
            return "Views/Errors/\(data.getCode()).html";
        }

        return "Views/Errors/Error.html";
    }
}