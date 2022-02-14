import XCTest
@testable import SwiftDate

final class ClockParserISOTests: XCTestCase {
    
    func testDateFromISOYearString() throws {
        let clock1 = Clock("2009", format: .isoYear, region: .UTC)
        XCTAssertEqual(clock1?.toString(.isoDateTimeFull), "2009-01-01T00:00:00.000Z", "Failed to create a new date from isoYear in UTC Region")
        XCTAssertEqual(clock1?.region.timeZone, Region.TimeZoneOptions.gmt, "Failed to set the correct GMT timezone")
     
        let clock2 = Clock("2009", format: .isoYear, region: .inZone(.europeRome))
        XCTAssertEqual(clock2?.toString(.isoDateTimeFull), "2009-01-01T00:00:00.000+01:00", "Failed to create a new date from isoYear in Europe/Rome")
        XCTAssertEqual(clock2?.region.timeZone, Region.TimeZoneOptions.europeRome, "Failed to set correct Europe/Rome timezone")
    }
    
    func testDateFromISOYearMonthString() throws {
        let clock1 = Clock("2009-08", format: .isoYearMonth, region: .UTC)
        XCTAssertEqual(clock1?.toString(.isoDateTimeFull), "2009-08-01T00:00:00.000Z", "Failed to create a new date from isoYearMonth in UTC Region")
        XCTAssertEqual(clock1?.region.timeZone, Region.TimeZoneOptions.gmt, "Failed to set the correct GMT timezone")

        let clock2 = Clock("2009-08", format: .isoYearMonth, region: .inZone(.europePrague))
        XCTAssertEqual(clock2?.toString(.isoDateTimeFull), "2009-08-01T00:00:00.000+02:00", "Failed to create a new date from isoYearMonth in Europe/Prague")
        XCTAssertEqual(clock2?.region.timeZone, Region.TimeZoneOptions.europePrague, "Failed to set correct Europe/Prague timezone")
    }
    
    func testDateFromISODateString() throws {
        let clock1 = Clock("2009-08-11", format: .isoDate, region: .inZone(.americaNewYork))
        XCTAssertEqual(clock1?.toString(.isoDateTimeFull), "2009-08-11T00:00:00.000-04:00", "Failed to create a new date from isoDate in America/NewYork")

        let clock2 = Clock("2009-08-11", format: .isoDate, region: .UTC)
        XCTAssertEqual(clock2?.toString(.isoDateTimeFull), "2009-08-11T00:00:00.000Z", "Failed to create a new date from isoDate in UTC")
    }
    
    func testDateFromISODateTimeString() throws {
        let clock1 = Clock("2009-08-11T06:30:03-05:00", format: .isoDateTime, region: .UTC)
        XCTAssertEqual(clock1?.toString(.isoDateTimeFull), "2009-08-11T11:30:03.000Z", "Failed to create a new date from isoDateTime and timezone to UTC")

        
        /*
        let offset = -5
        let timeZone = TimeZone(secondsFromGMT: 60 * 60 * offset)
        let comparison = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2009, month: 08, day: 11, hour: 06, minute: 30, second: 03))
        XCTAssertEqual(date, comparison)*/
    }
    
}
