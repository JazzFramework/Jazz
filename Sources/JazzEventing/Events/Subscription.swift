import Foundation;

public final class Subscription: Hashable {
    private let id: String;

    internal init() {
        id = UUID().uuidString;
    }

    public static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        return lhs.id == rhs.id;
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id);
    }
}