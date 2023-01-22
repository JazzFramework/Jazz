import Foundation;

public class JsonObjectReader {
    public init() {
    }

    public func parse(_ data: RequestStream) -> JsonObject {
        let builder: JsonObjectBuilder = JsonObjectBuilder();
        let content: Data = try! Data(reading: data);

        //TODO: Roll our own logic to speed things up. JSONSerialization is a bit slower than we'd want.
        if let jsonData = try! JSONSerialization.jsonObject(with: content, options: []) as? [String: Any] {
            read(jsonObject: jsonData, to: builder);
        }

        return builder.build();
    }

    private func read(jsonObject: [String: Any], to builder: JsonObjectBuilder) {
        for key in jsonObject.keys {
            let token: JsonToken = read(json: jsonObject[key] as Any);

            _ = builder.with(key, token: token);
        }
    }

    private func read(jsonArray: [Any]) -> JsonArray {
        var tokenArray: [JsonToken] = [];

        for json in jsonArray {
            let token: JsonToken = read(json: json);

            tokenArray.append(token);
        }

        return JsonArray(withData: tokenArray);
    }

    private func read(json: Any) -> JsonToken
    {
        if let object = json as? [String: Any] {
            let childBuilder: JsonObjectBuilder = JsonObjectBuilder();
            
            read(jsonObject: object, to: childBuilder);

            return childBuilder.build();
        }
        else if let array = json as? [Any] {
            return read(jsonArray: array);
        }
        else if let valueOption = json as? String? {
            if let value = valueOption {
                return JsonProperty(withData: value);
            }
        }

        return JsonProperty(withData: "");
    }
}