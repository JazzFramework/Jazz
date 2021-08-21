import ExampleCommon;

public protocol GetWeathers {
    func Get() throws -> [Weather];
};