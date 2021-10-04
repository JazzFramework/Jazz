import Foundation;

open class Codec<T>: Transcoder {
    public init() {}

    open func decodeType(data: InputStream, for mediatype: MediaType) async -> T? {
        return nil;
    }

    open func encodeType(data: T, into stream: OutputStream, for mediatype: MediaType) async {}

    open func canHandle(mediaType: MediaType) -> Bool {
        return false;
    }

    open func canHandle(data: Any) -> Bool {
        return false;
    }
 
    public final func decode(data: InputStream, for mediatype: MediaType) async -> Any? {
        return await decodeType(data: data, for: mediatype);
    }

    public final func encode(data: Any, for mediatype: MediaType, into stream: OutputStream) async -> Bool {
        if let type = data as? T {
            await encodeType(data: type, into: stream, for: mediatype);

            return true;
        }

        return false;
    }
}