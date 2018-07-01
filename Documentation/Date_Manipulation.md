![](./SwiftDate.png)

<a name="index"/>

- [**Index**: Table Of Contents](#Index.md)
- [**Prev Chapter**: Parsing Dates](#Parsing_Dates.md)
- [**Next Chapter**: Date Comparison](#Date_Comparison.md)

## Date Manipulation

- [Time Units as TimeInterval](Date_Manipulation.md#timeunits)

Dates can be manipulated as you need by using classic math operators and readable time units.

<a name="timeunits"/>

### Time Units as TimeInterval

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
		
[^ Top](#index)

[**Next Chapter**: Date Comparison](#Date_Comparison.md)