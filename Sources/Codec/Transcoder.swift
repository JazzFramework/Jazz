import Foundation;

public protocol Transcoder: Encoder, Decoder {
    func CanHandle(mediaType: MediaType) -> Bool;

    func CanHandle(data: Any) -> Bool;
}