// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import SwiftDateTests
import XCTest

extension TestDateInRegion {
    static var allTests: [(String, (TestDateInRegion) -> () throws -> Void)] = [
        ("testDateInRegion_ParseWithLocale", testDateInRegion_ParseWithLocale),
        ("testDateInRegion_InitWithDateAndRegion", testDateInRegion_InitWithDateAndRegion),
        ("testDateInRegion_InitFromTimeInterval", testDateInRegion_InitFromTimeInterval),
        ("testDateInRegion_InitFromComponents", testDateInRegion_InitFromComponents),
        ("testDateInRegion_InitFromParams", testDateInRegion_InitFromParams),
        ("testDateInRegion_PastAndFuture", testDateInRegion_PastAndFuture),
        ("testDateInRegion_Description", testDateInRegion_Description),
        ("testDateInRegion_DateComponents", testDateInRegion_DateComponents),
        ("testDateInRegion_Hash", testDateInRegion_Hash),
        ("testDateInRegion_InitComponentsCallback", testDateInRegion_InitComponentsCallback),
        ("testDateInRegion_ExtractComponents", testDateInRegion_ExtractComponents),
        ("testDateInRegion_InitStringAutoFormat", testDateInRegion_InitStringAutoFormat)
    ]
}

extension TestDateInRegion_Compare {
    static var allTests: [(String, (TestDateInRegion_Compare) -> () throws -> Void)] = [
        ("testDateInRegion_compareCloseTo", testDateInRegion_compareCloseTo),
        ("testDateInRegion_compare", testDateInRegion_compare),
        ("testDateInRegion_compareGranularity", testDateInRegion_compareGranularity),
        ("testDateInRegion_isBeforeDate", testDateInRegion_isBeforeDate),
        ("testDateInRegion_isAfterDate", testDateInRegion_isAfterDate),
        ("testDateInRegion_isInRange", testDateInRegion_isInRange),
        ("testDateInRegion_earlierAndLaterDate", testDateInRegion_earlierAndLaterDate),
        ("testDateInRegion_compareMath", testDateInRegion_compareMath),
        ("testDateInRange_GranuralityTest", testDateInRange_GranuralityTest)
    ]
}

extension TestDateInRegion_Components {
    static var allTests: [(String, (TestDateInRegion_Components) -> () throws -> Void)] = [
        ("testDateInRegion_Components", testDateInRegion_Components),
        ("testDateInRegion_isLeapMonth", testDateInRegion_isLeapMonth),
        ("testDateInRegion_dateBySet", testDateInRegion_dateBySet),
        ("testDateInRegion_isLeapYear", testDateInRegion_isLeapYear),
        ("testDateInRegion_julianDayAndModifiedJulianDay", testDateInRegion_julianDayAndModifiedJulianDay),
        ("test_ordinalDay", test_ordinalDay),
        ("testDateInRegion_ISOFormatterAlt", testDateInRegion_ISOFormatterAlt),
        ("testDateInRegion_getIntervalForComponentBetweenDates", testDateInRegion_getIntervalForComponentBetweenDates),
        ("testDateInRegion_timeIntervalSince", testDateInRegion_timeIntervalSince),
        ("testQuarter", testQuarter),
        ("testAbsoluteDateISOFormatting", testAbsoluteDateISOFormatting)
    ]
}

extension TestDateInRegion_Create {
    static var allTests: [(String, (TestDateInRegion_Create) -> () throws -> Void)] = [
        ("testDateInRegion_DateBySetTime", testDateInRegion_DateBySetTime),
        ("testDateInRegion_DateBySet", testDateInRegion_DateBySet),
        ("testDateInRegion_RandomDatesInRange", testDateInRegion_RandomDatesInRange),
        ("testDateInRegion_RandomDatesBackToDays", testDateInRegion_RandomDatesBackToDays),
        ("testDateInRegion_EnumareDates", testDateInRegion_EnumareDates),
        ("testDateInRegion_oldestAndNewestAndSortsIn", testDateInRegion_oldestAndNewestAndSortsIn)
    ]
}

extension TestDateInRegion_Langs {
    static var allTests: [(String, (TestDateInRegion_Langs) -> () throws -> Void)] = [
        ("testLanguages", testLanguages)
    ]
}

extension TestDateInRegion_Math {
    static var allTests: [(String, (TestDateInRegion_Math) -> () throws -> Void)] = [
        ("testDateInRegion_DateTruncated", testDateInRegion_DateTruncated),
        ("testDateInRegion_Rounding", testDateInRegion_Rounding),
        ("testDateInRegion_MathOperations", testDateInRegion_MathOperations)
    ]
}

extension TestFormatters {
    static var allTests: [(String, (TestFormatters) -> () throws -> Void)] = [
        ("testDotNETFormatter", testDotNETFormatter),
        ("testRSSFormatter", testRSSFormatter),
        ("testRSSAltFormatter", testRSSAltFormatter),
        ("testSQLFormatter", testSQLFormatter),
        ("testISOFormatter", testISOFormatter),
        ("testTZInISOParser", testTZInISOParser),
        ("testRSSAltLocale", testRSSAltLocale),
        ("testTimeInterval_Clock", testTimeInterval_Clock),
        ("testFormatterCustom", testFormatterCustom),
        ("testTimeInterval_FormatterUnits", testTimeInterval_FormatterUnits),
        ("testTimeInterval_Formatter", testTimeInterval_Formatter),
        ("testColloquialFormatter", testColloquialFormatter),
        ("testISOParser", testISOParser)
    ]
}

extension TestRegion {
    static var allTests: [(String, (TestRegion) -> () throws -> Void)] = [
        ("testRegionInit", testRegionInit)
    ]
}

extension TestSwiftDate {
    static var allTests: [(String, (TestSwiftDate) -> () throws -> Void)] = [
        ("testAutoFormats", testAutoFormats)
    ]
}

XCTMain([
    testCase(TestDateInRegion.allTests),
    testCase(TestDateInRegion_Compare.allTests),
    testCase(TestDateInRegion_Components.allTests),
    testCase(TestDateInRegion_Create.allTests),
    testCase(TestDateInRegion_Langs.allTests),
    testCase(TestDateInRegion_Math.allTests),
    testCase(TestFormatters.allTests),
    testCase(TestRegion.allTests),
    testCase(TestSwiftDate.allTests)
])
