import XCTest

@testable import JazzFlow

final class FlowTests: XCTestCase {
    func testExample() async throws {
        //Arrange
        let action: StringMutator = StringMutatorActionBuilder().build();

        //Act
        let result = try await action.execute(withInput: "custom value 2");

        //Assert
        XCTAssertEqual(result, "2 EULAV MOTSUC2 EULAV MOTSUC")
    }
/*
    static var allTests = [
        ("testExample", testExample),
    ]
*/
}