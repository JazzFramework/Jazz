import Foundation;

import Codec;

public final class ConfigurationManager {
    private var _supportedFiles: [String: MediaType];
    private var _decoders: [Decoder];

    public init() {
        _supportedFiles = [:];
        _decoders = [];
    }

    public func FetchConfig<TConfig>(for file: String) -> TConfig? {
        if let mediaType = _supportedFiles[file] {
            for decoder in _decoders {
                if decoder.CanHandle(mediaType: mediaType) {
                    if let stream = InputStream(fileAtPath: file) {
                        stream.open();

                        defer {
                            stream.close();
                        }

                        if let result = decoder.Decode(data: stream, for: mediaType) {
                            if result is TConfig {
                                return result as? TConfig;
                            }
                        }
                    }
                }
            }
        }

        return nil;
    }

    public func Add(decoder: Decoder) -> ConfigurationManager {
        _decoders.append(decoder);

        return self;
    }

    public func Add(file: String, for mediaType: MediaType) -> ConfigurationManager {
        _supportedFiles[file] = mediaType;

        return self;
    }
}