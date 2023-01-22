public final class TranscoderCollectionImpl : TranscoderCollection {
    private let transcoders: [Transcoder];

    public init(transcoders: [Transcoder]) {
        self.transcoders = transcoders;
    }

    public final func decode<T>(
        for mediaType: MediaType,
        from stream: RequestStream
    ) async throws -> T {
        for transcoder in transcoders {
            if transcoder.canHandle(mediaType: mediaType) {
                if let result = await transcoder.decode(data: stream, for: mediaType) {
                    if let typedResult = result as? T {
                        return typedResult;
                    }
                }
            }
        }

        throw CodecErrors.cantDecode;
    }

    public final func encode<T>(
        _ data: T,
        for mediaTypes: [MediaType],
        to stream: ResultStream
    ) async throws -> MediaType {
        for mediaType in mediaTypes {
            for transcoder in transcoders {
                if transcoder.canHandle(mediaType: mediaType) && transcoder.canHandle(data: data) {
                    if await transcoder.encode(data: data, for: mediaType, into: stream) {
                        return mediaType;
                    }
                }
            }
        }

        throw CodecErrors.cantEncode;
    }
}