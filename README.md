# DateInRegion

[![Build Status](https://travis-ci.org/Hout/DateInRegion.svg?branch=master)](https://travis-ci.org/Hout/DateInRegion)
[![Version](https://img.shields.io/cocoapods/v/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)
[![License](https://img.shields.io/cocoapods/l/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)
[![Platform](https://img.shields.io/cocoapods/p/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)

DateInRegion is a wrapper around NSDate that exposes the properties of NSDateComponents, NSCalendar, NSTimeZone, NSLocale and NSDateFormatter. The best way to see it is as a localised (locale) moment (date) in a time zone (timeZone)within a calendrical system (calendar). The intention is to replace your occurrence of NSDate with DateInRegion and get the same functionality plus lots of local date/calendar/time zone/formatter goodies. Thus offering date functions with a flexibility that I was looking for when creating this library:

- Use the object as an NSDate. I.e. as an absolute time. 
- Offers many NSDate & NSDateComponent vars & methods
- Initialise a date with any combination of components
- Default date is `NSDate()`
- Default calendar is `NSCalendar.currentCalendar()`
- Default time zone is `NSTimeZone.defaultTimeZone()`
- Default locale is `NSLocale.currentLocale()`
- Contains a date (NSDate), a calendar (NSCalendar), a locale (NSLocale) and a timeZone (NSTimeZone) property
- Implements the ``Equatable`` & ``Comparable`` protocols betwen dates with operators. E.g. `==, !=, <, >, <=, >=`
- Implements the ``Hashable`` protocol so the date can be used as a key in a Dictionary.
- implements date addition and subtraction operators with date components. E.g. `date + 2.days`
- DateInRegion is immutable, so thread safe. It contains a constructor to easily create new ``DateInRegion`` occurrences with some properties adjusted.

### Examples
Check out the playground:

```swift
import DateInRegion

//: #### Initialisers
//: Create a new date object with the current date & time alike NSDate()
let date = DateInRegion()

//: Create a determined date
let determinedDate = DateInRegion(year: 2011, month: 2, day: 11)!

//: Create a determined date in a different time zone
let usaTimeZone = NSTimeZone(abbreviation: "EST")!
var usaDate = DateInRegion(year: 2011, month: 2, day: 11, hour: 14, timeZone: usaTimeZone)!

//: Mind that default values for DateInRegion(year etc) are taken from the reference date,
//: which is 1 January 2001, 00:00:00.000 in your default time zone and against your current calendar.

//: Week oriented initiailisations are also possible: first week of 2016:
let weekDate = DateInRegion(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1)!
//: In Europe this week starts in 2015 despite the year for the week that is 2016.
//: That is because the Thursday of this week is in 2016 as specified by ISO 8601

//: Create a determined date in a different calendar
let hebrewCalendar = NSCalendar(identifier: NSCalendarIdentifierHebrew)
let hebrewDate = DateInRegion(year: 2011, month: 2, day: 11, hour: 14, calendar: hebrewCalendar)!

//: Create today's date at start of day
let today = DateInRegion.today()

//: Create a period that is the next weekend
let weekend = today.nextWeekend()!
let weekendStart = weekend.startDate
let weekendEnd = weekend.endDate

//: #### Calculations
//: One week later
let oneWeekLater = (determinedDate + 1.weeks)!

//: Twelve hours earlier
let earlier = (determinedDate - 12.hours)!

//: Or combinations
let something = ((determinedDate - 12.hours)! + 30.minutes)!

//: Create a new date based on another one with some different components
let newDate = oneWeekLater.withValue(14, forUnit: .Hour)!

//: ... or with a combination of components
let newDate2 = oneWeekLater.withValues([(13, .Hour), (12, .Minute)])!

//: #### NSDate
newDate.timeIntervalSinceReferenceDate
DateInRegion.earliestDate(newDate, newDate2, today, something)
DateInRegion.latestDate(newDate, newDate2, today, something)

//: #### Components
newDate2.year
newDate2.month
newDate2.day

newDate2.yearForWeekOfYear
newDate2.weekOfYear
newDate2.weekday

newDate2.hour
newDate2.minute
newDate2.second

//: #### StartOF & EndOF
//: Create new dates based on this week's start & end
let startOfWeek = newDate.startOf(.WeekOfYear)
let endOfWeek = newDate.endOf(.WeekOfYear)

//: Create new dates based on this day's start & end
let startOfDay = newDate.startOf(.Day)
let endOfDay = newDate.endOf(.Day)

//: Create new dates based on this day's start & end
let startOfYear = newDate.startOf(.Year)
let endOfYear = newDate.endOf(.Year)

//: #### Conversions
//: Change time zone
let usaDate2 = DateInRegion(region: newDate2, timeZone: usaTimeZone)

//: Change and time zone calendar to Islamic in Dubai
let dubaiTimeZone = NSTimeZone(abbreviation: "GST")!
let dubaiCalendar = NSCalendar(identifier: NSCalendarIdentifierIslamicCivil)!
let dubaiDate = DateInRegion(region: newDate2, calendar: dubaiCalendar, timeZone: dubaiTimeZone)

//: Again, but now we go to New Delhi
let indiaTimeZone = NSTimeZone(abbreviation: "IST")!
let indiaCalendar = NSCalendar(identifier: NSCalendarIdentifierIndian)!
let indiaDate = DateInRegion(region: newDate2, calendar: dubaiCalendar, timeZone: dubaiTimeZone)

//: #### Equations
//: DateInRegion conforms to the Equatable protocol. I.e. you can compare with == for equality.
newDate == newDate2
newDate == newDate

//: For equal date values, you should use x.isEqualToDate(y)
let newDate3 = DateInRegion(region: newDate2)!
newDate == newDate3
let newDate4  = DateInRegion(region: newDate2, locale: NSLocale(localeIdentifier: "en_NZ"))!
newDate4 == newDate3
newDate.isEqualToDate(newDate3)
newDate2.toString()
newDate3.toString()
newDate4.toString()

//: #### Comparisons
//: DateInRegion conforms to the Comparable protocol. I.e. you can compare with <. <=, ==, >=, >
newDate > newDate2
newDate >= newDate2
newDate == newDate2
newDate != newDate2
newDate <= newDate2
newDate < newDate2

//: Mind that comparisons takes the absolute time from the date property into account.
//: calendars and time zones have no effect on the comparison results.
let date1 = DateInRegion(year: 2000, month: 1, day: 1, hour: 14, timeZone: NSTimeZone(abbreviation: "UTC"))!
let date2 = (date1 + 1.hours)!

//: date1 = 14:00 UTC
//: date2 = 15:00 UTC
date1 > date2
date1 < date2

let indiaDate1 = DateInRegion(region: date1, calendar: indiaCalendar, timeZone: indiaTimeZone)!

//: indiaDate1 = 19:30 IST
//: date1 = 14:00 UTC
//: date2 = 9:00 CST
indiaDate1 > date2
indiaDate1 < date2

indiaDate1.isEqualToDate(date1)

//: QED: same outcome!


//: #### Collections

//: Use as a key in a dictionary
var birthdays = [DateInRegion: String]()
birthdays[DateInRegion(year: 1997, month: 5, day: 7)!] = "Jerry"
birthdays[DateInRegion(year: 1999, month: 12, day: 14)!] = "Ken"
birthdays[DateInRegion(year: 1990, month: 12, day: 5)!] = "Sinterklaas"
birthdays.sort({ (a: (date: DateInRegion, String), b: (date: DateInRegion, String)) -> Bool in
return a.date < b.date
})



//: #### Display
//: DateInRegion conforms to the ConvertString protocol
date2.description

//: Various NSDateFormatter properties are ported
let date3 = (date1 + 7.hours)!
date3.toString()
date3.toString(.LongStyle)
date3.toString(dateStyle: .LongStyle)
date3.toString(timeStyle: .LongStyle)
date3.toString("dd-MMM-yyyy HH:mm")
(DateInRegion() + 1.days)!.toRelativeString()
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 9 is required.
The test code requires Quick and Nimble to be implemented. You can do so by running ``pod install`` in the ``Examples`` folder.

## Installation

### Cocoapods
DateInRegion is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DateInRegion"
```
### Manual
Get a git clone and add ``DateInRegion.swift`` to your project.

```shell
git clone https://github.com/Hout/DateInRegion.git
```

## Design Decisions
I have taken the following decisions when setting up the library. I welcome  feedback on them.

Decision | Rationale
------------- | -------------
Do not include an initialiser from string  | That is too complicated with all the different ways of notation in the world. It would have too little benefit next to the currently available convenience intialisers instead.
Do not attempt to mimic all properties and functions of the NSDateFormatter, NSDateComponents etc. E.g. NSDateFormatter's ``localizedStringFromDate`` or ``weekdaySymbols`` | Sometimes it is just easier to use the ``date`` property from ``DateInRegion`` instead.
Equation ``==`` is not for just the date value but for the whole object | Alike NSObject regulations; although objects do not have to be the same instance, they must contain equal properties

## Author

Jeroen Houtzager, pls contact me through GitHub

## Collaboration

if you would like to contribute:

- Fork
- Send pull requests
- Submit issues
- Challenge the design decisions
- Challenge coding
- Challenge anything!

These libs & authors inspired me to this code:

- [SwiftDate](https://github.com/malcommac/SwiftDate) from Daniele Margutti. I recommend this one if you are looking for a plain Swift NSDate extension.


## License

DateInRegion is available under the MIT license. See the LICENSE file for more info.
