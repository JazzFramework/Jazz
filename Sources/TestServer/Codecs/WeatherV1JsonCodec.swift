import Foundation;

import Codec;

public class WeatherV1JsonCodec: JsonCodec<Weather> {
    public override init() {
        super.init();
    }

    public override func CanHandle(mediaType: MediaType) -> Bool {
        return false;
    }

    public override func EncodeJson(data: Weather, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) -> Weather? {
        return nil;
    }
}