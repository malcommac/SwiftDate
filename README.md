![SwiftDate](https://raw.githubusercontent.com/malcommac/SwiftDate/master/assets/logo.png)

##Easy NSDate Management in Swift 2

### Author
Daniele Margutti  
*web*: [www.danielemargutti.com](http://www.danielemargutti.com)  
*twitter*: [@danielemargutti](http://www.twitter.com/danielemargutti)  
*mail*: me [at] danielemargutti dot com  
*original post*: [blog](http://danielemargutti.com/how-to-manage-nsdate-easily-in-swift-with-swiftdate/)  
  
This library is licensed under MIT license and it's compatible with Swift 2.0+.

###Features
- [x] Math operations with dates ```(ie. myDate+2.week+1.hour)```
- [x] Easy compare using ```<,>,==,<=,>=``` operators
- [x] Easy individual date component set/get
- [x] Easy creation with common formats or custom formats
- [x] Powerful .toString methods with support for relative dates (ie. "2hours"...)
- [x] Many shortcuts to get intervals and common dates (yesterday,tomorrow...)
- [x] *... check out documentation below!*

###Requirements
* iOS 8.0+ / Mac OS X 10.10+
* Xcode 6.3
* Swift 2.0

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## ToDo
- Complete All Unit Tests

##Version History
##1.2 (Oct 4, 2015)
- Fixed several issues with `ISO8601 formatter` when parsing dates ending with Z
- Deprecated several comparing date methods (`minutes/hours/days/month/years Before/After` a date and replaced with a single `difference` method)
- Fixed an issue with non 24 hours days
- Added `-` (minus) operator between dates
- Added support for `carthage`
- Added optional params in `set/add` methods of dates
- Removed extra `ago/from now' string literals from `toRelativeString` method.

##1.1
- This version is fully compatible with Swift 2.0+
- Minor fixes around

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.
CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwiftDate into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'SwiftDate'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SwiftDate into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "malcommac/SwiftDate" ~> 1.2
```

Run `carthage` to build the framework and drag the built `SwiftDate.framework` into your Xcode project.

##API Documentation

###Introduction
Date Management in UIKit/AppKit is a pain, you know? Probably it's not the better API bought by Apple for Mac or iOS. If you have worked in ObjC you know, there are lots of classes to manipulate date objects easily.
I've made SwiftDates because I've started working with Swift development and I need something which save to me with Date during the development.
SwiftDates is extremly portable; in fact it's a single compact file which add several methods and properties both NSDate and String objects.
You will like it :-) ... or fork it!

###Create new NSDate objects
You can create a new NSDate objects by passing a String (and optionally a format) or setting each component individually.
```swift
let date_iso8601 = NSDate.date(fromString: "2015-01-05T22:10:55.200Z", format: DateFormat.ISO8601)
let date_rss = NSDate.date(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: DateFormat.RSS)
let date_altrss = NSDate.date(fromString: "09 Sep 2011 15:26:08 +0200", format: DateFormat.AltRSS)
let date_custom = NSDate.date(fromString: "22/01/2015", format: DateFormat.Custom("dd/MM/yyyy"))
```
You can also create a date by specifing indivually each component.
This method accept a reference date to use (just use nil to start with the current NSDate()) and you can pass the components you want to alter (if you don't want to alter the current hour, for example, just pass nil as hour: parameter).
This is an example: suppose current date is 2015/05/01 @ 22:00
By using:
```swift
let date_from_components = NSDate.date(refDate: nil, year: 2014, month: 01, day: nil, hour: nil, minute: nil, second: nil, tz: "UTC")
```
You will have a NSDate which represent 2014/05/01 @ 22:00!
So simple!

Finally you can create a new date from a String using:
```swift
let date = "22/01/2015".toDate(formatString: "dd/MM/yyyy")
let date = "2015-01-05T22:10:55.200Z".toDate(format: DateFormat.ISO8601)
```

###Date Instances Shortcuts
As usual you can get common date instances with the following methods:

```swift
let todayDate = NSDate.today()
let yesterdayDate = NSDate.yesterday()
let tomorrowDate = NSDate.tomorrow()
```

##Get/Alter Individual Date Components
You can get or alter date components too.  However NSDate objects are immutable so while you can have access to each unit component via properties I've made several methods to alter individual components (and get a new date instance).

### Accessing Date Components
So these are readable properties (and some methods):
```swift
.year
.month
.weekOfMonth
.weekday
.weekdayOrdinal
.day
.hour
.minute
.second
.era
.firstDayOfWeek // (first day of the week of passed date)
.lastDayOfWeek // (last day of the week of passed date)
.nearestHour // (nearest hour of the passed date)
.isLeapYear() // true if date's represented year is leap
.monthDays() // return the number of days in date's represented month
```

### Alter Date Components
You can set a new property individually using set method (it accepts year, month, day, hour, minute, second as component name parameter):
```swift
let date = NSDate() // Suppose it's 2015-01-05 @ 22:00
date = date.set("hour",12) // date will be a new objects which represent 2015-01-05 at 12:00
date = date.set("day",1) // 2015-01-01 @ 12:00
```
While you can perfectly chain multiple set, in order to avoid unnecessary objects allocations you can use set method which accept multiple components:
```swift
let date = NSDate()
date = date.set(year: 2000, month: 01, day: 01, hour:0, minute:0, second:0, tz:nil)
```
With a single allocation you have your new object; If you don't want to set a single component just pass nil as value.
Another shortcut involves dictionaries:
```swift
let date = NSDate() // Suppose it's 2015-01-05 @ 22:00
date = date.set(componentsDict: ["hour":12,"minute":55]); // Returns a new NSDate 2015-01-05 @ 12:55
```
### Add/Subtract Components From Date
You can add single components to an existing date very easily:
```swift
let date = NSDate()
let tomorrow = date+1.days
let 2_months_ago = date-2.months
let next_year_today = date+1.years
let another_date = date+54.seconds
if date1+1.week == date2-1.months {
// some good stuff to do...
}
```
(Note: variants +=,-= modify first parameter of the operation)
It's like just doing math!
You can also do it in some more classic ways:
```swift
let date = NSDate() // Suppose it's 2015-01-05 @ 22:00
let tomorrow = date.add(years: nil, months: nil, days: 1, minutes: nil, seconds: nil) // it will be 2015-01-06 @ 22:00
let next2Hours = date.add("minute",20) // it will be 2016-01-05 @ 22:20
let tomorrowNextYear = date.add(["year":1,"day":1]) // it will be 2016-01-06 @ 22:00
```
### Timezone & Dates
NSDate objects don't have time zones; they represent an absolute moment in time.
However, when you ask one for its description (by printing it in an NSLog, e.g.), it has to pick a time zone. The most reasonable "default" choice is GMT. If you're not in GMT yourself, the date will seem to be incorrect, by the amount of your own offset.
You should always use an NSDateFormatter, setting its timezone to yours, before displaying a date.
Use:
```swift
let date = NSDate() // Local NSTimeZone date
let date_as_utc = date.toUTC()
let date_as_local = date_as_utc.toLocal()
let date_as_EST = date_as_utc.toTimezone("EST") //  convert to Eastern Time timezone
```

### Compare Dates
Thanks to Swift you can compare dates using intuitive math operators: <,<=,==,>,>=:
So,  let me show a simple example
```swift
let date1 = NSDate.date(fromString: "2015-01-01T00:00:00.000Z", format: DateFormat.ISO8601)
let date2 = NSDate.date(fromString: "2015-01-11T00:00:00.000Z", format: DateFormat.ISO8601)

if date2 > date1 { ... } // or <=
if date2 == date1 { ... }
if date2 < date1 { ... } // or >=
// and so on...
```
You can also compare two dates using:
```swift
let date1...; let date2...;
let equals : Bool = date1.isEqualToDate(date2, ignoreTime: true) // comparisor is done only at date level, ignoring the time component
```

You can also check if a date time component fall in a time range:
```swift
let isInRange : Bool = date1.isInTimeRange("11:00","15:00") // true if time component of the date falls inside proposed range (11am-03pm)
```

Some other properties/methods are:
```swift
.isToday()	// true if represented date is today
.isTomorrow()
.isYesterday()
.isThisWeek() // true if represented date's week is the current week
.isSameWeekOf(date: NSDate) // true if two dates share the same year's week
.dateAtWeekStart() // return the date where current's date week starts
.beginningOfDay() // return the same date of the sender with time set to 00:00:00
.endOfDay() // return the same date of the sender with time set to 23:59:59
.beginningOfMonth() // return the date which represent the first day of the sender date's month
.endOfMonth() // return the date which represent the last day of the sender date's month
.beginningOfYear() // return the date which represent the first day of the sender date's year
.endOfYear() // return the date which represent the last day of the sender date's year
.isWeekday() // true if current sender date is a week day
.isWeekend() // true if current sender date is a weekend day (sat/sun)
```
### Intervals


### From NSDate to String
SwiftDate has several interesting methods to convert NSDate instances to string representation.
You can get the string from date using a particular format (don't worry, to preserve performances we use a singleton NSDateFormatter):
```swift
let string = date.toString(format: DateFormat.Custom("YYYY-MM-dd")) // something like "2015-01-01"
let string = date.toString(format: DateFormat.ISO8601) // something like "2015-01-01T00:00:00.000Z"
let string = date.toISOString() // the same of the above DateFormat.ISO8601
```
You can also use convenience methods for NSDateFormatterStyle:
```swift
let string = date.toString(dateStyle: .ShortStyle timeStyle:.LongStyle relativeDate:true)
```
Shortcuts are also available:
```swift
.toShortString() // short style, both time and date are printed
.toMediumString() // medium style, both time and date are printed
.toLongString() // full style, both time and date are printed
.toShortDateString() // short style, print only date
.toShortTimeString() // short style, print only time
.toMediumDateString() // medium style, print only date
.toMediumTimeString() // medium style, print only time
.toLongDateString() // long style, print only date
.toLongTimeString() // long style, print only time
```

Finally you can also get a relative representation of the string (ie. "2 hours ago", "1 day ago"...) by using:
```swift
let string = date.toRelativeString(fromDate: nil, abbreviated: false, maxUnits:2)
```
This example tell to SwiftDate to return a relative representation of the date by comparing it to the current date (nil in fromDate means NSDate()) without using an abbreviated form (use "seconds" not "secs", or "years" not "ys") and with a max number of units of 2 (this is used to get the approximation units to print, ie "2 hours, 30 minutes" are 2 units, "2 hours, 30 minutes, 5 seconds" are 3 units).

### Date Formats Syntax
Syntax used for date format (both for parse and print) is the same used by NSDateFormatter.
Below there is a short summary table:
(the following table is copied from this [original article](http://waracle.net/iphone-nsdateformatter-date-formatting-table/))

| Field    | Symbol | No   | Example                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|----------|--------|------|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| era      | G      | 1..3 | AD                                                                                                                       | Era Đ Replaced with the Era string for the current date. One to three letters for the abbreviated form, four letters for the long form, five for the narrow form.                                                                                                                                                                                                                                                                                                       |
|          |        | 4    | Anno Domini                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 5    | A                                                                                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| year     | y      | 1..n | 1996                                                                                                                     | Year. Normally the length specifies the padding, but for two letters it also specifies the maximum length. Example:                                                                                                                                                                                                                                                                                                                                                     |
|          | Y      | 1..n | 1997                                                                                                                     | Year (in ŇWeek of YearÓ based calendars). This year designation is used in ISO year-week calendar as defined by ISO 8601, but can be used in non-Gregorian based calendar systems where week date processing is desired. May not always be the same value as calendar year.                                                                                                                                                                                             |
|          | u      | 1..n | 4601                                                                                                                     | Extended year. This is a single number designating the year of this calendar system, encompassing all supra-year fields. For example, for the Julian calendar system, year numbers are positive, with an era of BCE or CE. An extended year value for the Julian calendar system assigns positive values to CE years and negative values to BCE years, with 1 BCE being year 0.                                                                                         |
| quarter  | Q      | 1..2 | 02                                                                                                                       | Quarter Đ Use one or two for the numerical quarter, three for the abbreviation, or four for the full name.                                                                                                                                                                                                                                                                                                                                                              |
|          |        | 3    | Q2                                                                                                                       |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 4    | 2nd quarter                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | q      | 1..2 | 02                                                                                                                       | Stand-Alone Quarter Đ Use one or two for the numerical quarter, three for the abbreviation, or four for the full name.                                                                                                                                                                                                                                                                                                                                                  |
|          |        | 3    | Q2                                                                                                                       |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 4    | 2nd quarter                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| month    | M      | 1..2 | 09                                                                                                                       | Month Đ Use one or two for the numerical month, three for the abbreviation, or four for the full name, or five for the narrow name.                                                                                                                                                                                                                                                                                                                                     |
|          |        | 3    | Sept                                                                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 4    | September                                                                                                                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 5    | S                                                                                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | L      | 1..2 | 09                                                                                                                       |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 3    | Sept                                                                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 4    | September                                                                                                                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 5    | S                                                                                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | l      | 1    | *                                                                                                                        | Special symbol for Chinese leap month, used in combination with M. Only used with the Chinese calendar.                                                                                                                                                                                                                                                                                                                                                                 |
| week     | w      | 1..2 | 27                                                                                                                       | Week of Year.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|          | W      | 1    | 3                                                                                                                        | Week of Month                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| day      | d      | 1..2 | 1                                                                                                                        | Date Đ Day of the month                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|          | D      | 1..3 | 345                                                                                                                      | Day of year                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | F      | 1    | 2                                                                                                                        | Day of Week in Month. The example is for the 2nd Wed in July                                                                                                                                                                                                                                                                                                                                                                                                            |
|          | g      | 1..n | 2451334                                                                                                                  | Modified Julian day. This is different from the conventional Julian day number in two regards. First, it demarcates days at local zone midnight, rather than noon GMT. Second, it is a local number; that is, it depends on the local time zone. It can be thought of as a single number that encompasses all the date-related fields.                                                                                                                                  |
| week day | E      | 1..3 | Tues                                                                                                                     | Day of week Đ Use one through three letters for the short day, or four for the full name, or five for the narrow name.                                                                                                                                                                                                                                                                                                                                                  |
|          |        | 4    | Tuesday                                                                                                                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 5    | T                                                                                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | e      | 1..2 | 2                                                                                                                        | Local day of week. Same as E except adds a numeric value that will depend on the local starting day of the week, using one or two letters. For this example, Monday is the first day of the week.                                                                                                                                                                                                                                                                       |
|          |        | 3    | Tues                                                                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 4    | Tuesday                                                                                                                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 5    | T                                                                                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | c      | 1    | 2                                                                                                                        | Stand-Alone local day of week Đ Use one letter for the local numeric value (same as ÔeŐ), three for the short day, or four for the full name, or five for the narrow name.                                                                                                                                                                                                                                                                                              |
|          |        | 3    | Tues                                                                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 4    | Tuesday                                                                                                                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          |        | 5    | T                                                                                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| period   | a      | 1    | AM                                                                                                                       | AM or PM                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| hour     | h      | 1..2 | 11                                                                                                                       | Hour [1-12]                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | H      | 1..2 | 13                                                                                                                       | Hour [0-23]                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | K      | 1..2 | 0                                                                                                                        | Hour [0-11]                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | k      | 1..2 | 24                                                                                                                       | Hour [1-24]                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|          | j      | 1..2 | n/a                                                                                                                      | This is a special-purpose symbol. It must not occur in pattern or skeleton data. Instead, it is reserved for use in APIs doing flexible date pattern generation. In such a context, it requests the preferred format (12 versus 24 hour) for the language in question, as determined by whether h, H, K, or k is used in the standard short time format for the locale, and should be replaced by h, H, K, or k before beginning a match against availableFormats data. |
| minute   | m      | 1..2 | 59                                                                                                                       | Minute. Use one or two for zero padding                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| second   | s      | 1..2 | 12                                                                                                                       | Second. Use one or two for zero padding.                                                                                                                                                                                                                                                                                                                                                                                                                                |
|          | S      | 1..n | 3456                                                                                                                     | Fractional Second Đ truncates (like other time fields) to the count of letters. (example shows display using pattern SSSS for seconds value 12.34567)                                                                                                                                                                                                                                                                                                                   |
|          | A      | 1..n | 69540000                                                                                                                 | Milliseconds in day. This field behaves exactly like a composite of all time-related fields, not including the zone fields. As such, it also reflects discontinuities of those fields on DST transition days. On a day of DST onset, it will jump forward. On a day of DST cessation, it will jump backward. This reflects the fact that is must be combined with the offset field to obtain a unique local time value.                                                 |
| zone     | z      | 1..3 | PDTfallbacks:HPG-8:00GMT-08:00                                                                                           | Time Zone Đ with the specific non-location format. Where that is unavailable, falls back to localized GMT format. Use one to three letters for the short format or four for the full format. In the short format, metazone names are not used unless the commonlyUsed flag is on in the locale.For more information about timezone formats, see Appendix J: Time Zone Display Names.                                                                                    |
|          |        | 4    | Pacific Daylight Timefallbacks:HPG-8:00GMT-08:00                                                                         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | Z      | 1..3 | -0800                                                                                                                    | Time Zone Đ Use one to three letters for RFC 822 format, four letters for the localized GMT format.For more information about timezone formats, see Appendix J: Time Zone Display Names.                                                                                                                                                                                                                                                                                |
|          |        | 4    | HPG+8:00fallbacks:GMT-08:00                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | v      | 1    | PT                                                                                                                       | Time Zone Đ with the generic non-location format. Where that is unavailable, uses special fallback rules given in Appendix J. Use one letter for short format, four for long format.For more information about timezone formats, see Appendix J: Time Zone Display Names.                                                                                                                                                                                               |
|          |        | 4    | Pacific Timefallbacks:Pacific Time (Canada)Pacific Time (Whitehorse)United States (Los Angeles) TimeHPG-8:35 - GMT-08:35 |                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|          | V      | 1    | PSTfallbacks:HPG-8:00GMT-08:00                                                                                           | Time Zone Đ with the same format as z, except that metazone timezone abbreviations are to be displayed if available, regardless of the value of commonlyUsed.For more information about timezone formats, see Appendix J: Time Zone Display Names.                                                                                                                                                                                                                      |
|          |        | 4    | United States (Los Angeles) Timefallbacks:HPG-8:35GMT-08:35                                                              | Time Zone Đ with the generic location format. Where that is unavailable, falls back to the localized GMT format. (Fallback is only necessary with a GMT-style Time Zone ID, like Etc/GMT-830.)This is especially useful when presenting possible timezone choices for user selection, since the naming is more uniform than the v format.For more information about timezone formats, see Appendix J: Time Zone Display Names.                                          |


### Some other libraries:
SwiftDate was also inspired by other works.
Some links:
* [AFDateHelper](https://github.com/melvitax/AFDateHelper)
* [Timepiece](https://github.com/naoty/Timepiece)
* [MSDateFormatter](https://github.com/Namvt/MSDateFormatter)
