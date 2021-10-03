import Foundation;

public protocol Decoder {
    func Decode(data: InputStream, for mediatype: MediaType) async -> Any?;

    func CanHandle(mediaType: MediaType) -> Bool;
}