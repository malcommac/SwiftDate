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

class DateInRegionEquationsTests: QuickSpec {

    override func spec() {

        describe("DateInRegionEquations") {

            let amsterdam = Region(calendarName: .Gregorian, timeZoneName: .EuropeAmsterdam, localeName: .DutchNetherlands)
            let shanghai = Region(calendarName: .Chinese, timeZoneName: .AsiaShanghai, localeName: .ChineseChina)

            it("should return true for equating a different object with the same properties") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)
                let date2 = date1

                expect(date1 == date2) == true
            }

            it("should return true for equating the same object") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)
                let date2 = date1

                expect(date1 == date2) == true
            }

            it("should return false for equating objects with different dates") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)

                expect(date1 == date2) == false
            }

            it("should return false for equating objects with different regions") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31, region: amsterdam)
                let date2 = DateInRegion(year: 1999, month: 12, day: 31, region: shanghai)

                expect(date1 == date2) == false
            }
        }

    }


}
