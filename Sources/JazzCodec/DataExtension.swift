import Foundation;

internal extension Data {
    init(reading input: RequestStream) throws {
        self.init();

        //input.open();
        //defer {
        //    input.close();
        //}

        let bufferSize = 1024;
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize);
        defer {
            buffer.deallocate();
        }
        //while input.hasBytesAvailable {
        while input.hasData() {
            let read = input.read(into: buffer, maxLength: bufferSize);
            if read < 0 {
                //Stream error occured
                //throw input.streamError!;
                break;
            } else if read == 0 {
                //EOF
                break;
            }
            self.append(buffer, count: read);
        }
    }
}