![](./SwiftDate.png)

<a name="index"/>

- [**Index**: Table Of Contents](#Index.md)
- [**Prev Chapter**: Parsing Dates](#Parsing_Dates.md)
- [**Next Chapter**: Date Comparison](#Date_Comparison.md)

## Date Manipulation & Creation

- [Add/Remove Time Units from Date](Date_Manipulation.md#mathdate)
- [Rounding a Date](Date_Manipulation.md#roundingdate)
- [Trouncating a Date](Date_Manipulation.md#trouncatingdate)
- [Alter Time in Date](Date_Manipulation.md#altertimedate)
- [Alter Multiple Date Components](Date_Manipulation.md#altercomponents)
- [Getting Related Dates (nextYear,nextWeeekday,startOfMonth etc.)](Date_Manipulation.md#relateddates)
- [Enumerate Dates](Date_Manipulation.md#enumeratedates)
- [Generate Random Dates](Date_Manipulation.md#randomdates)

Dates can be manipulated as you need by using classic math operators and readable time units.

<a name="mathdate"/>

### Add/Remove Time Units from Date

SwiftDate allows to use numbers to work with time components in dates. By extending the `Int` type it defines a list of time units:

- `nanoseconds`
- `seconds`
- `minutes`
- `days`
- `weeks`
- `months`
- `quarters`
- `years`

You can use a value followed by one of these unit specifications to add or remove the component from a date.

So, for example, you can produce a date which can be a mix of intuitive math operations:

```swift
let oneYearAhead = DateInRegion() + 1.years
let someMinutesAgo = date1 - 2.minutes
let fancyDate = date1 + date2 + 3.hours - 5.minutes + 1.weeks
```

> IMPORTANT NOTE: These values are converted automatically to `DateComponents` evaluated in the same context of the target `Date` or `DateInRegion`'s `calendar`.

Another way to add time components to a date is to use the `dateByAdding()` function:

`func dateByAdding(_ count: Int, _ component: Calendar.Component) -> DateInRegion`

takes two arguments:

- `count | Int` value to add (maybe negative)
- `component | Calendar.Component` the time unit components to add.

> IMPORTANT NOTE: New date is evaluated in the same context of the target `Date` or `DateInRegion`'s `calendar`.

```swift
let nextDate = dateA.dateByAdding(5, .years) // 5 years from dateA
```

[^ Top](#index)

<a name="roundingdate"/>

### Rounding a Date

`.dateRoundedAt()` function allows to round a given date time to the passed style: off, up or down.

`func dateRoundedAt(at style: RoundDateMode) -> DateInRegion`

takes a single argument:

- `style | RoundDateMode`: define the style of rounding: it can be `off`, `ceil` (up) or `floor` (down). `RoundDateMode` defines a list of convenience rounding to 5,10,30 minutes but you can use `.toMins()`, `.toCeilMins()` or `.toFloorMins()` and pass your own rounding values expressed in minutes.

Example:

```swift
let rome = Region(...)
let format = "yyyy-MM-dd HH:mm:ss"

// Round down 10mins
let date =  DateInRegion("2017-07-22 00:03:50", format: format, region: rome)
let r10min = date.dateRoundedAt(.to10Mins) // 2017-07-22T00:00:00+02:00

// Round up 30min
let r30min = "2015-01-24 15:07:20".toDate(format: format, region: rome).dateRoundedAt(.toCeil30Mins) // 2015-01-24T15:30:00+01:00
```

[^ Top](#index)

<a name="trouncatingdate"/>

### Trouncating a Date
Sometimes you may need to truncate a date by zeroing all values below certain time unit. `.dateTruncated(from:) and .dateTruncated(to:)` functions can be used for this scope.

#### Truncating From
It creates a new instance by truncating the components starting from given components down the granurality.

`func dateTruncated(from component: Calendar.Component) -> DateInRegion?`

#### Truncated At
It creates a new instance by truncating all passed components.

`func dateTruncated(at components: [Calendar.Component]) -> DateInRegion?`

Examples:

```swift
let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
let date = "2017-07-22 15:03:50".toDate(format: "yyyy-MM-dd HH:mm:ss", region: rome)

let truncatedTime = date.dateTruncated(from: .hour) // 2017-07-22T00:00:00+02:00
let truncatedCmps = date.dateTruncated(at: [.month, .day, .minute]) // 2017-01-01T15:00:50+01:00
```

[^ Top](#index)

<a name="altertimedate"/>

### Alter Time in Date
Sometimes you may need to alter time in a specified date. SwiftDate allows you to perform this using `.dateBySet(hour:min:secs:options:)` function.

`func dateBySet(hour: Int?, min: Int?, secs: Int?, options: TimeAlterOptions = TimeAlterOptions()) -> DateInRegion?`

takes five arguments:

- `hour | Int?`: set a non `nil` value to change the hour value
- `min | Int?`: set a non `nil` value to change the minute value
- `secs | Int?`: set a non `nil` value to change the seconds value
- `options: TimeCalculationOptions`: allows to specify calculation options attributes (usually you don't need to set it).

Example:

```swift
let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
let date = DateInRegion("2010-01-01 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: rome)!

let alteredDate = date.dateBySet(hour: 20, min: 13, secs: 15) // 2010-01-01 20:13:15
```

[^ Top](#index)

<a name="altercomponents"/>

### Alter Multiple Date Components
SwiftDate allows you to return new date representing the date calculated by setting a specific components of a given date to  given values, while trying to keep lower components the same (altering more components at the same time may result in different-than-expected results, this because lower components maybe need to be recalculated).

`dateBySet(_ components: [Calendar.Component: Int]) -> DateInRegion?`

Takes one argument:

- `components | [Calendar.Component: Int]` a dictionary of key/values for each component you want to alter.

> **NOTE:** While the algorithm try to keep lower compoments the same, the resulting date may differ from what expected when you alter more than a component a time.


Example:

```swift
let _ = date.dateBySet([.month: 1, .day: 1, hour: 9, .minute: 26, .second: 0])
```

[^ Top](#index)

<a name="relateddates"/>

### Getting Related Dates (nextYear,nextWeeekday,startOfMonth etc.)
Sometimes you may need to generate a related date from a specified instance; maybe the next sunday, the first day of the next week or the start datetime of a date.
SwiftDate includes 20+ different "interesting" dates you can obtain by calling `.dateAt()` function from any `Date` or `DateInRegion` instance.

`func dateAt(_ type: DateRelatedType) -> DateInRegion`

takes just an argument which define the type of date you want to obtain starting from the receiver date.
`DateRelatedType` is an enum which has the following options:

- `startOfDay`
- `endOfDay`
- `startOfWeek`
- `endOfWeek`
- `startOfMonth`
- `endOfMonth`
- `tomorrow`
- `tomorrowAtStart`
- `yesterday`
- `yesterdayAtStart`
- `nearestMinute(minute:Int)`
- `nearestHour(hour:Int)`
- `nextWeekday(_: WeekDay)`
- `nextDSTDate`
- `prevMonth`
- `nextMonth`
- `prevWeek`
- `nextWeek`
- `nextYear`
- `prevYear`

> **CONTRIBUTE!** Have you a new related date you want to be part of this list? Create a [new PR](https://github.com/malcommac/SwiftDate/compare) with the code and unit tests and we'll be happy to add it to the list!

Examples:

```swift
// Return today's datetime at 00:00:00
let _ = DateInRegion().dateAt(.startOfDay)
// Return today's datetime at 23:59:59
let _ = DateInRegion().dateAt(.endOfDay)
// Return the date at the start of this week
let _ = DateInRegion().dateAt(.startOfWeek)
// Return current time tomorrow
let _ = DateInRegion().dateAt(.tomorrow)
// Return the next sunday from specified date
let _ = date.dateAt(.nextWeekday(.sunday))
// and so on...
```

[^ Top](#index)

<a name="enumeratedates"/>

### Enumerate Dates
Dates enumeration function allows you to generate a list of dates in a closed date intervals incrementing date components by a fixed or variable interval at each new date.

- **VARIABLE INCREMENT** `static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: ((DateInRegion) -> (DateComponents))) -> [DateInRegion]`
- **FIXED INCREMENT** `static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: DateComponents) -> [DateInRegion]`

Both of these functions are pretty similar; it takes:

- `startDate | DateInRegion`: the initial date of the enumeration (it will be item #0 of the final array)
- `endDate | DateInRegion`: the upper bound limit date. The last item of the array is evaluated automatically and maybe not equal to `endDate`.
- `increment | DateComponents or Function`: for fixed increment it takes a `DateComponents` instance which define the increment of time components at each new date; for variable it provides the latest date generated and require as return object of the closure the increment as `DateComponents`.


Examples:

```swift
let increment = DateComponents.create {
  $0.hour = 1
  $0.minute = 30
}
// Generate an array of dates where the first item is fromDate
// and each new date is incremented by 1h30m from the previous.
// Latest date is < endDate (but maybe not the same).
let dates = DateInRegion.enumerateDates(from: fromDate, to: toDate, increment: increment)
```

[^ Top](#index)

<a name="randomdates"/>

### Generate Random Dates
SwiftDate exposes a set of functions to generate a random date or array of random dates in a bounds.
There are several functions to perform this operation:

#### Single Random Date

- `randomDate(region:)` generate a random date into the specified region.
- `randomDate(withinDaysBeforeToday:region:)` generate a random date between now and a specified amount days ealier into the specified region.
- `randomDate(between:and:region:)` generate a random date into the specified region between two given date bounds.

#### Array of Random Dates
- `randomDates(count:between:and:region:)` return `count` random generated dates into the specified region between two given date bounds.

> **IMPORTANT**: For all of thes function if you don't specify the `region`, `SwiftDate.defaultRegion` is used instead.

Examples:

```swift
// Generate random dates array in limit
let now = DateInRegion()
let someYearsAgo = (upperBound - 3.years)
// generate 40 random dates between 3 years ago today and today
let randomDates = DateInRegion.randomDates(count: 40, between: someYearsAgo, and: now)

// Generate a random date between now and 7 days ago
let rome: Region = ...
let aDate = DateInRegion.randomDate(withinDaysBeforeToday: 7, region: rome) 
```

[^ Top](#index)

[**Next Chapter**: Date Comparison](#Date_Comparison.md)