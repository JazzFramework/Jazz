import Server;

public enum ClientErrors: Error {
    case apiError(statusCode: Int, data: ApiError)
    case statusError(statusCode: Int)
}