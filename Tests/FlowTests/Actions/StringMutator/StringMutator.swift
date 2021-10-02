public protocol StringMutator {
    func Execute(withInput input: String) async throws -> String;
}