import XCTest
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
			password.validate(password: "somePassword") {
				result in
				print("Validation result: \(result)")
				group.leave()
			}
		}
		group.wait()
		
		XCTAssert(true)
        //XCTAssertEqual(PwndPassword().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
