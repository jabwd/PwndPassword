import XCTest
import Dispatch
@testable import PwndPassword

class PwndPasswordTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
		let group = DispatchGroup()
		group.enter()
		DispatchQueue.global().async {
			let password = PwndPassword()
			password.validate(password: "correct horse battery staple") {
				result in
                XCTAssert(result >= 3)
				group.leave()
			}
		}
		group.wait()
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
