![](./SwiftDate.png)

<a name="index"/>

- [**Index**: Table Of Contents](#Index.md)
- [**Prev Chapter**: Parsing Dates](#Parsing_Dates.md)
- [**Next Chapter**: Date Comparison](#Date_Comparison.md)

## Compare Dates
Date comparison is available both via simple math operators (`<,>,<=,>=`) or throught several other functions which allows a more fined control of the comparison.

- [Standard Comparison](Compare_Dates#standard)
- [Extended Comparison with Presets (`isToday, isTomorrow, isSameWeek, isNextYear` etc.)](Compare_Dates#extended)
- [Comparison with Granularity](Compare_Dates#granularity)
- [Check if Date is Close to Another](Compare_Dates#close)
- [Check if Date is Inside a Range](Compare_Dates#range)

<a name="standard"/>

### Standard Comparison
Standard comparison between dates can be done using the classic `.compare()` functions or mathematical operators.
SwiftDate also introduces two additional convenience methods:

- `isBeforeDate(_:orEqual:granularity:)` Compares whether the receiver is before/before equal `date` based on their components down to a given unit granularity.
- `isAfterDate(_:orEqual:granularity:)` Compares whether the receiver is after `date` based on their components down to a given unit granularity.

<a name="extended"/>

### Extended Comparison with Presets (`isToday, isTomorrow, isSameWeek, isNextYear` etc.)
While standard comparison between two dates can be done by using mathematical operators, extended comparison is made via `.compare()` method which offer more than 25+ different types of relevant comparisons.

`func compare(_ compareType: DateComparisonType) -> Bool`

takes only one argument:

- `compareType | DateComparisonType`: the type of comparison to make

`DateComparisonType` is an enum which defines the type of comparison to make. This is the actual list of compare functions you can use:

**For Days**

- `isToday`
- `isTomorrow`
- `isYesterday`
- `isSameDay(_ : DateRepresentable)`

**For Weeks**

- `isThisWeek`
- `isNextWeek`
- `isLastWeek`
- `isSameWeek(_: DateRepresentable)`

**For Months**

- `isThisMonth`
- `isNextMonth`
- `isLastMonth`
- `isSameMonth(_: DateRepresentable)`

**For Years**

- `isThisYear`
- `isNextYear`
- `isLastYear`
- `isSameYear(_: DateRepresentable)`

**For Relative Time**

- `isInTheFuture`
- `isInThePast`
- `isEarlier(than: DateRepresentable)`
- `isLater(than: DateRepresentable)`
- `isWeekday`
- `isWeekend`

**For Day Time**

- `isMorning`
- `isAfternoon`
- `isEvening`
- `isNight`

**For TZ**

- `isInDST`

> **CONTRIBUTE!** Have you a new related date you want to be part of this list? Create a [new PR](https://github.com/malcommac/SwiftDate/compare) with the code and unit tests and we'll be happy to add it to the list!

Examples:

```swift
// return false
let _ = DateInRegion().dateAt(.endOfDay).compare(.isTomorrow)
// return true
let _ = DateInRegion() + 7.days).compare(.isNextWeek)
// return true
let _ = DateInRegion().dateAt(.startOfWeek) - 1.days).compare(.isLastWeek)
```

<a name="granularity"/>

### Comparison with Granularity
A more fined control for dates comparison can be obtained using the `.compare(toDate:granularity:)` function which offer to returns a `ComparisonResult` value that indicates the ordering of two given dates based on their components down to a given unit granularity.

`func compare(toDate refDate: DateInRegion, granularity: Calendar.Component) -> ComparisonResult`

takes two arguments:

- `refDate | DateInRegion`: date to compare against to.
- `granularity | Calendar.Component`: The smallest unit that must, along with all larger units, be less for the given dates

Example:

```swift

```

[^ Top](#index)

<a name="close"/>

### Check if Date is Close to Another
Decides whether a Date is "close by" another one passed in parameter, where "Being close" is measured using a precision argument which is initialized a 300 seconds (5 minutes) or a specified interval.

The function is called `.compareCloseTo(_:precision:)` and takes two arguments:

- `refDate | DateInRegion` reference date compare against to
- `precision | TimeInterval` The precision of the comparison.

Examples:

```swift
let date = DateInRegion("2015-01-01 04:00:00", format: dateFormat, region: regionRome)!
let refDate = DateInRegion("2015-01-01 00:00:00", format: dateFormat, region: regionRome)!
// return true because prevision is set to 5 hours and date differs for only 4 hours
let _ = dateC.compareCloseTo(refDate, precision: 5.hours.timeInterval)

```

<a name="range"/>

### Check if Date is Inside a Range
Using `.isInRange()` function you can check if a given date is inside the range between two dates.

`func isInRange(date startDate: Date, and endDate: Date, orEqual: Bool = false, granularity: Calendar.Component = .nanosecond) -> Bool`

takes 4 arguments:

- `startDate`: the lower bound limit of the range
- `endDate`: the upper bound limit of the range
- `orEqualt`: true to also validate the equality
- `granularity`: smallest unit that must, along with all larger units, be greater for the given dates

Example:

```swift
let lowerBound = DateInRegion("2018-05-31 23:00:00", format: dateFormat, region: regionRome)!
let upperBound = DateInRegion("2018-06-01 01:00:00", format: dateFormat, region: regionRome)!

let testDate = DateInRegion("2018-06-01 00:02:00", format: dateFormat, region: regionRome)!
// return true, date is inside the hour granularity
let _ = testDate.isInRange(date: lowerBound, and: upperBound, orEqual: true, granularity: .hour)
```


[^ Top](#index)

[**Next Chapter**: Date Comparison](#Date_Comparison.md)