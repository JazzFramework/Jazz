open class ErrorMapper {
    public init() {}

    open func CanMap(error: Error) -> Bool {
        return false;
    }

    open func Map(error: Error) -> Error {
        return error;
    }
}