import Foundation;

public protocol Decoder {
    func Decode(data: InputStream, for mediatype: MediaType) -> Any?;

    func CanHandle(mediaType: MediaType) -> Bool;
}