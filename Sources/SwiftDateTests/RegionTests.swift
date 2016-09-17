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
            let india = Region(calendarName: .indian, timeZoneName: .asiaKolkata, localeName: .hindiIndia)
            let jerusalem = Region(calendarName: .hebrew, timeZoneName: .asiaJerusalem, localeName: .hebrewIsrael)

            context("initialisation") {

                it("should have the default time zone & locale in the current calendar") {
                    expect(region.calendar.identifier) == Calendar.current.identifier
                    expect(region.timeZone.abbreviation()) == TimeZone.current.abbreviation()
                    expect(region.locale.identifier) == Locale.current.identifier
                    expect(region.calendar.timeZone.abbreviation()) == TimeZone.current.abbreviation()
                    expect(region.calendar.locale?.identifier) == Locale.current.identifier
                }

                it("should have the specified calendar") {
                    expect(jerusalem.calendar) == Calendar(identifier: Calendar.Identifier.hebrew)
                }

                it("should have the specified time zone") {
                    expect(jerusalem.timeZone) == TimeZone(identifier: "Asia/Jerusalem")
                }

                it("should have the specified time zone") {
                    expect(india.timeZone.identifier) == TimeZoneName.asiaKolkata.description
                }

                it("should have the specified locale") {
                    expect(jerusalem.locale) == Locale(identifier: "he_IL")
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
                    let region1 = Region(calendarName: .islamic)
                    let region2 = Region(calendarName: .islamicCivil)

                    expect(region1) != region2
                }

                it("should return false when unequal time zones") {
                    let region1 = Region(timeZoneName: .americaKralendijk)
                    let region2 = Region(timeZoneName: .africaWindhoek)

                    expect(region1) != region2
                }

                it("should return false when unequal locales") {
                    let region1 = Region(localeName: .hausaNiger)
                    let region2 = Region(localeName: .englishFiji)

                    expect(region1) != region2
                }

            }


        }
    }
}
