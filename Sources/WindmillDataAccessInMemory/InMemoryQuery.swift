import WindmillDataAccess;

public final class InMemoryQuery<TResource: Storable>: Query<TResource> {
    public var data: [TResource];

    internal init(data: [TResource]) {
        self.data = data;

        super.init();
    }
}