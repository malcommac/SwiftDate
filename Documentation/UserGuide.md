# Usage

## Create an `NSDate` object
SwiftDate provides a number of helper functions to create `NSDate` objects. The absolute time that is created this way reflects the components in your current time zone and calendar.

```swift
// Create a date for XMas Day at midnight
let date1 = NSDate(year: 2015, month: 12, day: 25)

// Create a date at 14:00 on XMas Day
let date2 = NSDate(year: 2015, month: 12, day: 25, hour: 14)

// Create a date for the Monday in week 1 of 2016
// Mind that we assume a European locale setting on the device, so
// Monday is day 1 (in the USA Monday is day 2)
let date3 = NSDate(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1)

// Create date from string
let date1 = "2015-01-05T22:10:55.200Z".toDate(DateFormat.ISO8601)
let date2 = "Fri, 09 Sep 2011 15:26:08 +0200".toDate(DateFormat.RSS)
let date3 = "09 Sep 2011 15:26:08 +0200".toDate(DateFormat.AltRSS)
let date4 = "22/01/2015".toDate(DateFormat.Custom("dd/MM/yyyy"))
```

Or if you want to state the time in a different region, then just add the `DateRegion` object. Mind that the region info is NOT incapsulated in `NSDate` objects. I.e. you get an absolute time that differs from the local time. That is, of course, when the specified date region is NOT the default region.

```
let newYork = DateRegion(timeZoneID: "EST")

// Create a date for XMas Day at midnight in New York
let date1 = NSDate(year: 2015, month: 12, day: 25, region: newYork)
let date2 = NSDate(year: 2015, month: 12, day: 25, timeZoneID: "EST")
```


## Create a `DateInRegion` object
Creation of `DateInRegion` objects is equivalent to that of `NSDate` objects:

```swift
// Create a local date for XMas Day at midnight
let date1 = `DateInRegion`(year: 2015, month: 12, day: 25)

// Create a local date at 14:00 on XMas Day
let date2 = `DateInRegion`(year: 2015, month: 12, day: 25, hour: 14)

// Create a date for the Monday in week 1 of 2016 in Rome
let rome = DateRegion(timeZoneID: "CET", localeID: "it_IT")
let date3 = DateInRegion(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1, region: rome)
let date4 = DateInRegion(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1, timeZone: TimeZoneNames.Europe.Rome, localeID: "it_IT")
let date5 = DateInRegion(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1, timeZoneID: "CET", localeID: "it_IT")

// Create date from an `NSDate`
let date6 = nsdateObject.inRegion(rome)
```
So far `NSDate` and `DateInRegion` look pretty much equivalent. It becomes more interesting when we start to calculate with them. More on that later.


## Create a DateRegion
A date region can be created with the initialiser `DateRegion()`. By default it contains the data for the default device calendar, time zone and locale.

```
// Create a local region
let thisRegion = DateRegion()

// Create a local region with a Hebrew calendar
let thisRegion = DateRegion(calendarID: "hebrew")

// Create a region for Rome using Gregorian calendar and NSLocale.currentLocale (all init params are optional)
let romeRegion = DateRegion(calType: CalendarType.Gregorian, tzType: TimeZoneNames.Europe.Rome)

// Create a region for China using Buddhist calendar
let chinaRegion = DateRegion(calType: CalendarType.Buddhist, tzType: TimeZones.Asia.Shanghai, localeID: "zh_Hans_CN")
```

### Calendar & time zone identification helpers
SwiftDate represent Calendars and TimeZones with custom structures that reflect classic NSTimeZone and NSCalendar identifiers. Using `CalendarType` and `TimeZones` you can easily create objects without remembering identifiers. You can get instances of NSCalendar from CalendarType by calling the  `toCalendar()` method. In the same way, using `toTimeZone()` you can get an NSTimeZone instance from a `TimeZones` structure.

In addition, you can use the plain identifier string if you want.

