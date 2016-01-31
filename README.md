![SwiftDate](https://raw.githubusercontent.com/malcommac/SwiftDate/master/swiftdate-logo.png)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CI Status](https://travis-ci.org/malcommac/SwiftDate.svg)](https://travis-ci.org/malcommac/SwiftDate) [![Version](https://img.shields.io/cocoapods/v/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![License](https://img.shields.io/cocoapods/l/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![Platform](https://img.shields.io/cocoapods/p/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)

Welcome to SwiftDate 3 a Date Management Library for Apple's platforms: the goal of this project is to allow developers to manage easily dates operation and timezones conversions in Swift. SwiftDate allows you to:
- [x] Perform **calculations with dates**: `aDate + 2.weeks + 1.hours` or `(1.years - 2.hours + 16.minutes).fromNow()`
- [x] **Compare dates** with math operators `<,>,==,<=,>=`. For example you can do `aDate1 >= aDate2` or `aDate1.inTimeRange("15:20","20:20")`
- [x] **Easily get time components**. E.g. `aDateInRegion.day` or `hour, minutes etc.`
- [x] Easy/optimized way **to get and transform a date from and to strings** (with **relative date supports*** like '2 hours, 5 minutes' etc.)
- [x] **Easy conversions to and from timezone, locale and calendar**. Use helper class `DateInRegion` and perform conversions with components and operations!
- [x] Many shortcuts to get intervals and common dates (`isYesterday,isTomorrow...`)
- [x] Compatible with Swift 2.0+ and iOS/Mac/WatchOS/tvOS platforms
- [x] _... many many other shiny things!_

## What is `NSDate` really?
`NSDate` is the central class of the date/time handling in Foundation framework. It encapsulates a moment in time that is  internally stored as the number of seconds since Jan 1, 2001 at 00:00 UTC. It is [universal](http://en.wikipedia.org/wiki/Coordinated_Universal_Time) as such that it is the same moment everywhere around the world and beyond (we do not have [star date](https://en.wikipedia.org/wiki/Stardate) yet ;-) ). We call it 'absolute time'.

See absolute time as the moment that someone in the USA has a telephone conversation with someone in Dubai. Both have that conversation at the same moment (absolute time) but the local time will be different due to time zones, different calendars, different alphabets and/or different date notation methods. You need helper classes like `NSCalendar` to represent an `NSDate` object and perform calculations on it.

This important concept is the root of several problems for programmers when dealing with time conversions across time zones, calendars and locales in Cocoa. Here SwiftDate comes to the rescue.

# It is time for SwiftDate

SwiftDate introduces the concepts of `DateRegion` and `DateInRegion`. The former contains everything to represent a moment in time in the calendar, time zone and locale of the region specified. The latter is a combination of an absolute time (`NSDate`) with a `DateRegion` object. See it as an object that encapsulates a moment in time in a certain region.

In SwiftDate you can work with date components both for `DateInRegion` and `NSDate`.
When you work with `NSDate` you are working with an absolute time and components are evaluated against your local region. When you work with the `DateInRegion` class then all methods and properties are represented with a region that you can specify.


# Reference documentation
- [User guide](./Documentation/UserGuide.md)
- [Installation guide](./Documentation/Installation.md)
- [Upgrade guide](./Documentation/UpgradeGuide.md)
- [Design guide](./Documentation/Design.md)
- [Change history](./CHANGELOG.md)


# Author
This library was created by [Daniele Margutti](https://github.com/malcommac) with contribution of [Jeroen Houtzager](https://github.com/Hout). Any help is welcome; feel free to post your issue or pull request, in the spirit of open source software.

# Older Versions
SwiftDate 1.2 branch last revision is available [here](https://github.com/malcommac/SwiftDate/releases/tag/1.2). This version is unsupported.
