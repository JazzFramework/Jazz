import Foundation;

#if !os(Linux)
public class BoundStreams {
    public let input: InputStream;
    public let output: OutputStream;
    
    public init() {
        var inputOrNil: InputStream?;
        var outputOrNil: OutputStream?;

        Stream.getBoundStreams(
            withBufferSize: 40960,
            inputStream: &inputOrNil,
            outputStream: &outputOrNil
        );

        guard let input = inputOrNil, let output = outputOrNil else {
            fatalError(
                "On return of `getBoundStreams`, both `inputStream` and `outputStream` will contain non-nil streams."
            );
        }

        input.open();
        output.open();
        
        self.input = input;
        self.output = output;
    }
}
#endif

#if os(Linux)
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