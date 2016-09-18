//
//  NSCalendarTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 22/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftDate

class NSCalendarSpec: QuickSpec {

    override func spec() {

        describe("Calendar") {

            let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
            let date = Date(year: 2016, month: 2, day: 3)

            context("rangeOfUnit") {

                it("day") {
                    let interval = gregorian.range(of: .day, for: date)
                    expect(interval).toNot(beNil())
                    expect(interval!.start) == Date(year: 2016, month: 2, day: 3)
                    expect(interval!.end) == Date(year: 2016, month: 2, day: 4)
                }

                it("month") {
                    let interval = gregorian.range(of: .month, for: date)
                    expect(interval).toNot(beNil())
                    expect(interval!.start) == Date(year: 2016, month: 2, day: 1)
                    expect(interval!.end) == Date(year: 2016, month: 3, day: 1)
                }
            }

            context("fromType") {

                it("should return a Gregorian calendar") {
                    expect(CalendarName.gregorian.calendar) == Calendar(identifier: Calendar.Identifier.gregorian)
                }

                it("should return a Coptic calendar") {
                    expect(CalendarName.coptic.calendar) == Calendar(identifier: Calendar.Identifier.coptic)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.islamic.calendar) == Calendar(identifier: Calendar.Identifier.islamic)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.islamicCivil.calendar) == Calendar(identifier: Calendar.Identifier.islamicCivil)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.islamicTabular.calendar) == Calendar(identifier: Calendar.Identifier.islamicTabular)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.islamicUmmAlQura.calendar) == Calendar(identifier: Calendar.Identifier.islamicUmmAlQura)
                }

                it("should return a Buddhist calendar") {
                    expect(CalendarName.buddhist.calendar) == Calendar(identifier: Calendar.Identifier.buddhist)
                }

                it("should return a Ethiopian calendar") {
                    expect(CalendarName.ethiopicAmeteAlem.calendar) == Calendar(identifier: Calendar.Identifier.ethiopicAmeteAlem)
                }

                it("should return a Ethiopian calendar") {
                    expect(CalendarName.ethiopicAmeteMihret.calendar) == Calendar(identifier: Calendar.Identifier.ethiopicAmeteMihret)
                }

                it("should return a Hebrew calendar") {
                    expect(CalendarName.hebrew.calendar) == Calendar(identifier: Calendar.Identifier.hebrew)
                }

                it("should return a ISO8601 calendar") {
                    expect(CalendarName.iso8601.calendar) == Calendar(identifier: Calendar.Identifier.iso8601)
                }

                it("should return an Indian calendar") {
                    expect(CalendarName.indian.calendar) == Calendar(identifier: Calendar.Identifier.indian)
                }

                it("should return a Japanese calendar") {
                    expect(CalendarName.japanese.calendar) == Calendar(identifier: Calendar.Identifier.japanese)
                }

                it("should return a Persian calendar") {
                    expect(CalendarName.persian.calendar) == Calendar(identifier: Calendar.Identifier.persian)
                }

                it("should return a current calendar") {
                    expect(CalendarName.current.calendar) == Calendar.current
                }

                it("should return an autoupdating current calendar") {
                    expect(CalendarName.autoUpdatingCurrent.calendar) == Calendar.autoupdatingCurrent
                }

                it("should return a chinese calendar") {
                    expect(CalendarName.republicOfChina.calendar) == Calendar(identifier: Calendar.Identifier.republicOfChina)
                }
            }
        }
    }
}
