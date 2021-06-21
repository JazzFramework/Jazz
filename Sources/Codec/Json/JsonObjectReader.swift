import Foundation;

public class JsonObjectReader {
    public init() {
    }

    public func Parse(_ data: InputStream) -> JsonObject {
        let builder: JsonObjectBuilder = JsonObjectBuilder();
        let content: Data = try! Data(reading: data);

        //TODO: Roll our own logic to speed things up. JSONSerialization is a bit slower than we'd want.
        if let jsonData = try! JSONSerialization.jsonObject(with: content, options: []) as? [String: Any] {
            Read(jsonObject: jsonData, to: builder);
        }

        return builder.Build();
    }

    private func Read(jsonObject: [String: Any], to builder: JsonObjectBuilder) {
        for key in jsonObject.keys {
            let token: JsonToken = Read(json: jsonObject[key] as Any);

            _ = builder.With(key, token: token);
        }
    }

    private func Read(jsonArray: [Any]) -> JsonArray {
        var tokenArray: [JsonToken] = [];

        for json in jsonArray {
            let token: JsonToken = Read(json: json);

            tokenArray.append(token);
        }

        return JsonArray(withData: tokenArray);
    }

    private func Read(json: Any) -> JsonToken
    {
        if let object = json as? [String: Any] {
            let childBuilder: JsonObjectBuilder = JsonObjectBuilder();
            
            Read(jsonObject: object, to: childBuilder);

            return childBuilder.Build();
        }
        else if let array = json as? [Any] {
            return Read(jsonArray: array);
        }
        else if let valueOption = json as? String? {
            if let value = valueOption {
                return JsonProperty(withData: value);
            }
        }

        return JsonProperty(withData: "");
    }
}