public protocol Encoder {
    func encode(data: Any, for mediatype: MediaType, into stream: ResultStream) async -> Bool;

    func canHandle(mediaType: MediaType) -> Bool;

    func canHandle(data: Any) -> Bool;
}