import Foundation;

import JazzCodec;

public final class ConfigurationBuilder {
    private var supportedFiles: [String: MediaType];
    private var decoders: [Decoder];
    private var bundle: Bundle?;
    private var environment: Environment = EnvironmentImpl();

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

    public func with(environment: Environment) -> ConfigurationBuilder {
        self.environment = environment;

        return self;
    }

    public func build() throws -> Configuration {
        guard let bundle else {
            throw ConfigurationErrors.missingBundle(reason: "Could not load configuration without bundle and environment.");
        }

        return ConfigurationImpl(with: supportedFiles, with: decoders, with: bundle, with: environment);
    }
}