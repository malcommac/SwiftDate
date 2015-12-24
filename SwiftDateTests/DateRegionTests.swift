//
//  DateRegionTests.swift
//  DateInRegion
//
//  Created by Jeroen Houtzager on 10/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
import SwiftDate

class DateregionSpec: QuickSpec {

    override func spec() {

        describe("DateRegion") {

            let region = DateRegion()
            let india = DateRegion(calendarID: NSCalendarIdentifierIndian, timeZoneID: "IST", localeID: "en_IN")
            let hebrew = DateRegion(calendarID: NSCalendarIdentifierHebrew, timeZoneID: "Asia/Jerusalem", localeID: "he_IL")

            context("soon to be deprecated parameters") {
                // CalType, tzName & Region type
                let china = DateRegion(calType: CalendarType.RepublicOfChina, tzName: TimeZones.Asia.Shanghai)
                let dubai = Region(calType: CalendarType.IslamicCivil, tzName: TimeZones.Asia.Dubai)
                
                it("should have the specified calendar") {
                    expect(china.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierRepublicOfChina)
                    expect(dubai.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamicCivil)
                }
                
                it("should have the specified time zone") {
                    expect(china.timeZone) == NSTimeZone(name: "Asia/Shanghai")
                    expect(dubai.timeZone) == NSTimeZone(name: "Asia/Dubai")
                }
            }
            
            context("initialisation") {

                it("should have the default time zone & locale in the current calendar") {
                    expect(region.calendar.calendarIdentifier) == NSCalendar.currentCalendar().calendarIdentifier
                    expect(region.timeZone.abbreviation) == NSTimeZone.defaultTimeZone().abbreviation
                    expect(region.locale.localeIdentifier) == NSLocale.currentLocale().localeIdentifier
                    expect(region.calendar.timeZone.abbreviation) == NSTimeZone.defaultTimeZone().abbreviation
                    expect(region.calendar.locale?.localeIdentifier) == NSLocale.currentLocale().localeIdentifier
                }

                it("should have the specified calendar") {
                    expect(hebrew.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)!
                }

                it("should have the specified time zone") {
                    expect(hebrew.timeZone) == NSTimeZone(name: "Asia/Jerusalem")
                }

                it("should have the specified time zone") {
                    expect(india.timeZone) == NSTimeZone(abbreviation: "IST")!
                }

                it("should have the specified locale") {
                    expect(hebrew.locale) == NSLocale(localeIdentifier: "he_IL")
                }
            }

            context("today func") {

                it("should return a proper current date for today") {
                    let today = region.today()

                    expect(today.calendar.isDateInToday(today.absoluteTime))
                    expect(today.region) == region
                }

                it("should return a proper tomorrow") {
                    let tomorrow = DateRegion().tomorrow()

                    expect(tomorrow.calendar.isDateInTomorrow(tomorrow.absoluteTime))
                }

                it("should return a proper yesterday") {
                    let yesterday = DateRegion().yesterday()

                    expect(yesterday.calendar.isDateInYesterday(yesterday.absoluteTime))
                }
                
            }
            
            context("equation") {

                it("should return true when equal") {
                    let region = DateRegion()

                    expect(region) == region
                }
                
                it("should return true when equal values") {
                    let region1 = DateRegion()
                    let region2 = DateRegion()

                    expect(region1) == region2
                }
                
                it("should return false when unequal calendars") {
                    let region1 = DateRegion(calendarID: NSCalendarIdentifierIslamic)
                    let region2 = DateRegion(calendarID: NSCalendarIdentifierIslamicCivil)

                    expect(region1) != region2
                }
                
                it("should return false when unequal time zones") {
                    let region1 = DateRegion(timeZoneID: "UTC")
                    let region2 = DateRegion(timeZoneID: "CET")

                    expect(region1) != region2
                }
                
                it("should return false when unequal locales") {
                    let region1 = DateRegion(localeID: "nl_NL")
                    let region2 = DateRegion(localeID: "en_NZ")

                    expect(region1) != region2
                }
                
            }
            

        }
    }
}

