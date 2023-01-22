public protocol LabManager {
    func isActive(lab: Lab) async -> LabResult;
}