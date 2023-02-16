import XCTest;

@testable import JazzContext;

final class BaseContextTests: XCTestCase {
    func test_adopt_whenAdpting_contextIsFetchable() {
        //Arrange
        let subject = BaseContext();
        let subcontext = TestContext("data");

        //Act
        subject.adopt(subcontext: subcontext);
        let result: TestContext = subject.fetch()!;

        //Assert
        XCTAssertEqual(result.getData(), "data");
    }

    func test_fetch_whenAdptingMultiple_finalContextIsFetchable() {
        //Arrange
        let subject = BaseContext();
        let subcontext1 = TestContext("data1");
        let subcontext2 = TestContext("data2");

        subject.adopt(subcontext: subcontext1);
        subject.adopt(subcontext: subcontext2);

        //Act
        let result: TestContext = subject.fetch()!;

        //Assert
        XCTAssertEqual(result.getData(), "data2");
    }

    func test_fetch_whenMissing_nilIsReturned() {
        //Arrange
        let subject = BaseContext();

        //Act
        let result: TestContext? = subject.fetch();

        //Assert
        XCTAssertNil(result);
    }

    private final class TestContext: BaseContext {
        private final let data: String;

        internal init(_ data: String) {
            self.data = data;

            super.init();
        }

        internal final func getData() -> String {
            return data;
        }
    }
}