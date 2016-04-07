## Inspect Date Properties

All methods and properties which follows are the same for both of the classes but while in NSDate returns value in the default region (Region.defaultRegion, which if not changed means current device's locale/timezone/calendar) and the DateRegion variant values are returned in the specified region.

Suppose you have:

```swift
let inRome = ... // 2015-02-01 00:45:00 Europe/Rome (+1 from GMT)
let date = inRome.absoluteTime() ... // get the absolute time: '2015-01-31 23:45:00 UTC
```

Properties and functions available:

| Property/function       | Description                              | NSDate | DateInRegion |
| ----------------------- | ---------------------------------------- | ------ | ------------ |
| `era`                   | Returns the era number of the receiver   | x      | x            |
| `year`                  | Returns the year number of the receiver  | x      | x            |
| `yearForWeekOfYear`     | Returns the year number for the weekOfYear of the receiver | x      | x            |
| `month`                 | Returns the month number (1...12) of the receiver | x      | x            |
| `monthName`             | Returns the month name of the receiver   | x      | x            |
| `shortMonthName`        | Returns the short month name of the receiver | x      | x            |
| `monthDays`             | Returns the number of days in the month (28...31) of the receiver | x      | x            |
| `weekOfYear`            | Returns the week number in the year (1...53) of the receiver | x      | x            |
| `weekOfMonth`           | Returns the week number in the month (0...5) of the receiver | x      | x            |
| `weekday`               | Returns the day number in the week (1...7) of the receiver | x      | x            |
| `weekdayName`           | Returns the weekday name of the receiver | x      | x            |
| `weekdayOrdinal`        | Returns the ordinal weekday in this month (e.g. third Tuesday this month) (0...5) for the receiver | x      | x            |
| `day`                   | Returns the day number (0...31) in the month of the receiver | x      | x            |
| `hour`                  | Returns the hour (0...24) of the receiver | x      | x            |
| `minute`                | Returns the minute (0...59) of the receiver | x      | x            |
| `seconds`               | Returns the seconds (0...59) of the receiver | x      | x            |
| `nanosecond`            | Returns the nanosecond (0...999999999) of the receiver | x      | x            |
| `firstDayOfWeek`        | Returns the first day of the week of the receiver | x      | x            |
| `lastDayOfWeek`         | Returns the last day of the week of the receiver | x      | x            |
| `leapMonth`             | returns `true` if the receiver is in a leap month | x      | x            |
| `leapYear`              | returns `true` if the receiver is in a leap year | x      | x            |
| `components`            | return the NSDateComponents of a date    | x      | x            |
| `calendar`              | Returns the NSCalendar object of the receiver | .      | x            |
| `locale`                | Returns the NSLocale object of the receiver | .      | x            |
| `timeZone`              | Returns the NSTimeZone object of the receiver | .      | x            |
| `components(inRegion:)` | returns the components for a specific region | x      | .            |
| `thisWeekend()`         | to return the start and end of the current weekend or `nil` if the receiver is not in a weekend | x      | x            |
| `nextWeekend()`         | to return the start and end of the next weekend | x      | x            |
| `previousWeekend()`     | to return the start and end of the previous weekend | x      | x            |
| `firstDayOfWeek()`      | returns midnight on the first day of the week | x      | x            |
| `lastDayOfWeek()`       | returns the end of the last day of the week | x      | x            |
| `inRegion()`            | returns a `DateInRegion` object for the receiver | x      | .            |
| `absoluteTime`          | Returns an `NSDate` object with the absolute time of the receiver | .      | x            |

Class functions available:

| Function      | Description                   | NSDate | DateInRegion | DateRegion |
| ------------- | ----------------------------- | ------ | ------------ | ---------- |
| `today()`     | Returns today at midnight     | x      | .            | x          |
| `tomorrow()`  | Returns tomorrow at midnight  | x      | .            | x          |
| `yesterday()` | Returns yesterday at midnight | x      | .            | x          |

All `NSDate` functions are evaluated against the current region by default (Region.defaultRegion; you can change it if you want). If you want a value for another region you can add the `inRegion:` parameter. E.g. `nsdate.nextWeekend(inRegion: china)` will return the start and end of the next weekend in China. Mind that the return values are `NSDate` objects. If you want `DateInRegion` return values then you can use `nsdate.inRegion(china).nextWeekend()`. This will create a `DateInRegion` object from the `nsdate` object and then evaluate the `nextWeekend` function.

The properties `monthName`, `shortMonthName` and `weekdayName` return `String` objects against the current locale for `NSDate` and for the locale registered with the `DateRegion` for `DateInRegion`.
