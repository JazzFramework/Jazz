import XCTest;

import Mockingbird;

import JazzCodec;

@testable import JazzServer;

final class HtmlControllerTests: XCTestCase {
    func test_logic_called_populatesResult() async throws {
        //Arrange
        let transcoderCollection = mock(TranscoderCollection.self);
        let templatingEngine = mock(TemplatingEngine.self);
        let requestStream = mock(RequestStream.self);
        let resultStream = mock(ResultStream.self);
        let cookieProcessor = mock(CookieProcessor.self);
        let acceptMediaTypes: [MediaType] = [];

        let request: RequestContext =
            try RequestContextBuilder()
                .with(rawInput: requestStream)
                .with(transcoderCollection: transcoderCollection)
                .with(cookieProcessor: cookieProcessor)
                .build();

        let result: ResultContext =
            try ResultContextBuilder()
                .with(resultStream: resultStream)
                .with(transcoderCollection: transcoderCollection)
                .with(cookieProcessor: cookieProcessor)
                .with(acceptMediaTypes: acceptMediaTypes)
                .build();

        given(try await templatingEngine.run(template: "template", any()))
            .willReturn(EmptyHtmlStream());

        given(try await transcoderCollection.encode(any(HtmlStream.self), for: any(), to: any()))
            .willReturn(MediaType(withType: "text", withSubtype: "html"));

        //Act
        try await TestHtmlController(templatingEngine: templatingEngine)
            .logic(withRequest: request, intoResult: result);

        //Assert
        XCTAssertEqual(result.getStatusCode(), 200);
        XCTAssertEqual(result.getHeaders().count, 2);
    }

    func test_template_withNoHeaders_returnsExpectedResults() async throws {
        //Arrange
        let templatingEngine = mock(TemplatingEngine.self);
        let data: [String:Any] = [:];

        given(try await templatingEngine.run(template: "template", data))
            .willReturn(EmptyHtmlStream());

        //Act
        let actual: HtmlControllerResult =
            try await HtmlController(templatingEngine: templatingEngine)
                .template("template", data);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 200);
        XCTAssertEqual(actual.getHeaders().count, 0);
    }

    func test_template_withHeaders_returnsExpectedResults() async throws {
        //Arrange
        let templatingEngine = mock(TemplatingEngine.self);
        let data: [String:Any] = [:];

        given(try await templatingEngine.run(template: "template", data))
            .willReturn(EmptyHtmlStream());

        //Act
        let actual: HtmlControllerResult = try await HtmlController(templatingEngine: templatingEngine)
            .template("template", data, headers: ["test": ["test2"]]);

        //Assert
        XCTAssertEqual(actual.getStatusCode(), 200);
        XCTAssertEqual(actual.getHeaders().count, 1);
        XCTAssertEqual(actual.getHeaders()["test"]?[0], "test2");
    }

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

    private class TestHtmlController: HtmlController {
        internal override init(templatingEngine: TemplatingEngine) {
            super.init(templatingEngine: templatingEngine);
        }

        public final override func logic(withRequest request: RequestContext) async throws -> HtmlControllerResult {
            return HtmlControllerResultBuilder()
                .with(headers: ["header": ["value1", "value2"]])
                .with(body: EmptyHtmlStream())
                .with(statusCode: 200)
                .build();
        }
    }
}