import XCTest;

import Mockingbird;

import JazzCodec;

@testable import JazzServer;

final class HtmlControllerTests: XCTestCase {
    func test_redirect_withNoHeaders_returnsExpectedResults() {
        //Arrange
        let templatingEngine: TemplatingEngine = mock(TemplatingEngine.self);

        //Act
        let actual: HtmlControllerResult = HtmlController(templatingEngine: templatingEngine)
            .redirect(url: "url");

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 307);
        XCTAssertEqual(actual.getHeaders().count, 1);
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }

    func test_redirect_withHeaders_returnsExpectedResults() {
        //Arrange
        let templatingEngine: TemplatingEngine = mock(TemplatingEngine.self);

        //Act
        let actual: HtmlControllerResult = HtmlController(templatingEngine: templatingEngine)
            .redirect(url: "url", headers: ["test": ["test2"]]);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 307);
        XCTAssertEqual(actual.getHeaders().count, 2);
        XCTAssertEqual(actual.getHeaders()["test"]?[0], "test2");
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }

    func test_permanentRedirect_withNoHeaders_returnsExpectedResults() {
        //Arrange
        let templatingEngine: TemplatingEngine = mock(TemplatingEngine.self);

        //Act
        let actual: HtmlControllerResult = HtmlController(templatingEngine: templatingEngine)
            .permanentRedirect(url: "url");

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 308);
        XCTAssertEqual(actual.getHeaders().count, 1);
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }

    func test_permanentRedirect_withHeaders_returnsExpectedResults() {
        //Arrange
        let templatingEngine: TemplatingEngine = mock(TemplatingEngine.self);

        //Act
        let actual: HtmlControllerResult = HtmlController(templatingEngine: templatingEngine)
            .permanentRedirect(url: "url", headers: ["test": ["test2"]]);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 308);
        XCTAssertEqual(actual.getHeaders().count, 2);
        XCTAssertEqual(actual.getHeaders()["test"]?[0], "test2");
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }
}