import XCTest;

@testable import JazzContext;

final class ContextResolverTests: XCTestCase {
    func test_resolve_whenMissing_nilIsReturned() {
        //Arrange
        let subject: ContextResolver<BaseContext, TestContext> = ContextResolver();
        let context = BaseContext();

        //Act
        let result: TestContext? = subject.resolve(for: context);

        //Assert
        XCTAssertNil(result);
    }

    func test_resolve_whenExists_expectedIsReturned() {
        //Arrange
        let subject: ContextResolver<BaseContext, TestContext> = ContextResolver();
        let context = BaseContext();
        let subcontext = TestContext("data");

        context.adopt(subcontext: subcontext);

        //Act
        let result: TestContext = subject.resolve(for: context)!;

        //Assert
        XCTAssertEqual(result.getData(), "data");
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