import XCTest

import codecTests
import flowTests

var tests = [XCTestCaseEntry]()
tests += flowTests.allTests()
tests += codecTests.allTests()
XCTMain(tests)
