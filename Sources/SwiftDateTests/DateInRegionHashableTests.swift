//
//  DateInRegionEquationsTests.swift
//  DateInRegion
//
//  Created by Jeroen Houtzager on 07/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import SwiftDate

class DateInRegionHashableTests: QuickSpec {

    override func spec() {

        let netherlands = Region(calendarName: .Gregorian, timeZoneName: .EuropeAmsterdam, localeName: .DutchNetherlands)
        let utc = Region(calendarName: .Gregorian, timeZoneName: .Gmt, localeName: .English)

        describe("DateInRegionHashable") {

            it("should return an equal hash for the same date reference") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)

                expect(date1.hashValue) == date1.hashValue
            }

            it("should return an equal hash for the same date value") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)
                let date2 = DateInRegion(year: 1999, month: 12, day: 31)

                expect(date1.hashValue) == date2.hashValue
            }

            it("should return an unequal hash for a different date value") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)

                expect(date1.hashValue) != date2.hashValue
            }

            it("should return an unequal hash for a different time zone value") {
                let date = NSDate()
                let date1 = DateInRegion(absoluteTime: date, region: netherlands)
                let date2 = DateInRegion(absoluteTime: date, region: utc)

                expect(date1.hashValue) != date2.hashValue
            }

        }

    }


}
