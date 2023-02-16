public protocol StringMutator {
    func execute(withInput input: String) async throws -> String;
}