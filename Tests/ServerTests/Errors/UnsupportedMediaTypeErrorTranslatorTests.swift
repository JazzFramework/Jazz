import XCTest;

import JazzCodec;

@testable import JazzServer;

final class UnsupportedMediaTypeErrorTranslatorTests: XCTestCase {
    func test_canHandle_withCorrectError_returnsTrue() {
        //Arrange
        let error: Error = CodecErrors.cantDecode;

        //Act
        let result: Bool = UnsupportedMediaTypeErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withOtherCorrectError_returnsTrue() {
        //Arrange
        let error: Error = HttpErrors.unsupportedMediaType;

        //Act
        let result: Bool = UnsupportedMediaTypeErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withIncorrectError_returnsFalse() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: Bool = UnsupportedMediaTypeErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, false);
    }

    func test_translate_withCorrectError_returnsExpectedResults() {
        //Arrange
        let error: Error = HttpErrors.unsupportedMediaType;

        //Act
        let result: ServerError = UnsupportedMediaTypeErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 415);
        XCTAssertEqual(result.getTitle(), "UnsupportedMediaType");
        XCTAssertEqual(result.getDetails(), "UnsupportedMediaType");
    }
}