public struct Transition {
    private let result: String;
    private let name: String;

    public init(for result: String, to name: String) {
        self.result = result;
        self.name = name;
    }

    public func getResult() -> String {
        return result;
    }

    public func getName() -> String {
        return name;
    }
}