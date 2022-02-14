import XCTest
@testable import SwiftDate

final class ClockComponentsTests: XCTestCase {
    
    func testDateComponents() throws {
        let clock1 = Clock("2009-01-01 00:00:00", format: .custom("yyyy-MM-dd HH:mm:ss"), region: .UTC)
        let clock2 = clock1?.to(timezone: .americaNewYork)
    
        print(clock1?.toString(.custom("yyyy-MM-dd HH:mm:ss")))
        print(clock2?.toString(.custom("yyyy-MM-dd HH:mm:ss")))

        print(clock1?.day)
        print(clock2?.day)
        
        let clock3 = Clock("2009-01-01T00:00:00.000+01:00", format: .isoDateTimeFull, region: .inZone(.americaNewYork))
        print(clock3)
        
        print(clock3?.ordinalDay)
    }
    
}
