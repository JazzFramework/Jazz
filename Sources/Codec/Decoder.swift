import Foundation;

public protocol Decoder {
    func CanHandle(mediaType: MediaType) -> Bool;

    func CanHandle(data: Any) -> Bool;

    func Decode(data: InputStream, for mediatype: MediaType) -> Any?;
}