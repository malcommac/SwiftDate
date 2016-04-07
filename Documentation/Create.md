##Create an NSDate
SwiftDate provides a number of helper functions to create `NSDate` objects.
The absolute time that is created this way reflects the components in you current time zone and calendar.

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

if you want to state the time in a different region then just pass a valid Region struct. Resulting NSDate will be adjusted to follow the region choosed.
Mind that the region info is NOT incapsulated in NSDate objects. I.e. you get an absolute time that differs from the local time. That is, of course, when the specified date region is NOT the default region.

```swift
let newYork = Region(timeZoneName: TimeZoneName.AmericaNewYork)
let date1 = NSDate(year: 2015, month: 12, day: 25, region: newYork)
```