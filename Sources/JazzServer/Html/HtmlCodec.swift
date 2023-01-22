import Foundation;

import JazzCodec;

internal final class HtmlCodec: Codec<HtmlStream> {
    private static let BUFFER_SIZE = 1024;

    private static let SupportedMediaType: MediaType =
        MediaType(withType: "text", withSubtype: "html");

    public final override func canHandle(data: Any) -> Bool {
        return data is HtmlStream;
    }

    public final override func canHandle(mediaType: MediaType) -> Bool {
        return HtmlCodec.SupportedMediaType == mediaType;
    }

    public final override func decodeType(data: RequestStream, for mediatype: MediaType) async -> HtmlStream? {
        return EmptyHtmlStream();
    }

    public final override func encodeType(data: HtmlStream, into stream: ResultStream, for mediatype: MediaType) async {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: HtmlCodec.BUFFER_SIZE);
        defer {
            buffer.deallocate();
        }

        while data.hasData() {
            let read = data.read(into: buffer, maxLength: HtmlCodec.BUFFER_SIZE);

            if read <= 0 {
                break;
            }

            stream.write(buffer, maxLength: read);
        }
    }
}