import Foundation
import SwiftDate
/*:
## 5.0 - Format Custom Style
If you need to format a `Date` or `DateInRegion` in a String using a custom format you need to use `toFormat(_:locale:)` function.
*/
let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
let date1 = DateInRegion(year: 2015, month: 1, day: 15, hour: 20, minute: 00, second: 5, nanosecond: 0, region: rome)

// Even if date's locale is set to `italin` we can still
// print in a different language by passing a non nil locale
// to the function.
let formattedString = date1.toFormat("MMM dd yyyy", locale: Locales.english) // "Jan 15 2015"
/*:

## 5.1 - ISO8601 Formatted String
SwiftDate allows to print date instances using a configurable ISO8601 formatter which is also compatible with older version of iOS where the Apple's own class is not available.

To use the ISO formatter call `.toISO()` function
*/
let date2 = DateInRegion("2017-07-22 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: rome)!

// ISO Formatting
let date2_str1 = date2.toISO() // "2017-07-22T00:00:00+02:00"
let date2_str2 = date2.toISO([.withFullDate]) // "2017-07-22"
let date2_str3 = date2.toISO([.withFullDate, .withFullTime, .withDashSeparatorInDate, .withSpaceBetweenDateAndTime]) // "2017-07-22 00:00:00+02:00"
/*:

## 5.2 - .NET Formatted String
CSOM DateTime (aka .NET DateTime) is a format defined by Microsoft as the number of 100-nanosecond intervals that have elapsed since 12:00 A.M., January 1, 0001 ([learn more on MSDN documentation page](https://msdn.microsoft.com/en-us/library/dd948679)).

Use the `.toDotNET()` function to create a string from a date instance.
*/
let date3 = "2017-06-20T14:49:19+02:00".toISODate()!
let date3_dotNetString = date3.toDotNET() // "/Date(1497962959000+0200)/"
/*:

## 5.3 - RSS/AltRSS Formatted String
RSS and AltRSS formatted string can be generated from an instance of `Date` or `DateInRegion` using the `.toRSS()` function.
*/

let rssString = date3.toRSS(alt: false) // "Tue, 20 Jun 2017 14:49:19 +0200"
let altRSSString = date3.toRSS(alt: true) // "20 Jun 2017 14:49:19 +0200"
/*:

## 5.4 - SQL Formatted String
To print SQL formatted string from a date instance you need to use the `.toSQL()` function.
*/
let sqlString = date3.toSQL() // "2015-11-19T22:20:40.000+01"
/*:

## 5.5 - Relative/Colloquial Formatted String
Colloquial format allows you to produce human friendly string as result of the difference between a date and a a reference date (typically now).
Examples of colloquial formatted strings are `3 mins ago`, `2 days ago` or `just now`.

SwiftDate supports over 140+ languages to produce colloquial formatted strings; the entire engine behind the library is fully customizable so, if you need, you can override default strings and produce your own variants.

To print a colloquial variant of a string just call `.toRelative()` function from a `Date` or `DateInRegion` instance.
*/
let ago5Mins = DateInRegion() - 5.minutes
_ = ago5Mins.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.italian) // "5 minuti fa"

let justNow2 = DateInRegion() - 2.hours
_ = justNow2.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian) // "2h fa"

let justNow = DateInRegion() - 10.seconds
_ = justNow.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian) // "ora"
