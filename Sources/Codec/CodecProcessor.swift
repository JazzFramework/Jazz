import Foundation;

public class CodecProcessor {
    private let _codecs: [Codec<Any>];

    internal init(withCodecs codecs: [Codec<Any>]) {
        _codecs = codecs;
    }

    public final func Decode(data: Stream, for mediaType: MediaType) -> Any? {
        if let codec: Codec<Any> = _codecs.first(where: {
            $0.CanHandle(mediaType: mediaType) &&
            $0.CanHandle(mediaType: mediaType)
        })
        {
            return codec.Decode(data: data, for: mediaType);
        }

        return nil;
    }

    public final func Encode(data: Any, for mediaType: MediaType) -> Stream? {
        if let codec: Codec<Any> = _codecs.first(where: { [mediaType] in
            $0.CanHandle(mediaType: mediaType) &&
            $0.CanHandle(mediaType: mediaType)
        })
        {
            return codec.Encode(data: data, for: mediaType);
        }

        return nil;
    }
}