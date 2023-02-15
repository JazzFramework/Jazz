import XCTest;

import JazzDataAccess;

@testable import JazzServer;

final class DataNotFoundErrorTranslatorTests: XCTestCase {
    func test_canHandle_withCorrectError_returnsTrue() {
        //Arrange
        let error: Error = DataAccessErrors.notFound(reason: "reason");

        //Act
        let result: Bool = DataNotFoundErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withIncorrectError_returnsFalse() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: Bool = DataNotFoundErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, false);
    }

    func test_translate_withCorrectError_returnsExpectedResults() {
        //Arrange
        let error: Error = DataAccessErrors.notFound(reason: "reason");

        //Act
        let result: ServerError = DataNotFoundErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 404);
        XCTAssertEqual(result.getTitle(), "Resource not found");
        XCTAssertEqual(result.getDetails(), "reason");
        XCTAssertEqual(result.getMetadata()["reason"], "reason");
    }

    func test_translate_withIncorrectError_returnsExpectedResults() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: ServerError = DataNotFoundErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 500);
        XCTAssertEqual(result.getTitle(), "Unknown Error");
        XCTAssertEqual(result.getDetails(), "Unknown Error");
    }
}