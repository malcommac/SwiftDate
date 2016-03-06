# Upgrading 
##Note on v2
TBD

##From SwiftDate 1.2 to v3
SwiftDate 3 is a completely rewritten version of SwiftDate. We added support for timezones, fixed/changed many methods and properties and resolved quite a few inconsistencies. Due to these changes old SwiftDate 1.2 code may not work properly.

Please refer to the table below for SwiftDate v1.2 objects and their v3 equivalents. Here `nsdate`, `dateInRegion` and `region` variables refer to `NSDate`, `DateInRegion` and `Region` objects respectively.

###Main changes
As a rule of thumb, you can use `NSDate` objects for anything local without references to other time zones, locales and calendars. Use `DateInRegion` and `Region` objects for anything that has to do with conversions to another time zone, locale or calendar. `Region` encapsulates these last thee classes.

Example:

```swift
let london = Region(timeZoneName: .EuropeGreatBritain)
let date = NSDate() // current time
print(date.toString()) // E.g. "25-Dec-15 18:45 CET". Layout depends on the printing format.
let dateInLondon = date.inRegion(london)
print(dateInLondon) // E.g. "25-Dec-15 17:45 GMT"
```

Use of enum types for calendar, time zone and locale to create a `Region` object. Check `CalendarName`, `TimeZoneName` and `LocaleName`. Refer to these classes for more information. 

Example:

```swift
let anchorage = Region(calendarName: .Gregorian, timeZoneName: .AmericaAnchorage, localeName: .EnglishUnitedStates)
let rome = Region(calendarName: .Gregorian, timeZoneName: .EuropeRome, localeName: .ItalianItaly)
let jerusalem = Region(calendarName: .Hebrew, timeZoneName: .AsiaJerusalem, localeName: .EnglishIsrael)
let bangkok = Region(calendarName: .Buddhist, timeZoneName: .AsiaBangkok, localeName: .ThaiThailand)
let buenosAires = Region(calendarName: .Georgian, timeZoneName: .AmericaArgentinaBuenosAires, localeName: .SpanishArgentina)
let capetown = Region(calendarName: .Georgian, timeZone: .AfricaJohannesburg, locale: AfrikaansSouthAfrica)
let cairo = Region(calendarName: .Islamic, timeZone: .AfricaCairo, locale: ArabicEgypt)
let riyadh = Region(calendarName: .IslamicUmmAlQura, timeZone: .AsiaRiyadh, locale: ArabicSaudiArabia)
let ankara = Region(calendarName: .Gregorian, timeZoneName: .EuropeIstanbul, localeName: .TurkishTurkey)
let magadan = Region(calendarName: .Gregorian, timeZoneName: .AsiaMagadan, localeName: .RussianRussia)
let utc = Region(calendarName: .Gregorian, timeZoneName: .Gmt, localeName: .English)
```

You can leave out parameters to use your local calendar, time zone or locale to initialise the region. 


###Reference

SwiftDate v1.2 | SwiftDate v2
-------------- | --------------
`nsdate.year`, `nsdate.hour` etc.  <br>NSDateComponents in current calendar & time zone | No change
`nsdate.monthName` <br>String representations of NSDateComponents in current calendar & time zone | No change
`nsdate.firstDayOfWeek()` | `nsdate.startOf(.WeekOfYear)`
`nsdate.lastDayOfWeek()` | `nsdate.endOf(.WeekOfYear)`
`nsdate.nearestHour()` | No change
`NSDate(fromString:format:)` | `String.toDate(format:)`
`NSDate.ISO8601Formatter` | No change
`NSDate(refDate:year: etc)` | `NSDate(fromDate:year: etc)`
`NSDate.today(timezone:)`<br>Equivalent for yesterday and tomorrow | No change for the default region (calendar, locale, time zone)<br>`region.today()` if you want to have the today value for another region
`nsdate.set(year: etc)`|`NSDate(fromDate:year: etc)` If you want to set a date component
`nsdate.set(name:value:)`|`NSDate(fromDate:year: etc)`
`nsdate.add(year: etc)`|`NSDate + 1.year etc`
`nsdate.toUTC`|There is no `NSDate` object for UTC or whatever time zone. It can be represented as such though by creating a `DateInRegion` object with the UTC time zone:<br> `nsdate.inRegion(timeZoneName: .Gmt)`
`nsdate.toLocalTime`|There is no `NSDate` for local time or whatever time zone. It can be represented as such though by creating a `DateInRegion` object with the local time zone:<br> `nsdate.inRegion()`
`nsdate.toTimeZone(timeZone:)`|There is no `NSDate` for local time or whatever time zone. It can be represented as such though by creating a `DateInRegion` object with the local time zone:<br> `nsdate.inRegion(timeZoneName: .AmericaNewYork)`
`nsdate.difference(toDate:unitFlags:)`|Function result is optional. It will return `nil` on error.
`nsdate.isEqualToDate(date:ignoreTime: false)`|*Foundation* library function `nsdate.isEqualToDate(date:)`
`nsdate.isEqualToDate(date:ignoreTime: true)`|`nsdate1 == nsdate2`
`nsdate.isLeapYear()`|`nsdate.leapYear`
Not available|`nsdate.leapMonth`
`nsdate.isWeekend(calendar:)`|`nsdate.isWeekend()` can only be applied to the current calendar. If you want another calendar or time zone, please use `dateInRegion.isInWeekend()`
`nsdate.monthDays()`| No change
`nsdate.isToday()`|`nsdate.isInToday()`
`nsdate.isTomorrow()`|`nsdate.isInTomorrow()`
`nsdate.isYesterday()`|`nsdate.isInYesterday()`
`nsdate.isThisWeek()`|`nsdate.isIn(.WeekOfYear)`
`nsdate.isThisMonth()`|`nsdate.isIn(.Month)`
`nsdate.isThisYear()`|`nsdate.isIn(.Year)`
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
`nsdate.isWeekend()`|`nsdate.isInWeekend()`
`nsdate.isWeekday()`|`!nsdate.isInWeekend()`

<!-- TODO: All string handling -->

Please note:
* all operations on `NSDate` assume the default time zone, the current locale and the current calendar. In most functions an optional `inRegion:` parameter can be passed.
* the *etc* indication indicates that other date components can be used instead of just `year`.

