public protocol GetWeathersAction {
    func Get() throws -> [Weather];
};