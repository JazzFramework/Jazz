import XCTest;

import JazzCodec;

@testable import JazzServer;

final class ServerErrorV1JsonCodecTests: XCTestCase {
    func test_getSupportedMediaType_always_returnsMetaType() {
        //Arrange
        //Act
        let result: MediaType = ServerErrorV1JsonCodec().getSupportedMediaType();

        //Assert
        XCTAssertEqual(
            result,
            MediaType(
                withType: "application",
                withSubtype: "json",
                withParameters: [
                    "structure": "servererror",
                    "version": "1"
                ]
            )
        );
    }
}