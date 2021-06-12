import Foundation;

public class JsonObjectReader {
    public init() {
    }

    public func Parse(_ data: Stream) -> JsonObject {
        return JsonObjectBuilder()
            .Build();
    }
}