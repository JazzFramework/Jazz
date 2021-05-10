import XCTest

import CodecTests
import FlowTests

var tests = [XCTestCaseEntry]()
tests += CodecTests.allTests()
tests += FlowTests.allTests()
XCTMain(tests)