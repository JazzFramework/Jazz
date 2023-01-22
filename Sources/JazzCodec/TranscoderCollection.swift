public protocol TranscoderCollection {
    func decode<T>(for mediaType: MediaType, from stream: RequestStream) async throws -> T;

    func encode<T>(_ data: T, for mediaTypes: [MediaType], to stream: ResultStream) async throws -> MediaType;
}