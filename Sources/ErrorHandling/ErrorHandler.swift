open class ErrorHandler {
    public init() {}

    open func CanHandle(error: Error) -> Bool {
        return false;
    }

    open func Handle(error: Error) {
    }
}