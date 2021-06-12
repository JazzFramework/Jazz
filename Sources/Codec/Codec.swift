import Foundation;

open class Codec<T>: Encoder, Decoder {
    public init() {}

    open func DecodeType(data: Stream, for mediatype: MediaType) -> T?
    {
        return nil;
    }

    open func EncodeType(data: T, into stream: TextOutputStream, for mediatype: MediaType)
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
            let stream: OutputStream = OutputStream();

            EncodeType(data: type, into: stream as! TextOutputStream, for: mediatype);

            return stream;
        }

        return nil;
    }
}