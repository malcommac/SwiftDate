//
//  DateInRegionEquationsTests.swift
//  DateInRegion
//
//  Created by Jeroen Houtzager on 07/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import DateInRegion

class DateInRegionEquationsTests: QuickSpec {

    override func spec() {

        describe("DateInRegionEquations") {

            let china = DateRegion(calendarID: NSCalendarIdentifierBuddhist, timeZoneID: "CHT", localeID: "zh_CN")
            let netherlands = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")

            it("should return true for equating a different object with the same properties") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)!
                let date2 = date1

                expect(date1 == date2) == true
            }

            it("should return true for equating the same object") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)!
                let date2 = date1

                expect(date1 == date2) == true
            }

            it("should return false for equating objects with different dates") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)!
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date1 == date2) == false
            }

            it("should return false for equating objects with different regions") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31, region: netherlands)!
                let date2 = DateInRegion(refDate: date1, region: china)

                expect(date1 == date2) == false
            }
        }

    }

        
}
