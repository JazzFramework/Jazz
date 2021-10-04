import Foundation;

public protocol Decoder {
    func decode(data: InputStream, for mediatype: MediaType) async -> Any?;

    func canHandle(mediaType: MediaType) -> Bool;
}