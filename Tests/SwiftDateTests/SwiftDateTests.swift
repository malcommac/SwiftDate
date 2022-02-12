import XCTest
@testable import SwiftDate

final class SwiftDateTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        /*let date = Clock(Date(), region: .init{
            $0.timeZone = .europeRome
            $0.locale = .italian
        })*/
        
        let rssDate = Clock("09 Sep 2011 15:26:08 +0200", format: .altRSS)
        
        print(rssDate)
    }
}
