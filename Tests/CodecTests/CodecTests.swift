import XCTest
import Foundation;

import Codec;

final class CodecTests: XCTestCase {
    func simpleCodecRoundTrip() {
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
        _ = codec.encode(data: weather, for: mediaType, into: streams.output);
        let result: Weather = codec.decode(data: streams.input, for: mediaType) as! Weather;

        //Assert
        XCTAssertEqual(result.temp, weather.temp);
    }

    func arrayCodecRoundTrip() {
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
        _ = codec.encode(data: weathers, for: mediaType, into: streams.output);
        let result: [Weather] = codec.decode(data: streams.input, for: mediaType) as! [Weather];

        //Assert
        XCTAssertEqual(result[0].temp, weathers[0].temp);
        XCTAssertEqual(result[1].temp, weathers[1].temp);
    }

    static var allTests = [
        ("simpleCodecRoundTrip", simpleCodecRoundTrip),
        ("arrayCodecRoundTrip", arrayCodecRoundTrip),
    ]
}
