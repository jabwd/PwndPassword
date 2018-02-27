import CryptoSwift
import Foundation
import SwiftyRequest

public typealias PasswordValidationCallback = (Int) -> Void

public class PwndPassword {
	
	init() {
	}
	
	deinit {
	}
	
	///
	/// Checks https://api.pwnedpasswords.com for known breaches of the given password
	/// The callback returns -1 on error, 0 for none found and a count for passwords
	/// that have been pwned X times
	///
	public func validate(password: String, callback: @escaping PasswordValidationCallback) -> Void {
		let hash = password.sha1().uppercased()
		let endIndex = hash.index(hash.startIndex, offsetBy: 5)
		
		// The api requires the first 5, returns the last 35.
		// Here named the suffix and prefix
		let prefix  = hash[hash.startIndex..<endIndex]
		let suffix  = hash[endIndex..<hash.endIndex]
		
		let request = RestRequest(method: .get, url: "https://api.pwnedpasswords.com/range/\(prefix)")
		request.response { (data, urlResponse, error) in
			guard let data = data else { callback(-1); return }
			guard let stringResponse = String(data: data, encoding: .utf8) else { callback(-1);return }
			
			// Scan through line by line to find our suffix
			let hashes = stringResponse.components(separatedBy: "\r\n")
			for hash in hashes {
				// Each line has 2 components, the suffix ouf our hash we broke up earlier
				// and the second component being the number of times it has been breached
				let components = hash.components(separatedBy: ":")
				guard components.count == 2 else {
					continue
				}
				let returnedSuffix = components[0]
				let count          = Int(components[1]) ?? 0
				if returnedSuffix == suffix {
					callback(count)
					return
				}
			}
			callback(0)
		}
	}
}
