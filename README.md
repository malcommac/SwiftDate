# SwiftDate 2
### Probability the best way to play with Dates in iOS, Mac, WatchOS and yeah, tvOS!


Welcome to SwiftDate 2, the next iteration of SwiftDate's Dates Managament Library made 100% with Swift 2 in mind. The goal of this project is to bring NSDate to the next level with the power of the Apple's new programming language.
SwiftDate has all you need to manage dates components, timezones and locales easily in Swift: you will not belive what we have made for you.
So let's get a look at it!

###Features

- [x] Math operations with dates ```(ie. myDate+2.week+1.hour)```
- [x] Easy compare using ```<,>,==,<=,>=``` operators
- [x] Easy individual date component set/get
- [x] Easy creation with common formats or custom formats
- [x] Full timezone support via DateInRegion to represent and manage dates in different world zones easily
- [x] Powerful .toString methods even with support for relative dates (ie. "2hours"...)
- [x] Many shortcuts to get intervals and common dates (yesterday,tomorrow...)
- [x] *... check out documentation below!*

# Documentation

- [Something important about NSDate](#something-important-about-nsdate)
- [Inside SwiftDate](#inside-swiftdate)
	- [DateInRegion and Region](#dateinregion-and-region)
	- [How to create a Region](#how-to-create-a-region)
	- [TimeZoneNames & CalendarType](#timezonenames-&-calendartype)
- [Manage Dates](#manage-dates)
	- [Dates from strings](#dates-from-strings)
	- [Dates from components](#dates-from-components)
	- [Create Dates at start/end of a time unit](#create-dates-at-start/end-of-a-time-unit)
	- [Get Components from Date](#get-components-from-date)
	- [Math operations with dates, compare dates](#math-operations-with-dates-and-compare-dates)
	- [Compare dates](#compare-dates)
	- [Timezone conversion using DateInRegion chaining](#timezone-conversion-using-dateinregion-chaining)
	- [Convert dates to strings](#convert-dates-to-strings)
	- [Relative date formatting](#relative-date-formatting)
 

## Something you must know about NSDate

As you know NSDate is the central class of the date/time handling in Foundation framework. In fact NSDate is nothing more than a wrapper around the number of seconds since [Jan 1, 2001 at 00:00 UTC](http://en.wikipedia.org/wiki/Coordinated_Universal_Time) (or GMT if you prefer).
For values representing number of seconds, Foundation uses NSTimeInterval which is a 64-bit floating point value. 

According to Apple's documentation is enough impressive to yield [sub-millisecond precision over a range of 10'000 years](http://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_DataTypes/Reference/reference.html#//apple_ref/doc/uid/20000018-SW69); pretty good uh?

So an NSDate object **always represent absolute point in time, and always in UTC format**.
Moreover due to this type of representation **you cannot create a date without including a specific time** (so you cannot create something like Dec 25, 2015 but you need to make something like Dec 25, 2015 at 00:00:00 UTC; this is important when you need to compare dates).

Another important lesson is this: **NSDate has no concept of time zones**. For examle when in London is midnight in New York it is only 6pm of the day before: **both of these dates represent the same point in time and are absolute equals as far for NSDate** (the number of seconds since Jan 1,2001 00:00 remember?).
This important concept is the root of several problems for programmers who are approaching date management in Cocoa.

This one of the problems which we have tried to solve with this library: a painless management of timezones and a power solution to manage date components and operations.

The following chapter will let you know two base classes you can use along with NSDate to better handle timezones and other useful properties related to time/date management.

## SwiftDate: how it works

SwiftDate is mainly composed by:

* a **DateInRegion class** : this class represent an UTC date (NSDate instance) in a particular world region. You can use it as replacement of plain NSDate.
* a **Region structure** allows you to create a region for DateInRegion: it just contains three components:  ```timezone ```, ```locale ``` and  ```calendar ```.
* a **NSDate extensions** even if you plan to work with plain NSDate we have created a set of useful tools which allows you to get components and perform operation with dates easily with Swift.

There are also a set of extension of related types as  ```NSDateComponents ``` or  ```NSTimeInterval ``` but you don't need to know more about them.

Don't be worried by all of these nerdy stuff, **the only need you know if while NSDate still represent an UTC absolute time, DateInRegion represent a date in a certain zone of our planet**.

### Region and DateInRegion

As we said DateInRegion represent an NSDate in a particular timezone with a calendar and an associated locale.
You should create DateInRegion everytime you want format or express an absolute NSDate in another timezone.

When you work with DateInRegion you are always **working with date/time components expressed in that region (timezone/calendar/locale)**.
**If you get date components (```days,month,years...```) from a DateInRegion instance you will get these components in the represented timezone.**

Each DateInRegion contains a ```.region``` property of type ```Region``` and an ```UTCDate``` property which represent the absolute time regardless the region itself.
You can create a region by passing these optional parameters:

* ```calendar``` (```CalendarType``` a shortcut which allows to produce easily NSCalendar instances)
* ```timezone``` (```TimeZoneNames.[Country].[Place]``` which allows to produce easily NSTimeZone instances)
* ```locale``` (an ```NSLocale``` instance)

```swift
// All parameters are optional
//  - If cal is missing Gregorian calendar will be used
//  - If tzType is missing NSTimeZone.localTimeZone() will be used
//  - If locale is missing NSLocale.currentLocale() will be used
let romeRegion = Region(cal: CalendarType.Gregorian, tzType: TimeZoneNames.Europe.Rome)
```

You can also have two shortcut which produces UTC Region and Local Region:

```swift
let regionUTC = Region.UTCRegion()
let regionLocal = Region.LocalRegion()
```

Or you can create a DateInRegion with a Region in place:

```swift
let anUTCDate = ... // an NSDate instance
// This will create an UTC date represented in Europe/Rome (GMT+1)
let date = DateInRegion(refDate: anUTCDate, TimeZoneNames.Europe.Rome)
```

### The Default Region

You can also set a **default region** used when you not specify a region in ```DateRegion``` and NSDate extension methods. This is called ```defaultRegion()``` and it will be used only inside your application.
By default ```defaultRegion()``` return a region where:
* ```calendar``` is local system calendar (not autoupdating)
* ```timezone``` is the UTC timezone
* ```locale``` is the current locale

```swift
Region.setDefaultRegion(myRegion) // to set a new default region
let defRegion = Region.defaultRegion() // to get it
```

### TimeZoneNames & CalendarType
SwiftDate uses two custom structures to represent easily time zones and calendar types. While you can still pass instances of these objects (NSCalendar/NSTimeZone) when you need to create regions our suggestion is to used these shortcuts which supports Swift's built in autocompletion:

```swift
let calPersian = CalendarType.Persian
let calLocaleAU = CalendarType.Locale(true)
// you can get the instance of the object easily using .toCalendar() method:
let calObj = calPersian.toCalendar() // will get a Persian NSCalendar instance
```

```TimeZoneNames``` is a nested structure where each type is an ```TimeZoneCountry```. When you need to pass a TimeZoneCountry you need to provide the path to ```TimeZoneNames.[country].[place]```:

```swift
let romeTZ = TimeZoneNames.Europe.Rome
let thaitiTZ = TimeZoneNames.Pacific.Tahiti
// You can get the relative NSTimeZone instance using .toTimeZone() method
let romeTZObj = romeTZ.toTimeZone()
```

## Manage Dates

#### Create Dates From String
You can create NSDate objects from string using a custom formatter or one of the one provided by SwiftDate:

```swift
let date = "2015-01-05T22:10:55.200Z".toDate(DateFormat.ISO8601)
let date = "Fri, 09 Sep 2011 15:26:08 +0200".toDate(DateFormat.RSS)
let date = "09 Sep 2011 15:26:08 +0200".toDate(DateFormat.AltRSS)
let date = "22/01/2015".toDate(DateFormat.Custom("dd/MM/yyyy"))
```

#### Create Dates from Components
Sometimes you need to create an NSDate from individual time components. 
You have several ways to accomplish it:

* By composing a set time components ```nanoseconds, seconds, minutes, hours, days, weeks, months, year```)

```swift
// This will produce an NSDate: 'Dec 25, 2015 at 20:10:00 UTC' (Gregorian Calendar)
let date = (2015.years | 12.months | 25.days | 20.hours | 10.minutes).inUTCRegion
```

* By creating a date with an interval from a specified date using ```fromNow/ago```:

```
let date = 5.days.fromNow // an NSDate 5 days after the current date/time
let date = 4.hours.ago // an NSDate 4 hours before the current date/time
let date = (5.days + 2.hours - 15.minutes).fromNow // an NSDate 5d,2h,15m after the current date/time
let date = (6.days + 2.hours).fromDate(anotherDate) // an NSDate 6 days and 2 hours after a specified date
let date = (6.hours + 2.minutes).fromNow(region: inRome)
```

* By passing a dictionary (```[NSCalendarUnit : AnyObject]```). In this case remeber to specify both calendar and timezone with ```NSCalendarUnit.Calendar``` and ```NSCalendarUnit.TimeZone```.

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
```

The same result can be accomplished using:

```swift
let date = NSDate(params : compDict) // by passing a dict of type [NSCalendarUnit:AnyObject]
let date = NSDate(components: compos) // by passing an NSDateComponents instance
```

* Via init parameters: all parameters are optional unless refDate (the reference date used to fill undefined/not passed components) and the region:

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

#### 2.3 Create a DateInRegion
Now you know all involved structures you are ready to create your first NSDate expressed in a particular world's region... or DateInRegion!

* Create via ```NSDateComponents``` instance:
```swift
// Create our NSDateComponents
let cmp = NSDateComponents()
cmp.calendar = CalendarType.Gregorian.toCalendar() // it's important to specify calendar...
cmp.timeZone = TimeZoneNames.Europe.Rome.toTimeZone() // ... and timezone
cmp.year = 2010
cmp.month = 2
cmp.day = 15
cmp.hour = 00
cmp.minute = 20
// This will produce this date: "2010-02-15 00:20:00 Europe/Rome"
let dateInRome = DateInRegion(components: cmp)
// This will get the NSDate expressed in UTC ("2010-02-14 23:20:00")
let dateInUTC = dateInRome.UTCDate()
```

* Create from ```Strings```
```swift
let inRome = DateInRegion(fromString: "1972-07-16T08:15:30-05:00", format: DateFormat.ISO8601, region: TimeZoneNames.Europe.Rome)
// will parse the UTC -5 HOURS date, represent it internally in UTC (1972-07-16 13:15:30 UTC)
// then convert it in Rome (+1 UTC, 1972-07-16 14:15:30)
print("hour is \(inRome.hour)") // 14
```

* Create via ```[NSCalendarUnit:AnyObject]``` dictionary (as we look
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
let inRome = DateInRegion(components: compDict, locale: NSLocale.currentLocale())

// The same result can be handled using
let inRome = compDict.toRegion() // -> DateInRegion
```

* Create from an UTC NSDate and express it in a Region:

```swift
// Sun, 15 Nov 2015 23:30:00 GMT
let utcDate = NSDate(timeIntervalSince1970: 1447630200)
let regionNY = Region(tzType: TimeZoneNames.America.NewYork // (-5 hours from GMT)
// Will produce a DateInRegion which represent 2015-11-15 18:30:00 America/New York
let inRome = DateInRegion(UTCDate: utcDate, inRegion: regionNY)
// ... So if you print .hour you will get '18' (in NY) and not 23 (in UTC)
print(inRome.hour) // 18
```

As you have seen for NSDate you can also create a DateInRegion from parameters:

```swift
let regionRome = Region(tzType: TimeZoneNames.Europe.Rome) // +1 from GMT
// Will produce 2015-10-20 00:00:00 GMT+1 (2015-10-19 23:00:00 UTC)
// Omitted paramters are taken from anotherDate, in our case hour,minute,secs = 0)
let inRome = DateInRegion(date : anotherDate, year: 2015, month: 10, day: 20)
```

* As for NSDate you can create DateInRegion at the start/end of a unit (```NSCalendarUnit```):

```swift
let regionRome = Region(tzType: TimeZoneNames.Europe.Rome) // +1 hour from UTC
let refDate = ... // 2015-10-20 15:25:00 UTC

// Will produce a local date: 2015-10-20 00:00:00 Europe/Rome (2015-10-19 23:00:00 UTC)
let inRomeStartDay = DateInRegion(startOf: refDate, unit: .Day, region: regionRome)

// Will produce a local date: 2015-10-20 15:00:00 Europe/Rome (2015-10-20 14:00:00 UTC)
let inRomeEndHour = DateInRegion(endOf: refDate, unit: .Hour, region: regionRome)

```

#### Get Components from Date

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

#### Math operations with dates

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

#### Compare dates

Both NSDate and DateInRegion allows you to compare dates; as usual while NSDate
These methods are available:

* All math operations are supported ```>=,<=,<,>, ==``` both for NSDate and DateInRegion!
* ```isToday()``` true if date represent the current date (timezone is set UTC for simple NSDate)
* ```isYesterday()``` true if date represent the yesterday's date (timezone is set UTC for simple NSDate)
* ```isTomorrow()``` true if date represent the next day after today (timezone is set UTC for simple NSDate)
* ```isWeekend()``` true if date represent a weekend day according to specified calendar (the DefaultRegion's calendar one for NSDate, the one specified in Region if you are using DateInRegion)

#### Timezone conversion using DateInRegion chaining
You can convert a DateInRegion easily using chaining.
Let me show it:
```swift
let UTCDate = NSDate() // suppose 2015-05-31 23:30:00 UTC
let finalHour = UTCDate.inRegion(regionNY).inRegion(regionRome).hour // 00 (00:30 of 2015-06-01)
```

#### Convert dates to strings

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


#### Relative date formatting

* ```.toRelativeString(fromDate:abbreviated:maxUnits:)```

Finally you can also get a relative representation of the string (ie. "2 hours ago", "1 day ago"...) by using:

```swift
let string = date.toRelativeString(fromDate: nil, abbreviated: false, maxUnits:2)
```

This example tell to SwiftDate to return a relative representation of the date by comparing it to the current date (nil in fromDate means NSDate()) without using an abbreviated form (use "seconds" not "secs", or "years" not "ys") and with a max number of units of 2 (this is used to get the approximation units to print, ie "2 hours, 30 minutes" are 2 units, "2 hours, 30 minutes, 5 seconds" are 3 units).

You can also translate components by localizing ```SwiftDate.localizable``` file (we accept pull requests for them)

