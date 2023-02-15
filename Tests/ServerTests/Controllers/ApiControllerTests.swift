import XCTest;

import Mockingbird;

import JazzCodec;

@testable import JazzServer;

final class ApiControllerTests: XCTestCase {
    func test_logic_called_populatesResultsAsExpected() async throws {
        //Arrange
        let request: RequestContext =
            try RequestContextBuilder()
                .with(transcoderCollection: mock(TranscoderCollection.self))
                .with(cookieProcessor: mock(CookieProcessor.self))
                .with(rawInput: mock(RequestStream.self))
                .build();

        let result: ResultContext =
            try ResultContextBuilder()
                .with(resultStream: mock(ResultStream.self))
                .with(transcoderCollection: mock(TranscoderCollection.self))
                .with(cookieProcessor: mock(CookieProcessor.self))
                .build();

        //Act
        try await TestApiController()
            .logic(withRequest: request, intoResult: result);

        //Assert
        XCTAssertEqual(result.getStatusCode(), 400);
        XCTAssertEqual(result.getHeaders().count, 1);
        XCTAssertEqual(result.getHeaders()["header"]?[0], "value1");
        XCTAssertEqual(result.getHeaders()["header"]?[1], "value2");
    }

    func test_logic_called_returnsExpectedResults() async throws {
        //Arrange
        let request: RequestContext =
            try RequestContextBuilder()
                .with(transcoderCollection: mock(TranscoderCollection.self))
                .with(cookieProcessor: mock(CookieProcessor.self))
                .with(rawInput: mock(RequestStream.self))
                .build();

        //Act
        let actual: ApiControllerResult = try await ApiController()
            .logic(withRequest: request);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 500);
        XCTAssertNil(actual.getBody());
        XCTAssertEqual(actual.getHeaders().count, 0);
    }

    func test_noContent_withNoHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .noContent();

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 204);
        XCTAssertNil(actual.getBody());
        XCTAssertEqual(actual.getHeaders().count, 0);
    }

    func test_noContent_withHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .noContent(headers: ["test": ["test2"]]);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 204);
        XCTAssertNil(actual.getBody());
        XCTAssertEqual(actual.getHeaders().count, 1);
        XCTAssertEqual(actual.getHeaders()["test"]?[0], "test2");
    }

    func test_ok_withNoHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .ok(body: 12);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 200);
        XCTAssertNotNil(actual.getBody());
        XCTAssertEqual(actual.getBody() as! Int, 12);
        XCTAssertEqual(actual.getHeaders().count, 0);
    }

    func test_ok_withHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .ok(body: 12, headers: ["test": ["test2"]]);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 200);
        XCTAssertNotNil(actual.getBody());
        XCTAssertEqual(actual.getBody() as! Int, 12);
        XCTAssertEqual(actual.getHeaders().count, 1);
        XCTAssertEqual(actual.getHeaders()["test"]?[0], "test2");
    }

    func test_redirect_withNoHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .redirect(url: "url");

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 307);
        XCTAssertNil(actual.getBody());
        XCTAssertEqual(actual.getHeaders().count, 1);
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }

    func test_redirect_withHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .redirect(url: "url", headers: ["test": ["test2"]]);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 307);
        XCTAssertNil(actual.getBody());
        XCTAssertEqual(actual.getHeaders().count, 2);
        XCTAssertEqual(actual.getHeaders()["test"]?[0], "test2");
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }

    func test_permanentRedirect_withNoHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .permanentRedirect(url: "url");

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 308);
        XCTAssertNil(actual.getBody());
        XCTAssertEqual(actual.getHeaders().count, 1);
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }

    func test_permanentRedirect_withHeaders_returnsExpectedResults() {
        //Arrange
        //Act
        let actual: ApiControllerResult = ApiController()
            .permanentRedirect(url: "url", headers: ["test": ["test2"]]);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 308);
        XCTAssertNil(actual.getBody());
        XCTAssertEqual(actual.getHeaders().count, 2);
        XCTAssertEqual(actual.getHeaders()["test"]?[0], "test2");
        XCTAssertEqual(actual.getHeaders()["Location"]?[0], "url");
    }

    private class TestApiController: ApiController {
        internal override init() {
            super.init();
        }

        public final override func logic(withRequest request: RequestContext) async throws -> ApiControllerResult {
            return ApiControllerResultBuilder()
                .with(headers: ["header": ["value1", "value2"]])
                .with(statusCode: 400)
                .build();
        }
    }
}