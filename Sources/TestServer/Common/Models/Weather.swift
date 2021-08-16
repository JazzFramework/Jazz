import DataAccess;

public class Weather: Storable {
    public var Id: String;
    public let Temp: String;

    public init(_ id: String, _ temp: String) {
        Id = id;
        Temp = temp;
    }

    public func GetId() -> String {
        return Id;
    }

    public func Set(id: String) {
        Id = id;
    }
}