open class ErrorMapper {
    open func CanMap(error: Error) -> Bool {
        return false;
    }

    open func Map(error: Error) -> Error {
        return error;
    }
}