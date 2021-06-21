import Foundation;

#if os(Windows)
//TODO: Hack impl until a linux version of getBoundStreams exists, or there is a better solution.
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