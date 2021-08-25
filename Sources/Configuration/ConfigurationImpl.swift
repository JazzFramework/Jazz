import Foundation;

import Codec;

internal final class ConfigurationImpl: Configuration {
    private let _supportedFiles: [String: MediaType];
    private let _decoders: [Decoder];

    internal init(with supportedFiles: [String: MediaType], with decoders: [Decoder]) {
        _supportedFiles = supportedFiles;
        _decoders = decoders;
    }

    public func Fetch<TConfig>() -> TConfig? {
        for (file, mediaType) in _supportedFiles {
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
}