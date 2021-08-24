public protocol Storable {
    func GetId() -> String;
    func Set(id: String);
}