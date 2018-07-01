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

- `options | ISOFormatter.Options`

[^ Top](#index)

[**Next Chapter**: Date Comparison](#Date_Comparison.md)