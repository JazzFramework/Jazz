public enum AuthErrors: Error {
    case notAuthorized(reason: String)
}