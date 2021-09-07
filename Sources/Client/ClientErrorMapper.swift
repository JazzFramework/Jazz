import ErrorHandling;

public class ClientErrorMapper: ErrorMapper {
    public override init() {}

    public override final func CanMap(error: Error) -> Bool {
        return true;
    }

    public override final func Map(error: Error) -> Error {
        return error;
    }
}