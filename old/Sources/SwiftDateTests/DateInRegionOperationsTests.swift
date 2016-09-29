//
//  DateInRegionOperationsTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 19/02/16.
//  Copyright © 2016 breakfastcode. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
import SwiftDate

class DateInRegionOperationsSpec: QuickSpec {

    override func spec() {

        describe("DateInRegionOperations") {

            let region = Region(calendarName: .Gregorian, timeZoneName: .AmericaParamaribo, localeName: .Dutch)
            let date = DateInRegion(year: 2015, month: 12, day: 14, hour: 13, region: region)

            context("add with components") {

                it("adds with zero") {
                    expect(date.add()) == date
                }

                it("adds with a day") {
                    expect(date.add(days: 1)) == date + 1.days
                }
            }

            context("add with dictionary") {

                it("adds with a day") {
                    expect(date.add(components: [NSCalendarUnit.Day: 1])) == date + 1.days
                }
            }
        }
    }
}
