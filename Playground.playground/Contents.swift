import Foundation
@testable import SwiftDate

/*:
# SwiftDate

## Introduction
Foundation's `Date` object represent the absolute aumount of seconds since Jan 1, 2001 at 00:00 UTC.

You can see absolute time as the moment that someone in the USA has a telephone conversation with someone in Dubai; both have that conversation at the same moment (the absolute time) but the local time will be different due to time zones, different calendars, alphabets or notation methods.

When you use `Date you are ignoring both the Calendar and Locale in which the date is expressed.
*/

let date = Date()
print("\(Int(date.timeIntervalSinceReferenceDate)) seconds are passed since Jan 1, 2001 00:00 UTC")

/*:
## DateInRegion

SwiftDate introduces a new class called `DateInRegion` which encapsulate `Date` with geographic region called `Region`.
`Region` has three properties:
* `timeZone` the `TimeZone` in which `Date` is expressed in
* `calendar` the `Calendar` used to represent the `Date`
* `locale` the `Locale` idioma used to represent `Date` in string forms.

The following example create a region to identify Rome for an Italian user:
*/

let italy = Region(tz: TimeZoneName.europeRome,
				   cal: CalendarName.gregorian,
				   loc: LocaleName.italian)

/*:
There is a special region called Default Region; this region is used automatically when you manipulate plain `Date` objects.
Default Region is automatically set at bootstrap of your app with current device's `timezone`,`calendar` and `locale`.
You are able to set a new Default Region by calling `Date.setDefaultRegion()` function (typically you would set it on your AppDelegate).
*/

Date.setDefaultRegion(italy)
print("Default region is \(Date.defaultRegion)")

/*:
While you can work both with `Date` and `DateInRegion` we suggest to always use `DateInRegion` to make your code easy to understand and maintanable.
*/

/*:
## Create a new date

There are several way to create a new `DateInRegion`.
You can create date from String with format.
This code create a date by parsing a string with custom format:
*/

let date_1 = DateInRegion(string: "2001-01-05 at 10:20",
						  format: .custom("yyyy-MM-dd 'at' HH:mm"),
						  fromRegion: italy)
//let date_2 = DateInRegion(string: "2011-12-05T12:20:00+001", format: .iso8601Auto)


