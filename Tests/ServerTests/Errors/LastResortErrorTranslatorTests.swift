import XCTest;

@testable import JazzServer;

final class LastResortErrorTranslatorTests: XCTestCase {
    func test_canHandle_always_returnsTrue() {
        //Arrange
        let error: Error = HttpErrors.unsupportedMediaType;

        //Act
        let result: Bool = LastResortErrorTranslator().canHandle(error: error);

        //Assert
        XCTAssertEqual(result, true);
    }

    func test_translate_always_returnsExpectedResults() {
        //Arrange
        let error: Error = HttpErrors.unsupportedMediaType;

        //Act
        let result: ServerError = LastResortErrorTranslator().translate(error: error);

        //Assert
        XCTAssertEqual(result.getCode(), 500);
        XCTAssertEqual(result.getTitle(), "Unknown Error");
        XCTAssertEqual(result.getDetails(), "Unknown Error");
    }
}