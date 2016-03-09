//
//  NSTimeIntervalTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 22/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftDate

class NSTimeIntervalSpec: QuickSpec {

    override func spec() {

        describe("NSTimeInterval") {

            context("fromNow") {
                it("should return the proper date") {
                    let now = NSDate()
                    let interval = NSTimeInterval(3600)
                    expect(interval.fromNow!) >= now + 1.hours
                    expect(interval.fromNow!) <= now + 1.hours + 1.seconds
                }
            }

            context("ago") {
                it("should return the proper date") {
                    let now = NSDate()
                    let interval = NSTimeInterval(3600)
                    expect(interval.ago!) >= now - 1.hours
                    expect(interval.ago!) <= now - 1.hours + 1.seconds
                }
            }

            context("toString") {
                it("should return the proper string") {
                    let rome = Region(timeZoneName: .EuropeRome)
                    let date = NSDate(year: 2011, month: 10, day: 9, region: rome)
                    let interval = date.timeIntervalSinceReferenceDate
                    expect(interval.toString()) == "10y 9m 5d 22h"
                }
            }

            context("conversions") {
                it ("should return nanoseconds") {
                    let timeInterval = NSTimeInterval(4)
                    let nanoseconds = timeInterval.nanoseconds
                    expect(nanoseconds) == 4000.0
                }

                it ("should return seconds") {
                    let timeInterval = NSTimeInterval(4)
                    let seconds = timeInterval.seconds
                    expect(seconds) == 4.0
                }

                it ("should return minutes") {
                    let timeInterval = NSTimeInterval(150)
                    let minutes = timeInterval.minutes
                    expect(minutes) == 2.5
                }

                it ("should return hours") {
                    let timeInterval = NSTimeInterval(5400)
                    let hours = timeInterval.hours
                    expect(hours) == 1.5
                }

                it ("should return days") {
                    let timeInterval = NSTimeInterval(172800)
                    let days = timeInterval.days
                    expect(days) == 2.0
                }

                it ("should return weeks") {
                    let timeInterval = NSTimeInterval(2419200)
                    let weeks = timeInterval.weeks
                    expect(weeks) == 4.0
                }
            }
        }
    }
}
