public protocol StringMutator {
    func Execute(withInput input: String) throws -> String;
}