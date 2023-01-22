import JazzServer;

public enum ClientErrors: Error {
    case statusError(statusCode: Int)
}