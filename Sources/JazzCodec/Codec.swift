open class Codec<T>: Transcoder {
    public init() {}

    open func decodeType(data: RequestStream, for mediatype: MediaType) async -> T? {
        return nil;
    }

    open func encodeType(data: T, into stream: ResultStream, for mediatype: MediaType) async {}

    open func canHandle(mediaType: MediaType) -> Bool {
        return false;
    }

    open func canHandle(data: Any) -> Bool {
        return false;
    }
 
    public final func decode(data: RequestStream, for mediatype: MediaType) async -> Any? {
        return await decodeType(data: data, for: mediatype);
    }

    public final func encode(data: Any, for mediatype: MediaType, into stream: ResultStream) async -> Bool {
        if let type = data as? T {
            await encodeType(data: type, into: stream, for: mediatype);

            return true;
        }

        return false;
    }
}