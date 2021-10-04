public struct Transition {
    private let _result: String;
    private let _name: String;

    public init(for result: String, to name: String) {
        _result = result;
        _name = name;
    }

    public func getResult() -> String {
        return _result;
    }

    public func getName() -> String {
        return _name;
    }
}