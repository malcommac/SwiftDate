//
//  NSDateComponentsTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 22/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftDate

class NSDateComponentsSpec: QuickSpec {

    override func spec() {

        describe("NSDateComponents") {

            var components: NSDateComponents!
            var date: NSDate!
            beforeEach {
                components = NSDateComponents()
                components.year = 1
                components.month = 2
                components.day = 3
                components.second = 4
                date = NSDate(year: 2006, month: 7, day: 19, hour: 13)
            }

            context("fromDate") {
                it("should return date with added components") {
                    let newDate = components.fromDate(date)
                    expect(newDate.year) == 2007
                    expect(newDate.month) == 9
                    expect(newDate.day) == 22
                    expect(newDate.hour) == 13
                    expect(newDate.second) == 4
                }
            }

            context("agoFromDate") {
                it("should return date with subtracted components") {
                    let newDate = components.agoFromDate(date)
                    expect(newDate.year) == 2005
                    expect(newDate.month) == 5
                    expect(newDate.day) == 16
                    expect(newDate.hour) == 12
                    expect(newDate.second) == 56
                }
            }
        }
    }
}
