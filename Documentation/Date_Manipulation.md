![](./SwiftDate.png)

<a name="index"/>

- [**Index**: Table Of Contents](#Index.md)
- [**Prev Chapter**: Parsing Dates](#Parsing_Dates.md)
- [**Next Chapter**: Date Comparison](#Date_Comparison.md)

## Date Manipulation

- [Add/Remove Time Units from Date](Date_Manipulation.md#mathdate)
- [Rounding a Date](Date_Manipulation.md#roundingdate)
- [Trouncating a Date](Date_Manipulation.md#trouncatingdate)
- [Alter Time in Date](Date_Manipulation.md#altertimedate)
- [Alter Multiple Date Components](Date_Manipulation.md#altercomponents)

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

[**Next Chapter**: Date Comparison](#Date_Comparison.md)