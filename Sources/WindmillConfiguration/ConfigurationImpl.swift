import Foundation;

import WindmillCodec;

internal final class ConfigurationImplementation: Configuration {
    private let _supportedFiles: [String: MediaType];
    private let _decoders: [Decoder];
    private let _bundle: Bundle;

    private var _configCache: [String: Any];

    internal init(
        with supportedFiles: [String: MediaType],
        with decoders: [Decoder],
        with bundle: Bundle    
    ) {
        _supportedFiles = supportedFiles;
        _decoders = decoders;
        _bundle = bundle;

        _configCache = [:];
    }

    public func fetch<TConfig>() async -> TConfig? {
        let key: String = String(describing: TConfig.self);

        if let config = _configCache[key] {
            return config as? TConfig;
        }

        for (file, mediaType) in _supportedFiles {
            for decoder in _decoders {
                if decoder.canHandle(mediaType: mediaType) {
                    if let url = _bundle.url(forResource: file, withExtension: nil) {
                        if let stream = InputStream(url: url) {
                            stream.open();

                            defer {
                                stream.close();
                            }

                            if let result = await decoder.decode(data: stream, for: mediaType) {
                                if result is TConfig {
                                    _configCache[key] = result;

                                    return result as? TConfig;
                                }
                            }
                        }
                    }
                }
            }
        }

        return nil;
    }
}