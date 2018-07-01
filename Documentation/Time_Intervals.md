![](./SwiftDate.png)

<a name="index"/>

- [**Index**: Table Of Contents](#Index.md)
- [**Prev Chapter**: Parsing Dates](#Parsing_Dates.md)
- [**Next Chapter**: Date Comparison](#Date_Comparison.md)

## Time Intervals

- [Format Interval as String](Time_Intervals.md#format)
- [Express TimeInterval in other Time units](Time_Intervals.md#express)
- [Format Interval as Clock](Time_Intervals.md#clock)

The following methods are part of the `TimeInterval` extension provided by SwiftDate.

<a name="format"/>

### Format Interval as String
Formatting a time interval as string is pretty simple, you just need to call the `.toString()` function of the `TimeInterval`.
It allows you to pick the right formatting options to represent the interval as a valid string.

`func toString(options callback: ((inout ComponentsFormatterOptions) -> Void)? = nil) -> String`

Using a callback function you can configure the formatter as you need.

- `options: ComponentsFormatterOptions`: allows to define the formatting options of the string.

`ComponentsFormatterOptions` is a struct with the following properties:

- `allowsFractionalUnits | Bool`: Fractional units may be used when a value cannot be exactly represented using the available units. For example, if minutes are not allowed, the value “1h 30m” could be formatted as “1.5h”. The default value of this property is false.
- `allowedUnits | NSCalendar.Unit`: Specify the units that can be used in the output. By default `[.year, .month, .weekOfMonth, .day, .hour, .minute, .second]` are used.
- `collapsesLargestUnit | Bool`: A Boolean value indicating whether to collapse the largest unit into smaller units when a certain threshold is met. By default is `false`.
- `maximumUnitCount | Int`: The maximum number of time units to include in the output string. The default value of this property is 0, which does not cause the elimination of any units.
- `zeroFormattingBehavior | DateComponentsFormatter.ZeroFormattingBehavior`: The formatting style for units whose value is 0. By default is `.default`
- `unitsStyle | DateComponentsFormatter.UnitsStyle`: The preferred style for units. By default is `.abbreviated`.

Examples:

```swift
// "2 hours, 5 minutes, 32 seconds"
let _ = (2.hours + 5.minutes + 32.seconds).timeInterval.toString {
  $0.unitsStyle = .full
  $0.collapsesLargestUnit = false
  $0.allowsFractionalUnits = true
}
// "2d 5h"
let _ = (5.hours + 2.days).timeInterval.toString {
  $0.unitsStyle = .abbreviated
}
```

[^ Top](#index)

<a name="express"/>

### Express TimeInterval in other Time units
While SwiftDate allows to carefully evaluate the differences between two dates and express them with the requested time unit (see ["Get Intervals Between Two Dates"](Date_Manipulation.md#interval), sometimes you may need to calculate this value from an absolute - calendar/locale indipendent - value expressed as `TimeInterval`.

The method used to convert a an absolute amount of seconds is `toUnits()`.

`func toUnits(_ units: Set<Calendar.Component>, from refDate: DateInRegion? = nil) -> [Calendar.Component: Int]`

takes two arguments:

- `units | Set<Calendar.Component>`: units to extract
- `refDate | DateInRegion`: starting reference date, `nil` means `now()` in the context of the default region set. If `refDate` is `nil` evaluation is made from `now()` and `now() + interval` in the context of the `SwiftDate.defaultRegion` set.

Example:

```swift

```

[^ Top](#index)

<a name="clock"/>

### Format Interval as Clock
SwiftDate allows to format a `TimeInterval` in the form of a clock or a countdown timer. (ie. `57:00:00`).
To format an interval using this style use `.toClock()` function.

`func toClock(zero: DateComponentsFormatter.ZeroFormattingBehavior)`

takes one argument:

- `zero | DateComponentsFormatter.ZeroFormattingBehavior`: define the representation of the zero values into the destination string. By default is set to `.pad`.

Example:

```swift
let _ = (2.hours + 5.minutes).timeInterval.toClock() // "2:05:00"
let _ = (4.minutes + 50.minutes).timeInterval.toClock(zero: .dropAll) // "54:00"
```

[^ Top](#index)

[**Next Chapter**: Date Comparison](#Date_Comparison.md)