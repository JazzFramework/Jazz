public protocol LabManagerProvider {
    func isActive(lab: Lab) async -> LabResult;
}