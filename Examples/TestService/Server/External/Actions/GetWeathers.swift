import ExampleServerCommon;

public protocol GetWeathers {
    func Get() throws -> [Weather];
};