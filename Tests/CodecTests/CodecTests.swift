import XCTest
import Foundation;

import Server;
@testable import Codec

public class Weather {
    public let Temp: String;

    public init(_ temp: String) {
        Temp = temp;
    }
}

public class WeatherV1JsonCodec: JsonCodec<Weather> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "test.weather",
                "version": "1"
            ]
        );

    public override func GetSupportedMediaType() -> MediaType {
        return WeatherV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: Weather, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .With("temp", property: JsonProperty(withData: data.Temp))
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) -> Weather? {
        let temp: JsonProperty = data["temp"] as! JsonProperty;

        return Weather(temp.GetString());
    }
}

final class CodecTests: XCTestCase {
    func testExample() {
        //Arrange
        let codec: WeatherV1JsonCodec = WeatherV1JsonCodec();
        let weather: Weather = Weather("data value");
        let mediaType: MediaType = MediaType(
            withType: "type",
            withSubtype: "subtype",
            withParameters: [:]
        );
        let streams: BoundStreams = BoundStreams();

        //Act
        _ = codec.Encode(data: weather, for: mediaType, into: streams.output);
        let result: Weather = codec.Decode(data: streams.input, for: mediaType) as! Weather;

        //Assert
        XCTAssertEqual(result.Temp, weather.Temp);
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
