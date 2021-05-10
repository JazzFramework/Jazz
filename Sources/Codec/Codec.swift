import Foundation;

open class Codec<T>: Encoder, Decoder {
    open func DecodeType(data: Stream, for mediatype: MediaType) -> T?
    {
        return nil;
    }

    open func EncodeType(data: T, into stream: Stream, for mediatype: MediaType)
    {
    }

    open func CanHandle(mediaType: MediaType) -> Bool {
        return false;
    }
    
    public final func CanHandle<TType>(type: TType.Type) -> Bool {
        return type == T.self;
    }

    public final func Decode(data: Stream, for mediatype: MediaType) -> Any? {
        return DecodeType(data: data, for: mediatype);
    }

    public final func Encode(data: Any, for mediatype: MediaType) -> Stream? {
        if let type = data as? T {
            let stream: Stream = Stream();

            EncodeType(data: type, into: stream, for: mediatype);

            return stream;
        }

        return nil;
    }
}