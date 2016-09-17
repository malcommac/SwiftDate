//
//  NSDateIntervalTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 21/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
import SwiftDate

class DateIntervalSpec: QuickSpec {

    override func spec() {

        describe("DateInterval") {

            context("initialisation") {

                it("start & end") {
                    let startDate = Date(year: 2012, month: 3, day: 4)
                    let endDate = Date(year: 2012, month: 3, day: 5)

                    let dateInterval = SwiftDate.DateInterval(start: startDate, end: endDate)
                    expect(dateInterval).toNot(beNil())
                    expect(dateInterval.start) == startDate
                    expect(dateInterval.end) == endDate
                }

                it("interval") {
                    let startDate = Date(year: 2012, month: 3, day: 4)
                    let interval = TimeInterval(24 * 60 * 60)

                    let dateInterval = DateInterval(start: startDate, interval: interval)
                    expect(dateInterval).toNot(beNil())
                    expect(dateInterval.start) == startDate
                    expect(dateInterval.interval) == interval
                }
            }
        }
    }
}
