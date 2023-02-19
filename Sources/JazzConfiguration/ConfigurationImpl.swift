import Foundation;

import JazzCodec;

internal final class ConfigurationImpl: Configuration {
    private let supportedFiles: [String: MediaType];
    private let decoders: [Decoder];
    private let bundle: Bundle;
    private let environment: Environment;

    private var configCache: [String: Any];

    internal init(
        with supportedFiles: [String: MediaType],
        with decoders: [Decoder],
        with bundle: Bundle,
        with environment: Environment
    ) {
        self.supportedFiles = supportedFiles;
        self.decoders = decoders;
        self.bundle = bundle;
        self.environment = environment;

        configCache = [:];
    }

    public final func fetch<TConfig>() async -> TConfig? {
        let key: String = String(describing: TConfig.self);

        if let config = configCache[key] {
            return config as? TConfig;
        }

        for (file, mediaType) in supportedFiles {
            for decoder in decoders {
                if decoder.canHandle(mediaType: mediaType) {
                    let envConfig = getEnvironmentConfig(for: file);

                    if
                        let requestStream: RequestStream = BundleResourceRequestStream(in: bundle, for: envConfig),
                        let result = await decoder.decode(data: requestStream, for: mediaType)
                    {
                        if result is TConfig {
                            configCache[key] = result;

                            return result as? TConfig;
                        }
                    } else if
                        let requestStream: RequestStream = BundleResourceRequestStream(in: bundle, for: file),
                        let result = await decoder.decode(data: requestStream, for: mediaType)
                    {
                        if result is TConfig {
                            configCache[key] = result;

                            return result as? TConfig;
                        }
                    }
                }
            }
        }

        return nil;
    }

    private final func getEnvironmentConfig(for file: String) -> String {
        return file;
    }
}