import Foundation;

public protocol ResultStream {
    func write(_ data: [UInt8]);
    func write(_ data: String);
    func write(_ data: InputStream);
    func write(_ data: UnsafeMutablePointer<UInt8>, maxLength: Int);
}