import XCTest;

import JazzCodec;
import JazzDataAccess;

@testable import JazzServer;

final class NotAcceptableErrorTranslatorTests: XCTestCase {
    func test_canHandle_withCorrectError_returnsTrue() {
        //Arrange
        let error: Error = CodecErrors.cantEncode;

        //Act
        let result: Bool = NotAcceptableErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withOtherCorrectError_returnsTrue() {
        //Arrange
        let error: Error = HttpErrors.notAcceptable;

        //Act
        let result: Bool = NotAcceptableErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withIncorrectError_returnsFalse() {
        //Arrange
        let error: Error = DataAccessErrors.notFound(reason: "reason");

        //Act
        let result: Bool = NotAcceptableErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, false);
    }

    func test_translate_withCorrectError_returnsExpectedResults() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: ServerError = NotAcceptableErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 406);
        XCTAssertEqual(result.getTitle(), "Not Acceptable");
        XCTAssertEqual(result.getDetails(), "Not Acceptable");
    }
}