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

class NSDateIntervalSpec: QuickSpec {

    override func spec() {

        describe("NSDateInterval") {

            context("initialisation") {

                it("start & end") {
                    let startDate = NSDate(year: 2012, month: 3, day: 4)
                    let endDate = NSDate(year: 2012, month: 3, day: 5)

                    let dateInterval = NSDateInterval(start: startDate, end: endDate)
                    expect(dateInterval).toNot(beNil())
                    expect(dateInterval.start) == startDate
                    expect(dateInterval.end) == endDate
                }

                it("interval") {
                    let startDate = NSDate(year: 2012, month: 3, day: 4)
                    let interval = NSTimeInterval(24 * 60 * 60)

                    let dateInterval = NSDateInterval(start: startDate, interval: interval)
                    expect(dateInterval).toNot(beNil())
                    expect(dateInterval.start) == startDate
                    expect(dateInterval.interval) == interval
                }
            }
        }
    }
}
