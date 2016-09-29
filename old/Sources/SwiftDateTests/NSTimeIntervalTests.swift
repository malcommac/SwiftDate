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
        }
    }
}
