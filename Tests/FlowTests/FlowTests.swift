import XCTest

@testable import Flow

final class FlowTests: XCTestCase {
    func testExample() {
        //Arrange
        let _: StringMutator = StringMutatorActionBuilder().build();

        //Act
        //let result = try await action.Execute(withInput: "custom value 2");

        //Assert
        //XCTAssertEqual(result, "2 EULAV MOTSUC2 EULAV MOTSUC")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}