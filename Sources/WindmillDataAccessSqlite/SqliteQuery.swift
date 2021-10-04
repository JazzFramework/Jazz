import WindmillDataAccess;

public final class SqliteQuery<TResource: Storable>: Query<TResource> {
    internal override init() {
        super.init();
    }
}