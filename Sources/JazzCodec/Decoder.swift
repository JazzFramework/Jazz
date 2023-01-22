public protocol Decoder {
    func decode(data: RequestStream, for mediatype: MediaType) async -> Any?;

    func canHandle(mediaType: MediaType) -> Bool;
}