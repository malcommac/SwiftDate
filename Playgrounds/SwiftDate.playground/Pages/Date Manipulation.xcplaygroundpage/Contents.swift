import Foundation
import SwiftDate

/*:
## 3.0 - Add & Subtract Time Units from Date

SwiftDate allows to use numbers to work with time components in dates. By extending the `Int` type it defines a list of time units:

- `nanoseconds`
- `seconds`
- `minutes`
- `days`
- `weeks`
- `months`
- `quarters`
- `years`

You can use a value followed by one of these unit specifications to add or remove the component from a date.

So, for example, you can produce a date which can be a mix of intuitive math operations:
*/
let date1 = DateInRegion() + 1.years
let date2 = DateInRegion() - 2.minutes
let date3 = date2 + 3.hours - 5.minutes + 1.weeks
/*:
> IMPORTANT NOTE: These values are converted automatically to `DateComponents` evaluated in the same context of the target `Date` or `DateInRegion`'s `calendar`.

Another way to add time components to a date is to use the `dateByAdding()` function:
*/
let date4 = DateInRegion().dateByAdding(5, .month)
/*:

## 3.1 - Get DateTime Components Components
With SwiftDate you have several convenience properties to inspect each datetime unit of a date, both for `Date` and `DateInRegion`.

These properties are strictly correlated to the date's calendar (and some also with locale): if you are manipulating a `DateInRegion` remember these properties return values in the context of the associated `region` attributes (Locale, TimeZone and Calendar).

> **IMPORTANT NOTE**: If you are working with plain `Date` properties uses as reference the currently set `SwiftDate.defaultRegion` which, unless you modify it, is set to Gregorian/UTC/Device's Language.
*/
let regionNY = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.english)
let date5 = DateInRegion(components: {
	$0.year = 2015
	$0.month = 6
	$0.day = 1
	$0.hour = 23
}, region: regionNY)!

print("Origin date in NY: \(date5.hour):\(date5.minute) of \(date5.day)/\(date5.month)")
print("Month is \(date5.monthName(.default).uppercased())")
print("Month in italian is \(date5.convertTo(locale: Locales.italian).monthName(.default).uppercased())")

// We can convert it to UTC and get the same properties which are now updated!
let date5InUTC = date5.convertTo(region: Region.UTC)
print("Converted date in UTC: \(date5InUTC.hour):\(date5InUTC.minute) of \(date5InUTC.day)/\(date5InUTC.month)")
/*:

## 3.2 - Get Interval Between Dates
You can get the interval between two dates and express it in form of time units easily with SwiftDate.
*/
let format = "yyyy-MM-dd HH:mm:ss"
let date6 = DateInRegion("2017-07-22 00:00:00", format: format, region: regionNY)!
let date7 = DateInRegion("2017-07-23 12:00:00", format: format, region: regionNY)!

let hours = date6.getInterval(toDate: date7, component: .hour) // 36 hours
let days = date6.getInterval(toDate: date7, component: .day) // 1 day
/*:
## 3.3 - Convert Date's Region (Locale/TimeZone/Calendar)
`DateInRegion` can be converted easily to anothe region just using `.convertTo(region:)` or `.convertTo(calendar: timezone:locale:)` functions.

- `convertTo(region:)` convert the receiver date to another region. Region may include a different time zone for example, or a locale.
- `convertTo(calendar:timezone:locale:)` allows to convert the receiver date instance to a specific calendar/timezone/locale. All parameters are optional and only non-nil parameters alter the final region. For a nil param the current receiver's region attribute is kept.

Examples:
*/
// Create a date in NY: "2001-09-11 12:00:05"
let date8 = DateInRegion(components: {
	$0.year = 2001
	$0.month = 9
	$0.day = 11
	$0.hour = 12
	$0.minute = 0
	$0.second = 5
}, region: regionNY)!
// Convert to GMT timezone (and locale)
let date8inGMT = date8.convertTo(region: Region.UTC) // date is now: "2001-09-11 16:00:05"
print(date8inGMT.toISO())
/*:

## 3.4 - Rounding Date

`.dateRoundedAt()` function allows to round a given date time to the passed style: off, up or down.
*/
let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)

