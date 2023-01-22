import Foundation;

public final class MetricBuilder {
    private var dimensions: [Dimension];
    private var value: Decimal? = nil;
    private var unit: Unit? = nil;

    public init() {
        dimensions = [];
    }

    public final func with(dimension: Dimension) -> MetricBuilder {
        dimensions.append(dimension);

        return self;
    }

    public final func with(dimensions: [Dimension]) -> MetricBuilder {
        self.dimensions = dimensions;

        return self;
    }

    public final func with(value: Decimal) -> MetricBuilder {
        self.value = value;

        return self;
    }

    public final func with(unit: Unit) -> MetricBuilder {
        self.unit = unit;

        return self;
    }

    public final func build() -> Metric {
        return Metric(dimensions: dimensions, value: value ?? 0, unit: unit ?? .none);
    }
}