import Codec;

public final class ConfigurationBuilder {
    private var _supportedFiles: [String: MediaType];
    private var _decoders: [Decoder];

    public init() {
        _supportedFiles = [:];
        _decoders = [];
    }

    public func Build() -> Configuration {
        return ConfigurationImpl(with: _supportedFiles, with: _decoders);
    }

    public func With(file: String, for mediaType: MediaType) -> ConfigurationBuilder
    {
        _supportedFiles[file] = mediaType;

        return self;
    }

    public func With(decoder: Decoder) -> ConfigurationBuilder
    {
        _decoders.append(decoder);

        return self;
    }
}