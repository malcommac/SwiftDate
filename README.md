![SwiftDate](https://raw.githubusercontent.com/malcommac/SwiftDate/master/swiftdate-logo.png)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CI Status](https://travis-ci.org/malcommac/SwiftDate.svg)](https://travis-ci.org/malcommac/SwiftDate)
[![Version](https://img.shields.io/cocoapods/v/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)
[![License](https://img.shields.io/cocoapods/l/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)
[![Platform](https://img.shields.io/cocoapods/p/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)

Welcome to SwiftDate 2, the second major release of our Date Management Library for Apple's platforms: the goal of this project is to allow developers to manage easily dates operation and timezones conversions in Swift.
SwiftDate allows you:

- [x] Perform **math operations with dates**: ```aDate + 2.weeks + 1.hours``` or ```(1.years - 2.hours + 16.minutes).fromNow()```
- [x] **Full timezone support**. Create ```DateInRegion``` objects and perform operations, get componets in specified timezone with your fav locale settings!
- [x] **Compare dates** with math operators ```<,>,==,<=,>=```. For example you can do ```aDate1 >= aDate2``` or ```aDate1.inTimeRange("15:20","20:20")```
- [x] **Easy get time components in NSDate (UTC) or custom region**. For example: ```aDateInRegion.day``` or ```hour, minutes etc.```
- [x] Easy/optimized way **to get and transform a date from and to strings** (with **relative date supports*** like '2 hours, 5 minutes' etc.)
- [x] Many shortcuts to get intervals and common dates (```isYesterday,isTomorrow...```)
- [x] Compatible with Swift 2.0+ and iOS/Mac/WatchOS/tvOS platforms
- [x] *... many many other shiny things!*

## Upgrading from SwiftDate 1.2 or earlier
SwiftDate 2.0 is completely rewritten version of SwiftDate. We added support for timezones and fixed/changed many methods and properties. Due to these changes old SwiftDate 1.2 code may not work properly. We don't provide any updgrading doc because everything is pretty simple; lots of methods has the same names and DateInRegion is a new structure.
If you have problems or question create an issue; we will be happy to answer :)

## CocoaPods and Carthage
SwiftDate 2 package is compatible both with CocoaPods and Carthage.

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SwiftDate.
Simply add these lines to your pod file:

```
platform :ios, '8.0'
pod "SwiftDate", "~> 2.0"
```

## Author
This library was created by [Daniele Margutti](https://github.com/malcommac) with contribution of [Jeroen Houtzager](https://github.com/Hout). Any help is welcome; feel free to post your issue or pull request, in the spirit of open source software.

## Old Versions

SwiftDate 1.2 branch last revision is available [here](https://github.com/malcommac/SwiftDate/releases/tag/1.2). However we don't plan to support this version anymore.

## What's NSDate (really)

As you know NSDate is the central class of the date/time handling in Foundation framework. In fact NSDate is nothing more than a wrapper around the number of seconds since [Jan 1, 2001 at 00:00 UTC](http://en.wikipedia.org/wiki/Coordinated_Universal_Time) (or GMT).

NSDate objects **always represent absolute point in time, and always in UTC format**.
Moreover due to this type of representation **you cannot create a date without including a specific time** (so you cannot create something like ```Dec 25, 2015``` but you need to make something like ```Dec 25, 2015 at 00:00:00 UTC```; this is important when you need to compare dates).

Due to these constraints **NSDate HAS NO CONCEPT OF TIME ZONES**. For example when in London is midnight in New York it is only 6pm of the day before: **both of these dates represent the same point in time and are absolute equals as far for NSDate** (the number of seconds since Jan 1,2001 00:00 remember?).

This important concept is the root of several problems for programmers who are approaching date management in Cocoa.

## It's time for SwiftDate

SwiftDate introduces the concept of ```DateInRegion:``` this class encapsulate an ```UTC NSDate``` and ```Region``` (a region is a structure which hold ```TimeZone, Calendar and Locale```).

In SwiftDate you can get and work with components both for DateInRegion and NSDate.
When you work with NSDate you are working with an UTC date (unless called methods takes a region as argument); **when you work with DateInRegion class all methods and properties are related to the specified world region and settings**.

### Create a Region

A Region is a structure which allows you to encapsulate informations about the timezone, calendar and locale in which a DateInRegion is represented. You can create and share a Region between DateInRegion without problems.
If you plan to use a particular region along your app you can set it as ```defaultRegion()``` with ```Region.setDefaultRegion(...)``` method (default region is also used as default parameter in several NSDate() shortcuts when no other value is passed).

```
// Create a region for Rome (GMT+1) using Gregorian calendar and NSLocale.currentLocale (all init params are optional)
let romeRegion = Region(calType: CalendarType.Gregorian, tzType: TimeZoneNames.Europe.Rome)
```
SwiftDate represent Calendars and TimeZones with custom structures (which, however, can interoperate with classic NSTimeZone and NSCalendar).
Using ```CalendarType``` and ```TimeZoneNames.[Country].[Place]``` you can easily create objects without remembering identifiers.
You can get instances of NSCalendar from CalendarType by calling ```toCalendar()``` method. In the same way, using ```toTimeZone()``` you can get an NSTimeZone instance from a ```TimeZoneCountry``` structure.

### Create a DateInRegion

DateInRegion represent an UTC Date (NSDate instance) in a particular world region. Suppose we want to express a date in GMT+1 region:

```swift
let anUTCDate = ... // Suppose '2015-10-11 08:00:00 UTC'
let dateInRome = DateInRegion(refDate: anUTCDate, TimeZoneNames.Europe.Rome)
```

```dateInRome``` represent passed UTC date in GMT+1 timezone. We clearly see this by getting the hour components of the two objects (remember, both ```NSDate``` and ```DateInRegion``` share the same methods and properties):

```swift
let hourInUTC = anUTCDate.hour // we get '8' from this NSDate
let regionLocal = dateInRome.hour // we get '9' (+1 hour in Rome, from DateInRegion object)
```

## Create Dates

### Create DateInRegion/NSDate from string
You can create NSDate objects from string using a custom formatter or one of the one provided by SwiftDate:

```swift
let date = "2015-01-05T22:10:55.200Z".toDate(DateFormat.ISO8601)
let date = "Fri, 09 Sep 2011 15:26:08 +0200".toDate(DateFormat.RSS)
let date = "09 Sep 2011 15:26:08 +0200".toDate(DateFormat.AltRSS)
let date = "22/01/2015".toDate(DateFormat.Custom("dd/MM/yyyy"))
```

You can also create directly a DateInRegion object in the same way:

```swift
// Input date is +2 Hours from GMT (so GMT is 20:10:55)
// Resulting date will be in Rome (+1 GMT) so is '2015-01-05T21:10:55 GMT+1'.
let dateInRome = DateInRegion(fromString: "2015-01-05T22:10:55.200Z", format: DateFormat.ISO8601, region: Region(tzType: TimeZoneNames.Europe.Rome))
// This convert the dateInRome in New York tz:
let dateInNY = dateInRome.inRegion(region: Region(tzType: TimeZoneNames.America.NewYork))
```

### Create DateInRegion/NSDate from components
Sometimes you need to create an NSDate/DateInRegion from individual time components. 
You have several ways to accomplish it:

#### Chaining Time Units

By composing a set time components ```nanoseconds, seconds, minutes, hours, days, weeks, months, year```)

```swift
// This will produce a DateInRegion with this date NSDate: 'Dec 25, 2015 at 20:10:00 UTC' (Gregorian Calendar)
let dateInUTC = (2015.years | 12.months | 25.days | 20.hours | 10.minutes).inUTCRegion
// This convert the date in UTC region into another region, NY:
let dateInNY = dateInUTC.inRegion(region: Region(tzType: TimeZoneNames.America.NewYork))
```

#### From a time interval from a specified date (fromNow/ago)

By creating a date with an interval from a specified date using ```fromNow/ago```:

```swift
let date = 5.days.fromNow // an NSDate 5 days after the current date/time
let date = 4.hours.ago // an NSDate 4 hours before the current date/time
let date = (5.days + 2.hours - 15.minutes).fromNow // an NSDate 5d,2h,15m after the current date/time
let date = (6.days + 2.hours).fromDate(anotherDate) // an NSDate 6 days and 2 hours after a specified date
let date = (6.hours + 2.minutes).fromNow(region: inRome)
```

#### From a dictionary of time units

By passing a dictionary (```[NSCalendarUnit : AnyObject]```). In this case remeber to specify both calendar and timezone with ```NSCalendarUnit.Calendar``` and ```NSCalendarUnit.TimeZone```.

```swift
var compDict : [NSCalendarUnit:AnyObject]
compDict[.Year] = 2015
compDict[.Month] = 12
compDict[.Day] = 25
compDict[.Hour] = 20
compDict[.Minute] = 15
compDict[.Second] = 33
compDict[.Calendar] = CalendarType.Gregorian.toCalendar() // produce an NSCalendar
compDict[.TimeZone] = TimeZoneNames.Europe.Rome.toTimeZone() // produce an NSTimeZone

// Date is parsed as 25 Dec 2015 at 20:15:33 in Rome (GMT+1)
// Resulting UTC date will be 1 hour before (19:15:33)
let date = compDict.toUTCDate()

// You can also create a DateInRegion with these components
let dateInRome = DateInRegion(components: compDict)
```

The same result can be accomplished using:

```swift
let date = NSDate(params : compDict) // by passing a dict of type [NSCalendarUnit:AnyObject]
let date = NSDate(components: compos) // by passing an NSDateComponents instance
```

#### By passing time units as init parameters

Via init parameters: all parameters are optional unless refDate (the reference date used to fill undefined/not passed components) and the region:

```swift
// First of all we create the region in which the date is expressed. Suppose we want to represent a datetime in Rome (GMT+1).
let region = Region(calType: CalendarType.Gregorian, tzType: TimeZoneNames.Europe.Rome)

// Suppose anotherDate is: Nov 15, 2014 at 20:30:44
// Now we create the date by setting only year,month,day and hour (all other missing params will be taken from anotherDate).
let date = NSDate(refDate: anotherDate, year: 2015, month: 12, day: 25, hour: 22, region: region)
// ... Produce date is Dec 25 2015 at 22:30:44 in GMT+1
// (will be Dec 25, 2015 at 21:30:44 in UTC)
```

#### Create Dates at start/end of a time unit
You can also create an NSDate at the start or end of a particular datetime unit expressed with ```NSCalendarUnit```.

```swift
// Suppose we have anotherDate = Dec 13 2015 at 14:20:00 UTC.
// To get a NSDate at the start of the month (december) we can use:
let sMonth = anotherDate.startOf(.Month) // 2015-12-01 00:00:00 UTC

// The same behaviour can be obtained using endOf() method.
// In this example we get the last moment of the current hour from our date
let sMonth = anotherDate.endOf(.Hour) // 2015-12-01 14:59:59 UTC

// We can also express it in another timezone
// Suppose region = Region(tzType: TimeZoneNames.Europe.Rome)
let sMonthInRome = anotherDate.startOf(.Month, inRegion: region) // 2015-11-30 23:00:00 UTC or 2015-12-01 00:00:00 GMT+1/Rome 
```

### Inspect DateInRegion or NSDate components

As we said the only difference between an NSDate and DateInRegion is the second one represent an UTC date (NSDate) in a particular world's zone.

**All methods and properties which follows are the same for both of the classes but while in NSDate returns value in UTC, in DateRegion variant values are returned in represented timezone.**

Suppose you have:

```swift
let inRome = ... // 2015-02-01 00:45:00 Europe/Rome (+1 from GMT)
let inUTC = inRome.UTCDate() ... // get the UTC date: '2015-01-31 23:45:00 UTC
```

You can get these properties:

* ```.era```
* ```.year```
* ```.yearForWeekYear```
* ```.month```
* ```.monthName```
* ```.monthDays```
* ```.week```
* ```.weekOfYear```
* ```.weekOfMonth```
* ```.weekday```
* ```.weekdayOrdinal```
* ```.day```
* ```.hour```
* ```.minute```
* ```.seconds```
* ```.nanosecond```
* ```.firstDayOfWeek```
* ```.lastDayOfWeek```
* ```.leapMonth```
* ```.leapYear```
* ```.UTCDate``` (for DateInRange. Return the absolute UTC representation of the local time)
* ```.LocalDate``` (for DateInRange. Convert the local date to the UTC NSDate representation taking care of the timezone)
* ```.components``` return the NSDateComponents of a date
* ```.components(inRegion:)``` for NSDate: to get components in a specific region


So, for example, if you type ```inRome.day``` you will get 01 (Feb), while ```inUTC.day``` will get 31 (Jan).

### Math operations with DateInRegion/NSDate

Math operators ```+,-``` are supported both for plain NSDate and DateInRegion

```swift
// With NSDate
let refDate = NSDate(timeIntervalSince1970: 1447630200) // Sun, 15 Nov 2015 23:30:00 UTC
let newDate = (refDate + 2.hours + 1.days) // Mon, 17 Nov 2015 01:30:00 UTC

// With DateInRegion
let format = DateFormat.Custom("YYYY-mm-dd")
let regionRome = Region(tzType: TimeZoneNames.Europe.Rome)
let initialDateInRegion = DateInRegion(fromString:"2012-01-01", format: format, region: regionRome) // 2012-01-01 00:00:00 E/Rome

let newDateInRegion = (initialDateInRegion + 1.days + 2.hours) // 2012-01-02 02:00:00 E/Rome
```

You can also use add() methods set to add components to your date. Both of them are available for plain NSDate and DateInRegion:

* ```add(years:months:weekOfYear:days:hours:minutes:seconds:nanoseconds:)``` where all paramters are optional
* ```add(components:)``` you can pass an ```NSDateComponents``` to add
* ```add(params:)``` where you can pass an ```[NSCalendarUnit:AnyObject]``` dictionary

Just an example:

```swift
// Reference date is: Thu, 19 Nov 2015 19:00:00 UTC (1447959600 from 1970)
let refDate = NSDate(timeIntervalSince1970: 1447959600)
// New date must be 2017-01-21 14:00:00 +0000
// Remember: all paramters are optional; in this example we have ignored minutes and seconds for example.
let newDate = refDate.add(years: 1, months: 2, days: 1, hours: 2)
```

Another example with NSDateComponents:

```swift
let refDate = NSDate(timeIntervalSince1970: 1447959600)
let compsToAdd = NSDateComponents()
compsToAdd.day = 2
compsToAdd.hour = 1
compsToAdd.minute = 45
let newDate = refDate.add(compsToAdd)
let valid = (newDate.year == 2015 && newDate.month == 11 && newDate.day == 21 && newDate.hour == 20 && newDate.minute == 45 && newDate.second == 0)
```

### Compare DateInRegion/NSDate

Both NSDate and DateInRegion allows you to compare dates; as usual while NSDate
These methods are available:

* All math operations are supported ```>=,<=,<,>, ==``` both for NSDate and DateInRegion!
* ```isToday()``` true if date represent the current date (timezone is set UTC for simple NSDate)
* ```isYesterday()``` true if date represent the yesterday's date (timezone is set UTC for simple NSDate)
* ```isTomorrow()``` true if date represent the next day after today (timezone is set UTC for simple NSDate)
* ```isWeekend()``` true if date represent a weekend day according to specified calendar (the DefaultRegion's calendar one for NSDate, the one specified in Region if you are using DateInRegion)

## Timezone conversion with DateInRegion chaining
You can convert a DateInRegion easily using chaining.
Let me show it:

```swift
let UTCDate = NSDate() // suppose 2015-05-31 23:30:00 UTC
let finalHour = UTCDate.inRegion(regionNY).inRegion(regionRome).hour // 00 (00:30 of 2015-06-01)
```

### From DateInRegion/NSDate to strings

Convert a date into a string is pretty easy too.
Both NSDate and DateInRegion supports the following methods.
SwiftDate use a per-thread cached ```NSDateFormatter``` in order to avoid multiple allocations at each call (NSDateFormatter instances are very expensive to create! However you don't need to be worried about that, is transparent to you!)

Formatting methods are:
* ```.toString(format:)``` Print date with specified format (see below to get a table of symbols you can use to represent each component)
* ```.toISO8601String()``` Print an ISO8601 formatted string
* ```.toString(style:,dateStyle:,timeStyle:)``` Print a string with a common style for date/time (see ```NSDateFormatterStyle```) or specify a style for date and another for time.
* ```.toShortString(date:time)``` Print a short representation of the both date and time (or only one of them according to parameters)
* ```.toMediumString(date:time:)``` Print a medium representation of the both date and time (or only one of them according to parameters)
* ```.toLongString(date:time:)``` Print a long representation of the both date and time (or only one of them according to parameters)

Some examples:

```swift
// Create a NSDate (UTC) from string and transform it into DateInRegion
let date = "2015-01-05T22:10:55.000Z".toDate(DateFormat.ISO8601)!.inRegion(romeRegion)
// The same behaviour can be also accomplished using DateInRegion(fromString:format:region)
let date = DateInRegion("2015-01-05T22:10:55.000Z",DateFormat,ISO8601,romeRegion)

// We can print the date (it also works with plain NSDate too!)
// Just some examples:
print("\(date.toISO8601String())") // to UTC ISO8601: "2015-01-05T22:10:55.000Z"
print("\(date.toMediumString())") // to E/Rome: "Jan 5, 2015, 11:10:55 PM"
print(date.toString(DateFormat.Custom("YYYY-MM-dd HH 'at' HH:mm"))) // to E/Rome: "2015-01-05 23 at 23:10"
```

#### From DateInRegion/NSDate to relative strings

* ```.toRelativeString(fromDate:abbreviated:maxUnits:)```

Finally you can also get a relative representation of the string (ie. "2 hours ago", "1 day ago"...) by using:

```swift
let string = date.toRelativeString(fromDate: nil, abbreviated: false, maxUnits:2)
```

This example tell to SwiftDate to return a relative representation of the date by comparing it to the current date (nil in fromDate means NSDate()) without using an abbreviated form (use "seconds" not "secs", or "years" not "ys") and with a max number of units of 2 (this is used to get the approximation units to print, ie "2 hours, 30 minutes" are 2 units, "2 hours, 30 minutes, 5 seconds" are 3 units).

You can also translate components by localizing ```SwiftDate.localizable``` file (we accept pull requests for them)