```
// Create a region with a Gregorian calendar, all three lines will render the same calendar
let gregorian1 = DateRegion(calendarType: CalendarType.Gregorian)
let gregorian2 = DateRegion(calendarID: NSCalendarIdentifierGregorian)
let gregorian3 = DateRegion(calendar: NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian))

// Create a region with an Islamic Civil calendar, all three lines will render the same calendar
let islamic1 = DateRegion(calendarType: CalendarType.IslamicCivil)
let islamic2 = DateRegion(calendarID: NSCalendarIdentifierIslamicCivil)
let islamic3 = DateRegion(calendar: NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamicCivil))

// Create a region with the time zone for Eastern Standard Time (New York time)
let newYork1 = DateRegion(timeZoneRegion: TimeZoneNames.America.New_York)
let newYork2 = DateRegion(timeZoneID: "EST")
let newYork3 = DateRegion(timeZoneID: "America/New_York")

// Create a region with the time zone for UTC (Universal Standard time)
let utc1 = DateRegion(timeZoneRegion: TimeZoneNames.UTC)
let utc2 = DateRegion(timeZoneID: "UTC")
let utc3 = DateRegion(timeZoneID: "etc/UTC")
```

Please note: time zone names are the official names from IANA. They can be found [here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

### Chaining Time Units
Apart from using components in the regular initialisers, you can compose a time by chaining its components `nanoseconds, seconds, minutes, hours, days, weeks, months, year`

```swift
// Create an `NSDate` object for 20:10 on XMas Day for the local calendar and time zone
let date = (2015.years | 12.months | 25.days | 20.hours | 10.minutes)

// Convert this to a `DateInRegion` object for New York (will be 8h earlier in New York)
let dateinNewYork = date.inRegion(newYork)

// ...or Dubai (will be 2h later in Dubai)
let dateinDubai = date.inRegion(dubai)
```

### From a time interval from a specified date (fromNow/ago)
By creating a date with an interval from a specified date using `fromNow/ago`:

```swift
let date = 5.days.fromNow // an `NSDate` 5 days after the current date/time
let date = 4.hours.ago // an `NSDate` 4 hours before the current date/time
let date = (5.days + 2.hours - 15.minutes).fromNow // an `NSDate` 5d,2h,15m after the current date/time
let date = (6.days + 2.hours).fromDate(anotherDate) // an `NSDate` 6 days and 2 hours after a specified date
let date = (6.hours + 2.minutes).fromNow(region: inRome)
```

### By passing time units as init parameters
Via init parameters: all parameters are optional unless refDate (the reference date used to fill undefined/not passed components) and the region:

```swift
// First of all we create the region in which the date is expressed. Suppose we want to represent a datetime in Rome (GMT+1).
let region = DateRegion(calType: CalendarType.Gregorian, tzType: TimeZoneNames.Europe.Rome)

// Suppose anotherDate is: Nov 15, 2014 at 20:30:44
// Now we create the date by setting only year,month,day and hour (all other missing params will be taken from anotherDate).
let date = NSDate(refDate: anotherDate, year: 2015, month: 12, day: 25, hour: 22, region: region)
// ... Produce date is Dec 25 2015 at 22:30:44 in GMT+1
// (will be Dec 25, 2015 at 21:30:44 in UTC)
```

### Create Dates at start/end of a time unit
You can also create an `NSDate` at the start or end of a particular datetime unit expressed with `NSCalendarUnit`.

```swift
// Suppose we have anotherDate = Dec 13 2015 at 14:20:00 UTC.
// To get a `NSDate` at the start of the month (december) we can use:
let sMonth = anotherDate.startOf(.Month) // 2015-12-01 00:00:00 UTC

// The same behaviour can be obtained using endOf() method.
// In this example we get the last moment of the current hour from our date
let sMonth = anotherDate.endOf(.Hour) // 2015-12-01 14:59:59 UTC

// We can also express it in another timezone
// Suppose region = DateRegion(tzType: TimeZoneNames.Europe.Rome)
let sMonthInRome = anotherDate.startOf(.Month, inRegion: region) // 2015-11-30 23:00:00 UTC or 2015-12-01 00:00:00 GMT+1/Rome
```

## Inspect `DateInRegion` or `NSDate` components
All methods and properties which follows are the same for both of the classes but while in `NSDate` returns value in the default region and the DateRegion variant values are returned in the specified region

Suppose you have:

```swift
let inRome = ... // 2015-02-01 00:45:00 Europe/Rome (+1 from GMT)
let date = inRome.absoluteTime() ... // get the absolute time: '2015-01-31 23:45:00 UTC
```

Properties and functions available:

Property/function|Description|NSDate|DateInRegion
---|---|---|---
`era`|Returns the era number of the receiver|x|x
`year`|Returns the year number of the receiver|x|x
`yearForWeekOfYear`|Returns the year number for the weekOfYear of the receiver|x|x
`month`|Returns the month number (1...12) of the receiver|x|x
`monthName`|Returns the month name of the receiver|x|x
`monthDays`|Returns the number of days in the month (28...31) of the receiver|x|x
`weekOfYear`|Returns the week number in the year (1...53) of the receiver|x|x
`weekOfMonth`|Returns the week number in the month (0...5) of the receiver|x|x
`weekday`|Returns the day number in the week (1...7) of the receiver|x|x
`weekdayName`|Returns the weekday name of the receiver|x|x
`weekdayOrdinal`|Returns the ordinal weekday in this month (e.g. third Tuesday this month) (0...5) for the receiver|x|x
`day`|Returns the day number (0...31) in the month of the receiver|x|x
`hour`|Returns the hour (0...24) of the receiver|x|x
`minute`|Returns the minute (0...59) of the receiver|x|x
`seconds`|Returns the seconds (0...59) of the receiver|x|x
`nanosecond`|Returns the nanosecond (0...999999999) of the receiver|x|x
`firstDayOfWeek`|Returns the first day of the week of the receiver|x|x
`lastDayOfWeek`|Returns the last day of the week of the receiver|x|x
`leapMonth`|returns `true` if the receiver is in a leap month|x|x
`leapYear`|returns `true` if the receiver is in a leap year|x|x
`components`|return the NSDateComponents of a date|x|x
`calendar`|Returns the NSCalendar object of the receiver|.|x
`locale`|Returns the NSLocale object of the receiver|.|x
`timeZone`|Returns the NSTimeZone object of the receiver|.|x
`components(inRegion:)`|returns the components for a specific region|x|.
`thisWeekend()`|to return the start and end of the current weekend or `nil` if the receiver is not in a weekend|x|x
`nextWeekend()`|to return the start and end of the next weekend|x|x
`previousWeekend()`|to return the start and end of the previous weekend|x|x
`firstDayOfWeek()`|returns midnight on the first day of the week|x|x
`lastDayOfWeek()`|returns the end of the last day of the week|x|x
`inRegion()`|returns a `DateInRegion` object for the receiver|x|.
`absoluteTime`|Returns an `NSDate` object with the absolute time of the receiver|.|x

Class functions available:

Function|Description|NSDate|DateInRegion|DateRegion
---|---|---|---|---
`today()`|Returns today at midnight|x|.|x
`tomorrow()`|Returns tomorrow at midnight|x|.|x
`yesterday()`|Returns yesterday at midnight|x|.|x

All `NSDate` functions are evaluated against the current region by default. If you want a value for another region you can add the `inRegion:` parameter. E.g. `nsdate.nextWeekend(inRegion: china)` will return the start and end of the next weekend in China. Mind that the return values are `NSDate` objects. If you want `DateInRegion` return values then you can use `nsdate.inRegion(china).nextWeekend()`. This will create a `DateInRegion` object from the `nsdate` object and then evaluate the `nextWeekend` function.

The properties `monthName` and `weekdayName` return `String` objects against the current locale for `NSDate` and for the locale registered with the `DateRegion` for `DateInRegion`.  

## Calculations with `DateInRegion`/`NSDate`
Add (`+`) and subtract (`-`) operators are supported both for `NSDate` and `DateInRegion`.

```swift
// With NSDate
let refDate = NSDate(timeIntervalSince1970: 1447630200) // Sun, 15 Nov 2015 23:30:00 UTC
let newDate = refDate + 2.hours + 1.days // Mon, 17 Nov 2015 01:30:00 UTC

// With DateInRegion
let format = DateFormat.Custom("YYYY-mm-dd")
let regionRome = DateRegion(tzType: TimeZoneNames.Europe.Rome)
let initialDateInRegion = DateInRegion(fromString:"2012-01-01", format: format, region: regionRome) // 2012-01-01 00:00:00 CET
let newDateInRegion = initialDateInRegion + 1.days + 2.hours // 2012-01-02 02:00:00 CET
```

You can also use add() methods set to add components to your date. Both of them are available for plain `NSDate` and `DateInRegion`:
- `add(years:months:weeks:days:hours:minutes:seconds:nanoseconds:)` where all parameters are optional
- `add(components:)` you can pass an `NSDateComponents` to add

```swift
// Reference date is: Thu, 19 Nov 2015 19:00:00 UTC (1447959600 from 1970)
let refDate = NSDate(timeIntervalSince1970: 1447959600)

// Remember: all parameters are optional; in this example we have ignored minutes and seconds
let newDate = refDate.add(years: 1, months: 2, days: 1, hours: 2)
// newdate is 2017-01-21 14:00:00 +0000

// This is equivalent to
let newDate2 = refDate + 1.years + 2.months + 1.days + 2.hours
```

Point of attention with date calculations is that `DateInRegion` objects have their own calendar encapsulated. Different calendars produce different results. E.g. adding an Islamic year has a different outcome than adding a Gregorian year because the Islamic calendar is lunar based as opposed to solar for the Gregorian calendar.

```swift
let islamicDate = DateInRegion(region: dubai) + 1.years // 9-Dec-2016 (in the gregorian calendar)
let gregorianDate = DateInRegion(region: chicago) + 1.years // 21-Dec-2016
```

## Comparisons
Date objects can be compared with the regular math comparison operators:
- `==` right hand side represents the same moment in time as the left hand side.
- `!=` right hand side is not at the same moment as the left hand side.
- `<` right hand side is earlier than the left hand side.
- `>` right hand side is later than the left hand side.
- `<=` right hand side is earlier than- or at the same moment as the left hand side.
- `>=` right hand side is later than- or at the same moment as the left hand side.

Other comparisons are in the functions:

Property/function|Description|NSDate|DateInRegion
---|---|---|---
`isInToday()`|returns `true` if the receiver is in today|x|x
`isInYesterday()`|returns `true` if the receiver is in yesterday|x|x
`isInTomorrow()`|returns `true` if the receiver is in tomorrow|x|x
`isInWeekend()`|returns `true` if the receiver is in a weekend|x|x
`isInSameDayAsDate()`|returns `true` if the receiver is in the days of the specified date|x|x
`isIn(unit:ofDate:)`|returns `true` if the receiver is within the unit of the specified date|x|x
`isBefore(unit:ofDate:)`|returns `true` if the receiver is before the unit of the specified date|x|x
`isAfter(unit:ofDate:)`|returns `true` if the receiver is before the unit of the specified date|x|x
`isLeapYear()`|returns `true` if the receiver is in a leap year|x|x
`isLeapMonth()`|returns `true` if the receiver is in a leap month|x|x


## Conversions

### Time zone conversions

`NSDate` is a moment in time. Conversion takes place in its representation. But conversion is pretty universal for both `NSDate` and `DateInRegion`:

```swift
let now1 = NSDate()
let now2 = DateInRegion()

let now1Here = now1.toString() // E.g. 21-Dec-15 12:00 CET
let now1InAnchorage = now1.inRegion(timeZoneID: TimeZones.America.Anchorage).toString() // E.g. 21-Dec-15 02:00 AKST
let now1InSydney = now1.inRegion(timeZoneID: "Pacific/Sydney").toString() // E.g. 21-Dec-15 22:00 AEDT
let now1InChina = now1.inRegion(timeZoneID: ""CST").toString() // E.g. 21-Dec-15 22:00 CST

let now2Here = now1.toString() // E.g. 21-Dec-15 12:00 CET
let now2InAnchorage = now1.inRegion(timeZoneID: TimeZones.America.Anchorage).toString() // E.g. 21-Dec-15 02:00 AKST
let now1InSydney = now1.inRegion(timeZoneID: "Pacific/Sydney").toString() // E.g. 21-Dec-15 22:00 AEDT
let now1InChina = now1.inRegion(timeZoneID: ""CST").toString() // E.g. 21-Dec-15 22:00 CST
```

### Calendar conversions

```swift
let now = NSDate()

let nowHere = now.toString() // E.g. 21-Dec-15 12:00 CET
let nowInHebrew = now.inRegion(calendarID: .Hebrew).toString() // "9 Tevet 5776, 12:00:00 PM"
let nowInBuddhist = now.inRegion(calendarID: .Buddhist).toString() // "Mo11 11, 2015, 12:00:00 PM"
```

### Locale conversions

```swift
let now = NSDate()

let nowHere = now.toString() // E.g. 21-Dec-15 12:00 CET
let nowInArabic = now.inRegion(localeID: "ar_AE").toString() // "21‏/12‏/2015، 12:00:00 م"
let nowInRussian = now.inRegion(localeID: "ru_RU").toString() // "21 дек. 2015 г., 12:00:00"
```

### Putting it all together

```
let date = NSDate(year: 2015, month: 12, day: 25, hour: 12)

let india = DateRegion(calendarID: NSCalendarIdentifierIndian, timeZoneID: "IST", localeID: "en_IN")
let dubai = DateRegion(calendarID: NSCalendarIdentifierIslamic, timeZoneID: "GST", localeID: "ar_AE")
let newZealand = DateRegion(calendarID: NSCalendarIdentifierGregorian, localeID: "en_NZ", timeZoneID: "Pacific/Auckland")
let israel = DateRegion(calendarID: NSCalendarIdentifierHebrew, timeZoneID: "Asia/Jerusalem", localeID: "he_IL")
let china = DateRegion(calendarID: NSCalendarIdentifierChinese, timeZoneID: "CST", localeID: "zn_Hans_CH")
let magadan = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "Asia/Magadan", localeID: "ru_RU")
let thailand = DateRegion(calendarID: NSCalendarIdentifierBuddhist, timeZoneID: "Asia/Bangkok", localeID: "th_TH")
let japan = DateRegion(calendarID: NSCalendarIdentifierBuddhist, timeZoneID: "Asia/Tokyo", localeID: "ja_JP")
let unalaska = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "AKST", localeID: "en_US")
let utc = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "UTC", localeID: "en_US_POSIX")

let unalaskaDate = date.inRegion(unalaska)
let newYorkDate = date.inRegion(newYork)
let indiaDate = date.inRegion(india)
let dubaiDate = date.inRegion(dubai)
let israelDate = date.inRegion(israel)
let chinaDate = now.inRegion(china)
let newZealandDate = now.inRegion(newZealand)
let magadanDate = date.inRegion(magadan)
let japanDate = date.inRegion(japan)
let thailandDate = date.inRegion(thailand)
let utcDate = date.inRegion(utc)

unalaskaDate.toString() // "Dec 25, 2015, 2:00:00 AM"
newYorkDate.toString() // "Dec 25, 2015, 6:00:00 AM"
indiaDate.toString() // "04-Pausa-1937 Saka, 4:30:00 PM"
dubaiDate.toString() // "14 ربيع١، 1437 هـ، 3:00:00 م"
israelDate.toString() // "י״ג בטבת תשע״ו, 13:00:00"
chinaDate.toString() // "Mo11 15, 2015, 5:00:00 AM"
magadanDate.toString() // "25 дек. 2015 г., 21:00:00"
japanDate.toString() // "BE2558/12/25 20:00:00"
thailandDate.toString() // "25 ธ.ค. 2558 18:00:00"
newZealandDate.toString() "26/12/2015, 12:00:00 AM"
utcDate.toString() // "Dec 25, 2015, 11:00:00 AM"

```


## From `DateInRegion`/`NSDate` to strings
Convert a date into a string is pretty easy too. Both `NSDate` and `DateInRegion` supports the following methods. SwiftDate use a per-thread cached `NSDateFormatter` in order to avoid multiple allocations at each call (NSDateFormatter instances are very expensive to create! However you don't need to be worried about that, is transparent to you!)

Formatting methods are:
- `.toString(format:)` Print date with specified format (see below to get a table of symbols you can use to represent each component)
- `.toISO8601String()` Print an ISO8601 formatted string
- `.toString(style:,dateStyle:,timeStyle:)` Print a string with a common style for date/time (see `NSDateFormatterStyle`) or specify a style for date and another for time.
- `.toShortString(date:time)` Print a short representation of the both date and time (or only one of them according to parameters)
- `.toMediumString(date:time:)` Print a medium representation of the both date and time (or only one of them according to parameters)
- `.toLongString(date:time:)` Print a long representation of the both date and time (or only one of them according to parameters)

Some examples:

```swift
// Create a `NSDate` (UTC) from string and transform it into `DateInRegion`
let date = "2015-01-05T22:10:55.000Z".toDate(DateFormat.ISO8601)!.inRegion(romeRegion)
// The same behaviour can be also accomplished using `DateInRegion`(fromString:format:region)
let date = `DateInRegion`("2015-01-05T22:10:55.000Z",DateFormat,ISO8601,romeRegion)

// We can print the date (it also works with plain `NSDate` too!)
// Just some examples:
print("\(date.toISO8601String())") // to UTC ISO8601: "2015-01-05T22:10:55.000Z"
print("\(date.toMediumString())") // to E/Rome: "Jan 5, 2015, 11:10:55 PM"
print(date.toString(DateFormat.Custom("YYYY-MM-dd HH 'at' HH:mm"))) // to E/Rome: "2015-01-05 23 at 23:10"
```

### From `DateInRegion`/`NSDate` to relative strings
- `.toRelativeString(fromDate:abbreviated:maxUnits:)`

A relative representation of the date (e.g. "2 hours ago", "1 day ago"...) can be obtained by using:

```swift
let string = date.toRelativeString(abbreviated: false, maxUnits:2)
```

This example tell to SwiftDate to return a relative representation of the date by comparing it to the current date (nil in fromDate means `NSDate`()) without using an abbreviated form (use "seconds" not "secs", or "years" not "ys") and with a max number of units of 2 (this is used to get the approximation units to print, ie "2 hours, 30 minutes" are 2 units, "2 hours, 30 minutes, 5 seconds" are 3 units).

You can also translate components by localizing `SwiftDate.localizable` file (we accept pull requests for them)

## Best practices
- As a rule of the thumb you should use `NSDate` when working with the default calendar, time zone and locale of the device.
- When you work with dates in a calendar, time zone and/or locale that differs from the default one, you should use `DateInRegion`. E.g. when you want to work with a second time zone in an app, or when you want to display a date in a different calendar.
- Use `DateRegion` objects to group calendar, time zone and/or locale together. E.g. when you have an app that co-ordinates meetings with another office on the other end of the world.

