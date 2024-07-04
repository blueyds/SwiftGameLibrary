import XCTest
@testable import SwiftGameLibrary

final class GameLibraryTests: XCTestCase {
    func testNextID() throws {
		let x = Int.NextID()
		let y = Int.NextID()
		XCTAssert(y - x == 1)
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}
