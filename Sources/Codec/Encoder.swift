import Foundation;

public protocol Encoder {
    func CanHandle(mediaType: MediaType) -> Bool;

    func CanHandle<TType>(type: TType.Type) -> Bool;

    func Encode(data: Any, for mediatype: MediaType) -> Stream?;
}