import Foundation;

public protocol Encoder {
    func CanHandle(mediaType: MediaType) -> Bool;

    func CanHandle(data: Any) -> Bool;

    func Encode(data: Any, for mediatype: MediaType, into stream: OutputStream) -> Bool;
}