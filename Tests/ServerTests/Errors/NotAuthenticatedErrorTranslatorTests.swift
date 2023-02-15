import XCTest;

@testable import JazzServer;

final class NotAuthenticatedErrorTranslatorTests: XCTestCase {
    func test_canHandle_withCorrectError_returnsTrue() {
        //Arrange
        let error: Error = HttpErrors.notAuthenticated;

        //Act
        let result: Bool = NotAuthenticatedErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withIncorrectError_returnsFalse() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: Bool = NotAuthenticatedErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, false);
    }

    func test_translate_withCorrectError_returnsExpectedResults() {
        //Arrange
        let error: Error = HttpErrors.notAuthenticated;

        //Act
        let result: ServerError = NotAuthenticatedErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 403);
        XCTAssertEqual(result.getTitle(), "Not Authenticated");
        XCTAssertEqual(result.getDetails(), "Not Authenticated");
    }
}