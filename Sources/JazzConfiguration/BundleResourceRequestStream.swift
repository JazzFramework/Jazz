import Foundation;

import JazzCodec;

internal final class BundleResourceRequestStream: RequestStream {
    private let input: InputStream;

    internal init?(in bundle: Bundle, for file: String) {
        guard let url = bundle.url(forResource: file, withExtension: nil), let stream = InputStream(url: url) else {
            return nil;
        }

        input = stream;

        input.open();
    }

    deinit {
        input.close();
    }

    public final func hasData() -> Bool {
        return input.hasBytesAvailable;
    }

    public final func read(into buffer: UnsafeMutablePointer<UInt8>, maxLength: Int) -> Int {
        return input.read(buffer, maxLength: maxLength);
    }
}