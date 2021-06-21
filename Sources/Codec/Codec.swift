import Foundation;

open class Codec<T>: Encoder, Decoder {
    public init() {}

    open func DecodeType(data: InputStream, for mediatype: MediaType) -> T?
    {
        return nil;
    }

    open func EncodeType(data: T, into stream: OutputStream, for mediatype: MediaType)
    {
    }

    open func CanHandle(mediaType: MediaType) -> Bool {
        return false;
    }

    open func CanHandle(data: Any) -> Bool
    {
        return false;
    }

    public final func Decode(data: InputStream, for mediatype: MediaType) -> Any? {
        return DecodeType(data: data, for: mediatype);
    }

    public final func Encode(
        data: Any,
        for mediatype: MediaType,
        into stream: OutputStream
    ) -> Bool {
        if let type = data as? T {
            EncodeType(data: type, into: stream, for: mediatype);

            return true;
        }

        return false;
    }
}