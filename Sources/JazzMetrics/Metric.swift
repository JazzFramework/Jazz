import Foundation;

public final class Metric {
    private let dimensions: [Dimension];
    private let value: Decimal;
    private let unit: Unit;

    internal init(
        dimensions: [Dimension],
        value: Decimal,
        unit: Unit
    ) {
        self.dimensions = dimensions;
        self.value = value;
        self.unit = unit;
    }

    public final func getDimensions() -> [Dimension] {
        return dimensions;
    }

    public final func getValue() -> Decimal {
        return value;
    }

    public final func getUnit() -> Unit {
        return unit;
    }
}