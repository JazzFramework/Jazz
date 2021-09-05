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

public class WeatherCollectionV1JsonCodec: JsonCodec<[Weather]> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.weathers",
                "version": "1"
            ]
        );

    private static let WeatherCodec: WeatherV1JsonCodec =
        WeatherV1JsonCodec();

    public override func GetSupportedMediaType() -> MediaType {
        return WeatherCollectionV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: [Weather], for mediatype: MediaType) -> JsonObject {
        let arrayBuilder: JsonArrayBuilder = JsonArrayBuilder();

        for weather in data {
            _ = arrayBuilder.With(
                WeatherCollectionV1JsonCodec.WeatherCodec.EncodeJson(
                    data: weather,
                    for: WeatherCollectionV1JsonCodec.WeatherCodec.GetSupportedMediaType()
                )
            );
        }

        return JsonObjectBuilder()
            .With("data", array: arrayBuilder.Build())
            .With("count", property: JsonProperty(withData: String(data.count)))
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) -> [Weather]? {
        var result: [Weather] = [];

        let jsonArray: JsonArray = data["data"] as! JsonArray;

        if jsonArray.GetCount() > 0 {
            for index in 0...(jsonArray.GetCount() - 1) {
                if let jsonObject = jsonArray[index] as? JsonObject {
                    if let weather: Weather = WeatherCollectionV1JsonCodec.WeatherCodec.DecodeJson(
                        data: jsonObject,
                        for: WeatherCollectionV1JsonCodec.WeatherCodec.GetSupportedMediaType()
                    ) {
                        result.append(weather);
                    }
                }
            }
        }

        return result;
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

    func testExample2() {
        //Arrange
        let codec: WeatherCollectionV1JsonCodec = WeatherCollectionV1JsonCodec();
        let weather1: Weather = Weather("data value 1");
        let weather2: Weather = Weather("data value 2");
        let weathers: [Weather] = [
            weather1,
            weather2
        ];

        let mediaType: MediaType = MediaType(
            withType: "type",
            withSubtype: "subtype",
            withParameters: [:]
        );

        let streams: BoundStreams = BoundStreams();

        //Act
        _ = codec.Encode(data: weathers, for: mediaType, into: streams.output);
        let result: [Weather] = codec.Decode(data: streams.input, for: mediaType) as! [Weather];

        //Assert
        XCTAssertEqual(result[0].Temp, weathers[0].Temp);
        XCTAssertEqual(result[1].Temp, weathers[1].Temp);
    }

    static var allTests = [
        ("testExample", testExample),
        ("testExample2", testExample2),
    ]
}
