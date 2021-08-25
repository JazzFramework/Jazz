import Foundation;

public protocol Encoder {
    func Encode(data: Any, for mediatype: MediaType, into stream: OutputStream) -> Bool;

    func CanHandle(mediaType: MediaType) -> Bool;

    func CanHandle(data: Any) -> Bool;
}