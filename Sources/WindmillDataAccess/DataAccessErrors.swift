public enum DataAccessErrors: Error {
    case notFound(reason: String)
    case notProcessableQuery(reason: String)
}