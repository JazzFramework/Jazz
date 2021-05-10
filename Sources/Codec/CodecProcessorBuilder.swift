import Foundation;

public class CodecProcessorBuilder {
    private var _codecs: [Codec<Any>];

    public init() {
        _codecs = [];
    }

    public func With(codec: Codec<Any>) -> CodecProcessorBuilder {
        _codecs.append(codec);

        return self;
    }

    public func Build() -> CodecProcessor {
        return CodecProcessor(withCodecs: _codecs);
    }
}