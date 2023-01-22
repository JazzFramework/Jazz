public protocol HtmlStream {
    func hasData() -> Bool;
    func read(into buffer: UnsafeMutablePointer<UInt8>, maxLength: Int) -> Int;
}