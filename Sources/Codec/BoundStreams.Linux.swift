import Foundation;

#if os(Linux)
//TODO: Hack impl until a linux version of getBoundStreams exists, or there is a better solution.
// This isn't actually a bound stream, but will just create an input based on output when input is fetched.
public class BoundStreams {
    public var input: InputStream
    {
        get {
            let out: Data = output.property(forKey: .dataWrittenToMemoryStreamKey) as! Data;
            let stream: InputStream = InputStream(data: out);
            stream.open();
            return stream;
        }
    };

    public let output: OutputStream;
    
    public init() {
        output = OutputStream(toMemory: ());
        output.open();
    }
}
#endif