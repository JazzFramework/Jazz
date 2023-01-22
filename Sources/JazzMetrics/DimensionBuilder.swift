public final class DimensionBuilder {
    private var key: String? = nil;
    private var value: String? = nil;

    public init() {}

    public final func with(key: String) -> DimensionBuilder {
        self.key = key;

        return self;
    }

    public final func with(value: String) -> DimensionBuilder {
        self.value = value;

        return self;
    }

    public final func build() -> Dimension {
        return Dimension(key: key ?? "", value: value ?? "");
    }
}