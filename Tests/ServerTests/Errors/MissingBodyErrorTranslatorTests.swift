import XCTest;

import JazzDataAccess;

@testable import JazzServer;

final class MissingBodyErrorTranslatorTests: XCTestCase {
    func test_canHandle_withCorrectError_returnsTrue() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: Bool = MissingBodyErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withIncorrectError_returnsFalse() {
        //Arrange
        let error: Error = DataAccessErrors.notFound(reason: "reason");

        //Act
        let result: Bool = MissingBodyErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, false);
    }

    func test_translate_withCorrectError_returnsExpectedResults() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: ServerError = MissingBodyErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 400);
        XCTAssertEqual(result.getTitle(), "Missing Body");
        XCTAssertEqual(result.getDetails(), "Missing Body");
    }
}