// Round down 10mins
let date9 = DateInRegion("2017-07-22 00:03:50", format: format, region: regionRome)!
let r10min = date9.dateRoundedAt(.to10Mins)
/*:

## 3.5 - Trouncating Date
Sometimes you may need to truncate a date by zeroing all values below certain time unit. `.dateTruncated(from:) and .dateTruncated(to:)` functions can be used for this scope.

#### Truncating From
It creates a new instance by truncating the components starting from given components down the granurality.

`func dateTruncated(from component: Calendar.Component) -> DateInRegion?`

#### Truncated At
It creates a new instance by truncating all passed components.

`func dateTruncated(at components: [Calendar.Component]) -> DateInRegion?`
*/
let date10 = "2017-07-22 15:03:50".toDate("yyyy-MM-dd HH:mm:ss", region: regionRome)!

let truncatedTime = date10.dateTruncated(from: .hour)
let truncatedCmps = date10.dateTruncated(at: [.month, .day, .minute])
/*:

## 3.6 - Set Time in Date
Sometimes you may need to alter time in a specified date. SwiftDate allows you to perform this using `.dateBySet(hour:min:secs:options:)` function.
*/
let date11 = DateInRegion("2010-01-01 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
let alteredDate = date11.dateBySet(hour: 20, min: 13, secs: 15)
/*:
## 3.7 - Set DateTime Components
SwiftDate allows you to return new date representing the date calculated by setting a specific components of a given date to  given values, while trying to keep lower components the same (altering more components at the same time may result in different-than-expected results, this because lower components maybe need to be recalculated).
*/
let date12 = date11.dateBySet([.month: 1, .day: 1, .hour: 9, .minute: 26, .second: 0])
/*:
## 3.8 - Generate Related Dates (`nextYear, nextWeeekday, startOfMonth, startOfWeek, prevMonth`...)
Sometimes you may need to generate a related date from a specified instance; maybe the next sunday, the first day of the next week or the start datetime of a date.
SwiftDate includes 20+ different "interesting" dates you can obtain by calling `.dateAt()` function from any `Date` or `DateInRegion` instance.
*/
// Return today's datetime at 00:00:00
let date13 = DateInRegion().dateAt(.startOfDay)
// Return today's datetime at 23:59:59
let date14 = DateInRegion().dateAt(.endOfDay)
// Return the date at the start of this week
let date15 = DateInRegion().dateAt(.startOfWeek)
// Return current time tomorrow
let date16 = DateInRegion().dateAt(.tomorrow)
// Return the next sunday from specified date
let date17 = date16.dateAt(.nextWeekday(.sunday))
// and so on...

/*:

## 3.9 - Date at start/end of time component
Two functions called `.dateAtStartOf()` and `.dateAtEndOf()` allows you to get the related date from a `Date`/`DateInRegion` instance moved at the start or end of the specified component.
*/
// Return today's date at 23:59:59
let date18 = DateInRegion().dateAtEndOf(.day)
// Return the first day's date of the month described in date1
let date19 = DateInRegion().dateAtStartOf(.month)
// Return the first day of the current week at 00:00
let date20 = DateInRegion().dateAtStartOf([.week, .day])
/*:

## 3.10 - Enumerate Dates
Dates enumeration function allows you to generate a list of dates in a closed date intervals incrementing date components by a fixed or variable interval at each new date.

- **VARIABLE INCREMENT** `static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: ((DateInRegion) -> (DateComponents))) -> [DateInRegion]`
- **FIXED INCREMENT** `static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: DateComponents) -> [DateInRegion]`
*/
let toDate = DateInRegion()
let fromDate = toDate - 30.days
let dates = DateInRegion.enumerateDates(from: fromDate, to: toDate, increment: DateComponents.create {
	$0.hour = 1
	$0.minute = 30
})
/*:

## 3.11 - Random Dates
SwiftDate exposes a set of functions to generate a random date or array of random dates in a bounds.
There are several functions to perform this operation:
*/
let randomDates = DateInRegion.randomDates(count: 40,
										   between: fromDate,
										   and: toDate)
let randomDate = DateInRegion.randomDate(withinDaysBeforeToday: 7, region: regionRome)
/*:

## 3.12 - Sort Dates
Two conveniences function allows you to sort an array of dates by newest or oldest. Naming is pretty simple:
*/
let orderedByNewest = DateInRegion.sortedByNewest(list: randomDates)
let oldestDate = DateInRegion.oldestIn(list: randomDates)
