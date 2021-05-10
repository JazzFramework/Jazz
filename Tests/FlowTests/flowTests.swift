import XCTest
@testable import Flow

final class FlowTests: XCTestCase {
    func testExample() {
        //Arrange
        let action: StringMutator = StringMutatorActionBuilder()
            .Build();

        //Act
        let result = try! action.Execute(withInput: "custom value 2");

        //Assert
        XCTAssertEqual(result, "2 EULAV MOTSUC2 EULAV MOTSUC")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
