import Foundation;

import JazzCodec;

public final class ConfigurationBuilder {
    private var supportedFiles: [String: MediaType];
    private var decoders: [Decoder];
    private var bundle: Bundle?;

    public init() {
        supportedFiles = [:];
        decoders = [];
    }

    public func with(file: String, for mediaType: MediaType) -> ConfigurationBuilder {
        supportedFiles[file] = mediaType;

        return self;
    }

    public func with(decoder: Decoder) -> ConfigurationBuilder {
        decoders.append(decoder);

        return self;
    }

    public func with(bundle: Bundle) -> ConfigurationBuilder {
        self.bundle = bundle;

        return self;
    }

    public func build() throws -> Configuration {
        if let bundle = bundle {
            return ConfigurationImplementation(with: supportedFiles, with: decoders, with: bundle);
        }

        throw ConfigurationErrors.missingBundle(reason: "Could not load configuration without bundle.");
    }
}