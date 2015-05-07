<img style="float: center" src="(https://raw.githubusercontent.com/malcommac/SwiftDate/master/logo.png">

##Easy NSDate Management in Swift

### Author
Daniele Margutti  - [www.danielemargutti.com](http://www.danielemargutti.com)
Questions? This is my twitter account:
[@danielemargutti](http://www.twitter.com/danielemargutti) 

This library is licensed under MIT license and it's compatible with Swift 1.2.

###Features
- [x] Math operations with dates ```(ie. myDate+2.week+1.hour)```
- [x] Easy compare using ```<,>,==,<=,>=``` operators
- [x] Easy individual date component set/get
- [x] Easy creation with common formats or custom formats
- [x] Powerful .toString methods with support for relative dates (ie. "2hours"...)
- [x] Many shortcuts to get intervals and common dates (yesterday,tomorrow...)
- [x] *... check out documentation below!*

###Requirements
* iOS 7.0+ / Mac OS X 10.9+
* Xcode 6.3
* Swift 1.2

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
let date_custom = NSDate.date(fromString: "22/01/2015", format: DateFormat.Custom("DD/MM/YYYY"))
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
let date = "22/01/2015".toDate(format: "DD/MM/YYYY")
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
date = date.set(["hour":12,"minute":55]); // Returns a new NSDate 2015-01-05 @ 12:55
```
### Add/Subtract Components From Date
You can add single components to an existing date very easily:
```swift
let date = NSDate()
let tomorrow = date+1.day
let 2_months_ago = date-2.months
let next_year_today = date+1.year
let another_date = date+54.seconds
if date1+1.week == date2-1.month {
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
### Timezone Conversion
NSDate objects does not mantain any information about the timezone.
You can however add/subtract time interval based upon a specific timezone.
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
let string = date.toString(format: "YYYY-MM-DD") // something like "2015-01-01"
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