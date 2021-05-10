import Foundation;

public protocol Decoder {
    func CanHandle(mediaType: MediaType) -> Bool;

    func CanHandle<TType>(type: TType.Type) -> Bool;

    func Decode(data: Stream, for mediatype: MediaType) -> Any?;
}