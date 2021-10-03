import Foundation;

open class Codec<T>: Transcoder {
    public init() {}

    open func DecodeType(data: InputStream, for mediatype: MediaType) async -> T? {
        return nil;
    }

    open func EncodeType(data: T, into stream: OutputStream, for mediatype: MediaType) async {}

    open func CanHandle(mediaType: MediaType) -> Bool {
        return false;
    }

    open func CanHandle(data: Any) -> Bool {
        return false;
    }
 
    public final func Decode(
        data: InputStream,
        for mediatype: MediaType
    ) async -> Any? {
        return await DecodeType(data: data, for: mediatype);
    }

    public final func Encode(
        data: Any,
        for mediatype: MediaType,
        into stream: OutputStream
    ) async -> Bool {
        if let type = data as? T {
            await EncodeType(data: type, into: stream, for: mediatype);

            return true;
        }

        return false;
    }
}