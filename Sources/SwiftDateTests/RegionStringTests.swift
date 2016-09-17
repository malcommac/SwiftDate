//
//  SwiftDateTests.swift
//  SwiftDateTests
//
//  Created by Daniele Margutti on 23/11/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftDate

class DateRegionStringSpec: QuickSpec {

    override func spec() {

        describe("Date extension") {

            let utc = Region(calendarName: .gregorian, timeZoneName: .gmt, localeName: .english)

            context("toString UTC") {

                let utcDate = DateInRegion(year: 2015, month: 4, day: 13, hour: 22, minute: 10, region: utc)

                it("should return proper ISO 8601 string") {
                    expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.full))) == "2015-04-13T22:10:00Z"
                }

                it("should return proper ISO 8601 date string") {
                    expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.date))) == "2015-04-13"
                }

				it("should return proper ISO 8601 (year format) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.year))) == "2015"
				}

				it("should return proper ISO 8601 (year/month format) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.yearMonth))) == "2015-04"
				}

				it("should return proper ISO 8601 (date format) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.date))) == "2015-04-13"
				}
				
				it("should return proper ISO 8601 (hour minute) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.hourMinute))) == "22:10"
				}
				
				it("should return proper ISO 8601 (time) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.time))) == "22:10:00"
				}

				it("should return proper ISO 8601 (date time format) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.dateTime))) == "2015-04-13T22:10Z"
				}

				it("should return proper ISO 8601 (full format) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.full))) == "2015-04-13T22:10:00Z"
				}

				it("should return proper ISO 8601 (extended with fractional seconds format) string") {
					expect(utcDate.toString(dateFormat: DateFormat.iso8601Format(.extended))) == "2015-04-13T22:10:00.000Z"
				}

                it("should return proper Alt RSS date string") {
                    expect(utcDate.toString(dateFormat: DateFormat.altRSS)) == "13 Apr 2015 22:10:00 +0000"
                }

                it("should return proper RSS date string") {
                    expect(utcDate.toString(dateFormat: DateFormat.rss)) == "Mon, 13 Apr 2015 22:10:00 +0000"
                }

                it("should return proper custom date string") {
                    expect(utcDate.toString(dateFormat: DateFormat.custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                }

                it("should return proper custom date string") {
                    expect(utcDate.toString(dateFormat: DateFormat.custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))) == "Mon 13 Apr 2015, 10 minutes after 22 (timezone is +0000)"
                }
            }

            context("toString local") {

                let date = Date(year: 2015, month: 4, day: 13, hour: 22, minute: 10)
                let localDate = date.inRegion()

                it("should return proper ISO 8601 string") {
                    expect(localDate.toString(dateFormat: DateFormat.iso8601Format(.full))!.hasPrefix("2015-04-13T22:10:00")) == true
                    expect(date.toString(format: DateFormat.iso8601Format(.full))!.hasPrefix("2015-04-13T22:10:00")) == true
                }

                it("should return proper ISO 8601 date string") {
                    expect(localDate.toString(dateFormat: DateFormat.iso8601Format(.date))) == "2015-04-13"
                    expect(date.toString(format: DateFormat.iso8601Format(.date))) == "2015-04-13"
                }

                it("should return proper Alt RSS date string") {
                    expect(localDate.toString(dateFormat: DateFormat.altRSS)!.hasPrefix("13 Apr 2015 22:10:00")) == true
                    expect(date.toString(format: DateFormat.altRSS)!.hasPrefix("13 Apr 2015 22:10:00")) == true
                }

                it("should return proper RSS date string") {
                    expect(localDate.toString(dateFormat: DateFormat.rss)!.hasPrefix("Mon, 13 Apr 2015 22:10:00")) == true
                    expect(date.toString(format: DateFormat.rss)!.hasPrefix("Mon, 13 Apr 2015 22:10:00")) == true
                }

                it("should return proper custom date string") {
                    expect(localDate.toString(dateFormat: DateFormat.custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                    expect(date.toString(format: DateFormat.custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                }

                it("should return proper custom date string") {
                    expect(localDate.toString(dateFormat: DateFormat.custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))!.hasPrefix("Mon 13 Apr 2015, 10 minutes after 22 (timezone is ")) == true
                    expect(date.toString(format: DateFormat.custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))!.hasPrefix("Mon 13 Apr 2015, 10 minutes after 22 (timezone is ")) == true
                }
            }
        }
    }
}
