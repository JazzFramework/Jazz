public protocol ServiceProvider {
    func fetchTypes<T>() async throws -> [T];
    func fetchTypes<T>(_ name: String) async throws -> [T];
    func fetchType<T>() async throws -> T;
    func fetchType<T>(_ name: String) async throws -> T;
}