![](./SwiftDate.png)

<a name="index"/>

- [**Index**: Table Of Contents](#Index.md)
- [**Prev Chapter**: Parsing Dates](#Parsing_Dates.md)
- [**Next Chapter**: Date Comparison](#Date_Comparison.md)

## Date Manipulation

- [Add/Remove Time Units from Date](Date_Manipulation.md#mathdate)
- [Rounding a Date](Date_Manipulation.md#roundingdate)

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

[**Next Chapter**: Date Comparison](#Date_Comparison.md)