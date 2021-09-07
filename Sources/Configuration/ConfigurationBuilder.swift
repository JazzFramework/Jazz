import Foundation;

import Codec;

public final class ConfigurationBuilder {
    private var _supportedFiles: [String: MediaType];
    private var _decoders: [Decoder];
    private var _bundle: Bundle?;

    public init() {
        _supportedFiles = [:];
        _decoders = [];
    }

    public func Build() throws -> Configuration {
        if let bundle = _bundle
        {
            return ConfigurationImplementation(
                with: _supportedFiles,
                with: _decoders,
                with: bundle
            );
        }

        throw ConfigurationErrors.missingBundle(reason: "Could not load configuration without bundle.");
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

    public func With(bundle: Bundle) -> ConfigurationBuilder
    {
        _bundle = bundle;

        return self;
    }
}