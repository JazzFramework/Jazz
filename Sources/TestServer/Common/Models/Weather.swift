import DataAccess;

public class Weather: Storable {
    public let Id: String;
    public let Temp: String;

    public init(_ id: String, _ temp: String) {
        Id = id;
        Temp = temp;
    }

    public func GetId() -> String {
        return Id;
    }
}