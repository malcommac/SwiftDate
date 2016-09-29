//
//  SwiftDateCalendarTests.swift
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

        describe("NSCalendar") {

            let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let date = NSDate(year: 2016, month: 2, day: 3)

            context("rangeOfUnit") {

                it("day") {
                    let interval = gregorian.rangeOfUnit(.Day, forDate: date)
                    expect(interval).toNot(beNil())
                    expect(interval!.start) == NSDate(year: 2016, month: 2, day: 3)
                    expect(interval!.end) == NSDate(year: 2016, month: 2, day: 4)
                }

                it("month") {
                    let interval = gregorian.rangeOfUnit(.Month, forDate: date)
                    expect(interval).toNot(beNil())
                    expect(interval!.start) == NSDate(year: 2016, month: 2, day: 1)
                    expect(interval!.end) == NSDate(year: 2016, month: 3, day: 1)
                }
            }

            context("fromType") {

                it("should return a Gregorian calendar") {
                    expect(CalendarName.Gregorian.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                }

                it("should return a Coptic calendar") {
                    expect(CalendarName.Coptic.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierCoptic)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.Islamic.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamic)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.IslamicCivil.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamicCivil)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.IslamicTabular.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamicTabular)
                }

                it("should return a Islamic calendar") {
                    expect(CalendarName.IslamicUmmAlQura.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamicUmmAlQura)
                }

                it("should return a Buddhist calendar") {
                    expect(CalendarName.Buddhist.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierBuddhist)
                }

                it("should return a Ethiopian calendar") {
                    expect(CalendarName.EthiopicAmeteAlem.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierEthiopicAmeteAlem)
                }

                it("should return a Ethiopian calendar") {
                    expect(CalendarName.EthiopicAmeteMihret.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierEthiopicAmeteMihret)
                }

                it("should return a Hebrew calendar") {
                    expect(CalendarName.Hebrew.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)
                }

                it("should return a ISO8601 calendar") {
                    expect(CalendarName.ISO8601.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
                }

                it("should return an Indian calendar") {
                    expect(CalendarName.Indian.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierIndian)
                }

                it("should return a Japanese calendar") {
                    expect(CalendarName.Japanese.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierJapanese)
                }

                it("should return a Persian calendar") {
                    expect(CalendarName.Persian.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierPersian)
                }

                it("should return a current calendar") {
                    expect(CalendarName.Current.calendar) == NSCalendar.currentCalendar()
                }

                it("should return an autoupdating current calendar") {
                    expect(CalendarName.AutoUpdatingCurrent.calendar) == NSCalendar.autoupdatingCurrentCalendar()
                }

                it("should return a chinese calendar") {
                    expect(CalendarName.RepublicOfChina.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierRepublicOfChina)
                }
            }
        }
    }
}
