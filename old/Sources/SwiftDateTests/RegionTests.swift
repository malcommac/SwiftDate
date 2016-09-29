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

        describe("Region") {

            let region = Region()
            let india = Region(calendarName: .Indian, timeZoneName: .AsiaKolkata, localeName: .HindiIndia)
            let jerusalem = Region(calendarName: .Hebrew, timeZoneName: .AsiaJerusalem, localeName: .HebrewIsrael)

            context("initialisation") {

                it("should have the default time zone & locale in the current calendar") {
                    expect(region.calendar.calendarIdentifier) == NSCalendar.currentCalendar().calendarIdentifier
                    expect(region.timeZone.abbreviation) == NSTimeZone.defaultTimeZone().abbreviation
                    expect(region.locale.localeIdentifier) == NSLocale.currentLocale().localeIdentifier
                    expect(region.calendar.timeZone.abbreviation) == NSTimeZone.defaultTimeZone().abbreviation
                    expect(region.calendar.locale?.localeIdentifier) == NSLocale.currentLocale().localeIdentifier
                }

                it("should have the specified calendar") {
                    expect(jerusalem.calendar) == NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)!
                }

                it("should have the specified time zone") {
                    expect(jerusalem.timeZone) == NSTimeZone(name: "Asia/Jerusalem")
                }

                it("should have the specified time zone") {
                    expect(india.timeZone.name) == TimeZoneName.AsiaKolkata.description
                }

                it("should have the specified locale") {
                    expect(jerusalem.locale) == NSLocale(localeIdentifier: "he_IL")
                }
            }

            context("today func") {

                it("should return a proper current date for today") {
                    let today = region.today()

                    expect(today.calendar.isDateInToday(today.absoluteTime)) == true
                    expect(today.region) == region
                }

                it("should return a proper tomorrow") {
                    let tomorrow = Region().tomorrow()

                    expect(tomorrow.calendar.isDateInTomorrow(tomorrow.absoluteTime)) == true
                }

                it("should return a proper yesterday") {
                    let yesterday = Region().yesterday()

                    expect(yesterday.calendar.isDateInYesterday(yesterday.absoluteTime)) == true
                }

            }

            context("equation") {

                it("should return true when equal") {
                    let region = Region()

                    expect(region) == region
                }

                it("should return true when equal values") {
                    let region1 = Region()
                    let region2 = Region()

                    expect(region1) == region2
                }

                it("should return false when unequal calendars") {
                    let region1 = Region(calendarName: .Islamic)
                    let region2 = Region(calendarName: .IslamicCivil)

                    expect(region1) != region2
                }

                it("should return false when unequal time zones") {
                    let region1 = Region(timeZoneName: .AmericaKralendijk)
                    let region2 = Region(timeZoneName: .AfricaWindhoek)

                    expect(region1) != region2
                }

                it("should return false when unequal locales") {
                    let region1 = Region(localeName: .HausaNiger)
                    let region2 = Region(localeName: .EnglishFiji)

                    expect(region1) != region2
                }

            }


        }
    }
}
