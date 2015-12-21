# Upgrading 
## From SwiftDate 1.2 to v2
SwiftDate 2 is completely rewritten version of SwiftDate. We added support for timezones and fixed/changed many methods and properties. Due to these changes old SwiftDate 1.2 code may not work properly.

Please refer to the table below for SwiftDate v1.2 objects and their v2.0 equivalents. Here `nsdate`, `dateInRegion` and `dateRegion` variables refer to `NSDate`, `DateInRegion` and `DateRegion` objects respectively.

SwiftDate v1.2 | SwiftDate v2
-------------- | --------------
`nsdate.year` <br>NSDateComponents in current calendar & time zone | No change
`nsdate.monthName` <br>String representations of NSDateComponents in current calendar & time zone | No change
`nsdate.firstDayOfWeek()` | `nsdate.startOf(.WeekOfYear)`
`nsdate.lastDayOfWeek()` | `nsdate.endOf(.WeekOfYear)`
`nsdate.nearestHour()` | No change
`NSDate(fromString:format:)` | `String.toDate(format:)`
`NSDate.ISO8601Formatter` | No change
`NSDate(refDate:year: etc)` | `NSDate(fromDate:year: etc)`
`NSDate.today(timezone:)`<br>Equivalent for yesterday and tomorrow | No change for the default region (calendar, locale, time zone)<br>`region.today()` if you want to have the today value for another region
`nsdate.set(year: etc)`|``NSDate`(fromDate:year: etc)` If you want to set a date component
`nsdate.set(componentsDict:)`|TODO: Investigate
`nsdate.set(name:value:)`|``NSDate`(fromDate:year: etc)`
`nsdate.add(year: etc)`|``NSDate` + 1.year etc`
`nsdate.add(componentsDict)`|``NSDate` + 1.year etc`
`nsdate.toUTC`|There is no `NSDate` object for UTC or whatever time zone. It can be represented as such though by creating a `DateInRegion` object with the UTC time zone:<br> `nsdate.inRegion(timeZoneRegion: timeZoneNames.UTC)`
`nsdate.toLocalTime`|There is no `NSDate` for local time or whatever time zone. It can be represented as such though by creating a `DateInRegion` object with the local time zone:<br> `nsdate.inRegion(timeZoneRegion: timeZoneNames.Local)`
`nsdate.toTimeZone(timeZone:)`|There is no `NSDate` for local time or whatever time zone. It can be represented as such though by creating a `DateInRegion` object with the local time zone:<br> `nsdate.inRegion(timeZoneRegion: TimeZoneNames.America.New_York)`
`nsdate.difference(toDate:unitFlags:)`|Function result is optional. It will return `nil` on error.
`nsdate.isEqualToDate(date:ignoreTime: false)`|*Foundation* library function `nsdate.isEqualToDate(date:)`
`nsdate.isEqualToDate(date:ignoreTime: true)`|`nsdate1 == nsdate2`
`nsdate.isLeapYear()`|No change
Not available|`nsdate.leapMonth`
`nsdate.isWeekend(calendar:)`|`nsdate.isWeekend()` can only be applied to the current calendar. If you want another calendar or time zone, please use `dateInRegion.isInWeekend()`
`nsdate.monthDays()`| No change
`nsdate.isToday()`|No change
`nsdate.isTomorrow()`|No change
`nsdate.isYesterday()`|No change
`nsdate.isThisWeek()`|No change
`nsdate.isThisMonth()`|No change
`nsdate.isThisYear()`|No change
`nsdate.isSameWeekOf(date:)`|`nsdate.isIn(.WeekOfYear, ofDate:)`
`nsdate.dateAtWeekStart()`|`nsdate.startOf(.WeekOfYear)`
`nsdate.beginningOfDay()`|`nsdate.startOf(.Day)`
`nsdate.endOfDay()`|`nsdate.endOf(.Day)`
`nsdate.beginningOfMont()`|`nsdate.startOf(.Month)`
`nsdate.endOfMonth()`|`nsdate.endOf(.Month)`
`nsdate.isSameMonthOf(date:)`|`nsdate.isIn(.Month, ofDate:)`
`nsdate.beginningOfYear()`|`nsdate.startOf(.Year)`
`nsdate.endOfYear()`|`nsdate.endOf(.Year)`
`nsdate.isSameYearOf(date:)`|`nsdate.isIn(.Year, ofDate:)`
`nsdate.isWeekend()`|No change
`nsdate.isWeekday()`|`!nsdate.isInWeekend()`

<!-- TODO: All string handling -->

Please note:
* all operations on `NSDate` assume the default time zone, the current locale and the current calendar. In most functions an optional `inRegion:` parameter can be passed.
* the *etc* indication indicates that other date components can be used instead of just `year`.

