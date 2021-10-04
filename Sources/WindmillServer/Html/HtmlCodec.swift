import Foundation;

import WindmillCodec;

internal final class HtmlCodec: Codec<HtmlStream> {
    private static let SupportedMediaType: MediaType =
        MediaType(withType: "text", withSubtype: "html");

    public final override func canHandle(data: Any) -> Bool {
        return data is HtmlStream;
    }

    public final override func canHandle(mediaType: MediaType) -> Bool {
        return HtmlCodec.SupportedMediaType == mediaType;
    }

    public final override func decodeType(data: InputStream, for mediatype: MediaType) async -> HtmlStream? {
        return HtmlStream();
    }

    public final override func encodeType(data: HtmlStream, into stream: OutputStream, for mediatype: MediaType) async {
    }
}