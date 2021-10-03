import Foundation;

public protocol Encoder {
    func Encode(data: Any, for mediatype: MediaType, into stream: OutputStream) async -> Bool;

    func CanHandle(mediaType: MediaType) -> Bool;

    func CanHandle(data: Any) -> Bool;
}