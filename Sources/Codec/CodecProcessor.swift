import Foundation;

public class CodecProcessor {
    private let _codecs: [Codec<Any>];

    internal init(withCodecs codecs: [Codec<Any>]) {
        _codecs = codecs;
    }

    public final func Decode<TType>(data: Stream, for mediaType: MediaType) -> TType? {
        let codec: Codec<Any>? = _codecs.first { [mediaType] in
            $0.CanHandle(mediaType: mediaType) &&
            $0.CanHandle(type: TType.self)
        };

        if let codec: Codec<Any> = codec {
            if let data: Any = codec.Decode(data: data, for: mediaType) {
                return data as? TType;
            }
        }

        return nil;
    }

    public final func Encode<TType>(data: TType, for mediaType: MediaType) -> Stream? {
        let codec: Codec<Any>? = _codecs.first { [mediaType] in
            $0.CanHandle(mediaType: mediaType) &&
            $0.CanHandle(type: TType.self)
        };

        if let codec: Codec<Any> = codec {
            return codec.Encode(data: data, for: mediaType);
        }

        return nil;
    }
}