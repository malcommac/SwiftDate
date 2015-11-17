# DateInRegion

[![Build Status](https://travis-ci.org/Hout/DateInRegion.svg?branch=master)](https://travis-ci.org/Hout/DateInRegion)
[![Version](https://img.shields.io/cocoapods/v/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)
[![License](https://img.shields.io/cocoapods/l/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)
[![Platform](https://img.shields.io/cocoapods/p/DateInRegion.svg?style=flat)](http://cocoapods.org/pods/DateInRegion)

DateInRegion is a wrapper around NSDate that exposes the properties of NSDateComponents, NSCalendar, NSTimeZone, NSLocale and NSDateFormatter. The best way to see it is as a localised (locale) moment (date) in a time zone (timeZone) within a calendrical system (calendar). The intention is to replace your occurrence of NSDate with DateInRegion and get the same functionality plus lots of local date/calendar/time zone/formatter goodies. Thus offering date functions with a flexibility that I was looking for when creating this library.

An extension is available for NSDate with which enables you to map an NSDate object to a DateInRegion object by adding the region.

### Features

- Use the object as an NSDate. I.e. as an absolute time. 
- Offers many NSDate, NSCalendar, NSDateFormatter & NSDateComponent vars & methods
- Initialise a date with any combination of components
- DateInRegion is immutable, so thread safe. It contains a constructor to easily create new `DateInRegion` occurrences with some properties adjusted.
- Implements date addition and subtraction operators with date components. E.g. `date + 2.days`
- Default date is `NSDate()`
- Default calendar is `NSCalendar.currentCalendar()`
- Default time zone is `NSTimeZone.defaultTimeZone()`
- Default locale is `NSLocale.currentLocale()`
- Contains a date (NSDate), a calendar (NSCalendar), a locale (NSLocale) and a timeZone (NSTimeZone) property
- Implements the ``Equatable`` & ``Comparable`` protocols betwen dates with operators. E.g. `==, !=, <, >, <=, >=`
- Implements the ``Hashable`` protocol so the date can be used as a key in a Dictionary.

### Examples
Check out the playground:

```swift
import DateInRegion

// First create some regions
let local = DateRegion()
let india = DateRegion(calendarID: NSCalendarIdentifierIndian, timeZoneID: "IST", localeID: "en_IN")
let dubai = DateRegion(calendarID: NSCalendarIdentifierIslamic, timeZoneID: "GST", localeID: "ar_AE")
let newZealand = DateRegion(calendarID: NSCalendarIdentifierGregorian, localeID: "en_NZ", timeZoneID: "Pacific/Auckland")
let israel = DateRegion(calendarID: NSCalendarIdentifierHebrew, timeZoneID: "Asia/Jerusalem", localeID: "he_IL")
let china = DateRegion(calendarID: NSCalendarIdentifierChinese, timeZoneID: "CST", localeID: "zn_CH")
let magadan = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "Asia/Magadan", localeID: "ru_RU")
let thailand = DateRegion(calendarID: NSCalendarIdentifierBuddhist, timeZoneID: "Asia/Bangkok", localeID: "th_TH")
let japan = DateRegion(calendarID: NSCalendarIdentifierBuddhist, timeZoneID: "Asia/Tokyo", localeID: "ja_JP")
let unalaska = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "AKST", localeID: "en_US")
let utc = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "UTC", localeID: "en_US_POSIX")


//: #### Initialisers
//: Create a new date object with the current date & time alike NSDate()
let now = DateInRegion()

//: Create a determined date
let newDate = DateInRegion(year: 2011, month: 2, day: 11)!

//: Create a determined date in a different time zone
let newYork = DateRegion(timeZoneID: "EST")
DateInRegion(fromDate: newDate, hour: 14, region: newYork)!

//: Mind that default values for DateInRegion(year etc) are taken from the reference date,
//: which is 1 January 2001, 00:00:00.000 in your default time zone and against your current calendar.

//: Week oriented initiailisations are also possible: first week of 2016:
let weekDate = DateInRegion(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1)!
//: In Europe this week starts in 2015 despite the year for the week that is 2016.
//: That is because the Thursday of this week is in 2016 as specified by ISO 8601

// Conversions
let unalaskaDate = now.inRegion(unalaska)
let newYorkDate = now.inRegion(newYork)
let indiaDate = now.inRegion(india)
let dubaiDate = now.inRegion(dubai)
let israelDate = now.inRegion(israel)
let chinaDate = now.inRegion(china)
let newZealandDate = now.inRegion(newZealand)
let magadanDate = now.inRegion(magadan)
let japanDate = now.inRegion(japan)
let thailandDate = now.inRegion(thailand)
let utcDate = now.inRegion(utc)

// Or convert to local
let japanDate2 = DateInRegion(year: 2010, month: 4, day: 5, hour: 16, region: japan)!
let localDate = japanDate2.inLocalRegion()

// Now look in regional format
unalaskaDate.toString()
newYorkDate.toString()
indiaDate.toString()
dubaiDate.toString()
israelDate.toString()
chinaDate.toString()
magadanDate.toString()
japanDate.toString()
thailandDate.toString()
newZealandDate.toString()
utcDate.toString()

japanDate2.toString()
localDate.toString()

// Or get date components
unalaskaDate.hour
unalaskaDate.day
unalaskaDate.month
unalaskaDate.year

dubaiDate.hour
dubaiDate.day
dubaiDate.month
dubaiDate.year

magadanDate.hour
magadanDate.day
magadanDate.month
magadanDate.year


//: #### Equations
//: DateInRegion conforms to the Equatable protocol. I.e. you can compare with == for equality.
let newDate2 = DateInRegion(fromDate: newDate)
let newDate3 = DateInRegion(fromDate: newDate, hour: 9)!
newDate == newDate
newDate == newDate2
newDate == newDate3

//: For equal date values, you should use x.isEqualToDate(y) note that this compares the moment not the region

//: #### Comparisons
//: DateInRegion conforms to the Comparable protocol. I.e. you can compare with <. <=, ==, >=, >
newDate > newDate2
newDate >= newDate2
newDate == newDate2
newDate != newDate2
newDate <= newDate2
newDate < newDate2

//: Mind that comparisons takes the absolute time from the date property into account.
//: regions (calendars, time zones, locales, have no effect on the comparison results.
let date1 = DateInRegion(year: 2000, month: 1, day: 1, hour: 14, region: utc)!
let date2 = (date1 + 1.hours)!

//: date1 = 14:00 UTC
//: date2 = 15:00 UTC
date1 > date2
date1 < date2

let indiaDate1 = DateInRegion(fromDate: date1, region: india)

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



//: #### Display & string conversion
//: DateInRegion conforms to the ConvertString protocol
chinaDate.description
chinaDate.toString()

// Various string styles
now.toString()!
now.toString(.LongStyle)!
now.toString(.MediumStyle)!
now.toString(.ShortStyle)!
now.toString(dateStyle: .ShortStyle)!
now.toString(timeStyle: .MediumStyle)!
now.toString(dateStyle: .LongStyle, timeStyle: .ShortStyle)!
now.toString("YYYY")!
now.toString("yy-mm-dd")!
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
Primary function of `DateInRegion` is to be able to switch and convert dates between regions. Not to deal with dates in the local region, although it can be used for that.|That is just the way I needed it :-)
`DateInRegion` is not an extension to `NSDate` | `NSDate` extensions in general represent the current date in various formats. Extensions also limit the class as you cannot add stored properties. The latter I need to store the regional data (calendar, time zone & locale). Cocoapods offers plenty `NSDate` extensions e.g. [SwiftDate](www.cocoapods.com/pods/SwiftDate).
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
