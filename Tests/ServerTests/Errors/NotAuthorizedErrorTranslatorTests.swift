import XCTest;

@testable import JazzServer;

final class NotAuthorizedErrorTranslatorTests: XCTestCase {
    func test_canHandle_withCorrectError_returnsTrue() {
        //Arrange
        let error: Error = HttpErrors.notAuthorized;

        //Act
        let result: Bool = NotAuthorizedErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_canHandle_withIncorrectError_returnsFalse() {
        //Arrange
        let error: Error = ControllerErrors.missingBody;

        //Act
        let result: Bool = NotAuthorizedErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, false);
    }

    func test_translate_withCorrectError_returnsExpectedResults() {
        //Arrange
        let error: Error = HttpErrors.notAuthorized;

        //Act
        let result: ServerError = NotAuthorizedErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 401);
        XCTAssertEqual(result.getTitle(), "Not Authorized");
        XCTAssertEqual(result.getDetails(), "Not Authorized");
    }
}