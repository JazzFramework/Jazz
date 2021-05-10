import XCTest
@testable import Codec

final class CodecTests: XCTestCase {
    func testExample() {
        //Arrange
        //Act
        let result: String = "data";

        //Assert
        XCTAssertEqual(result, "data")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
