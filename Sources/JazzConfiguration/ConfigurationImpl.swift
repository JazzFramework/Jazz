import Foundation;

import JazzCodec;

internal final class ConfigurationImplementation: Configuration {
    private let supportedFiles: [String: MediaType];
    private let decoders: [Decoder];
    private let bundle: Bundle;

    private var configCache: [String: Any];

    internal init(
        with supportedFiles: [String: MediaType],
        with decoders: [Decoder],
        with bundle: Bundle    
    ) {
        self.supportedFiles = supportedFiles;
        self.decoders = decoders;
        self.bundle = bundle;

        configCache = [:];
    }

    public func fetch<TConfig>() async -> TConfig? {
        let key: String = String(describing: TConfig.self);

        if let config = configCache[key] {
            return config as? TConfig;
        }

        for (file, mediaType) in supportedFiles {
            for decoder in decoders {
                if
                    decoder.canHandle(mediaType: mediaType),
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

        return nil;
    }
}