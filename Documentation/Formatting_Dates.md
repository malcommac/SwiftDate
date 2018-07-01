![](./SwiftDate.png)

<a name="index"/>

- [**Index**: Table Of Contents](#Index.md)
- [**Prev Chapter**: Parsing Dates](#Parsing_Dates.md)
- [**Next Chapter**: Date Comparison](#Date_Comparison.md)

## Date Formatting (to String)
Formatting dates is really easy with SwiftDate. All the major formats are supported and are really easy to configure.

- [To Custom Formatted String](Compare_Dates#customformatted)
- [To ISO Formatted String](Compare_Dates#isoformatted)

<a name="customformatted"/>

### To Custom Formatted String
If you need to format a `Date` or `DateInRegion` in a String using a custom format you need to use `toFormat(_:locale:)` function.

`func toFormat(_ format: String, locale: LocaleConvertible?) -> String`

it takes two arguments:

- `format | String`: the format of the string. It's defined by the Unicode DateTime format specs you [can found here](UnicodeTable.md).
- `locale | LocaleConvertible?`: Set a non nil value to force the formatter to use a different locale than the one assigned to the date itself (from date's `region.locale` property). Leave it `nil` to use the one assigned by the region itself (or, for plain `Date` instances the one set as `SwiftDate.defaultRegion`).

Example:

```swift
let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
let date = DateInRegion(year: 2015, month: 1, day: 15, hour: 20, minute: 00, second: 5, nanosecond: 0, region: rome)

// Even if date's locale is set to `italin` we can still
// print in a different language by passing a non nil locale
// to the function.
let formattedString = date.toFormat("MMM dd yyyy", locale: Locales.english) // "Jan 15 2015"
```
[^ Top](#index)

<a name="isoformatted"/>

### To ISO Formatted String
SwiftDate allows to print date instances using a configurable ISO8601 formatter which is also compatible with older version of iOS where the Apple's own class is not available.

To use the ISO formatter call `.toISO()` function

`func toISO(_ options: ISOFormatter.Options?) -> String`

takes one optional argument:

- `options | ISOFormatter.Options`: allows to customize the format of the output string by defining which kind of date must be into the final string (if you omit it `withInternetDateTime` is used).

`ISOFormatter.Options` defines an `OptionSet` with the following values:

- `withYear`: The date representation includes the year. The format for year is inferred based on the other specified options. If `withWeekOfYear` is specified, `YYYY` is used. Otherwise, `yyyy` is used.
- `withMonth`: The date representation includes the month. The format for month is `MM`.
- `withWeekOfYear`: The date representation includes the week of the year. The format for week of year is `ww`, including the `W` prefix.
- `withDay`:  The date representation includes the day. The format for day is inferred based on provided options: If `withMonth` is specified, `dd` is used. If `withWeekOfYear` is specified, `ee` is used. Otherwise, `DDD` is used.
- `withTime`: The date representation includes the time. The format for time is `HH:mm:ss`.
- `withTimeZone`: The date representation includes the timezone. The format for timezone is `ZZZZZ`.
- `withSpaceBetweenDateAndTime`: The date representation uses a space (` `) instead of `T` between the date and time.
- `withDashSeparatorInDate`: The date representation uses the dash separator (`-`) in the date.
- `withFullDate`: The date representation uses the colon separator (`:`) in the time.
- `withFullTime`: The date representation includes the hour, minute, and second.
- `withInternetDateTime`: The format used for internet date times, according to the RFC 3339 standard. Equivalent to specifying `withFullDate`, `withFullTime`, `withDashSeparatorInDate`,
 `withColonSeparatorInTime`, and `withColonSeparatorInTimeZone`.
- `withInternetDateTimeExtended`: The format used for internet date times; it's similar to `.withInternetDateTime` but include milliseconds (`yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ`).

Examples:

```swift
let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
let date = DateInRegion("2017-07-22 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!

// ISO Formatting
let _ = date.toISO() // "2017-07-22T00:00:00+02:00"
let _ = date.toISO([.withFullDate]) // "2017-07-22"
let _ = date.toISO([.withFullDate, .withFullTime, .withDashSeparatorInDate, .withSpaceBetweenDateAndTime]) // "2017-07-22 00:00:00+02:00"
```



[^ Top](#index)

[**Next Chapter**: Date Comparison](#Date_Comparison.md)