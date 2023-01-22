internal class StringBackedStream {
    private final let data: String;

    private var current: Int = 0;

    internal init(data: String) {
        self.data = data;
    }

    public final func hasData() -> Bool {
        return data.count > current;
    }

    public final func read(into buffer: UnsafeMutablePointer<UInt8>, maxLength: Int) -> Int {
        let end: Int = min(current + maxLength, data.count);
        let count: Int = end - current;

        let startIndex = data.index(data.startIndex, offsetBy: current);
        let endIndex = data.index(data.startIndex, offsetBy: end);

        buffer.initialize(from: data.substring(with: startIndex ..< endIndex), count: count);

        current = end;

        return count;
    }
}