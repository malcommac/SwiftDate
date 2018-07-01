![](./SwiftDate.png)

<a name="index"/>

## Parsing Dates

- [Auto Parsing & Custom Formats](#autoparsing)

Parsing dates is pretty straighforward in SwiftDate; library can parse strings with dates automatically by recognizing one of the most common patterns. Moreover you can provide your own formats or use one of the built-in parsers.
In the following chapter you will learn how to transform a string to a date.

<a name="autoparsing"/>

### Auto Parsing & Custom Formats

The easiest way to transform an input string to a valid date is to use one of the `.toDate()` functions available as `String`'s instance extensions. The purpose of these method is to get the best format can represent the input string and use it to generate a valid `DateInRegion`.

As like other libs like moment.js, SwiftDate has a list of built-in formats it can use in order to obtain valid results.
You can get the list of these formats by calling `SwiftDate.autoFormats`.
The order of this array is important because SwiftDate iterates over this list until a valid date is returned (the order itself allows the lib to reduce the list of false positives).

You can alter this list by adding/removing or replacing the contents of this array.

- `.toDate(_ format: String?, region: Region?)`
- `.toDate(_ formats: [String]?, region: Region?)`

functions takes as input two arguments:

- `format (String|Array)`: it's optional and allows you to set explictly the format (or ordered list of formats) SwiftDate must use to parse the date. Allowed values are listed in Unicode DateTime Table [you can found here](UnicodeTable.md). If omitted SwiftDates attempts to parse the string iterating over the list of auto patterns listed in `SwiftDate.autoFormats`.
- `region (Region)`: describe the region (locale/calendar/timezone) in which the date is expressed. If omitted the default region (`SwiftDate.defaultRegion`) is used istead.

The result of these functions is an optional `DateInRegion` instance (`nil` is returned if parsing fails).

Some examples:

```swift
let _ = "2018-01-01 15:00".toDate()
let _ = "15:40:50".toDate("HH:mm:ss")
let _ = "2015-01-01 at 14".toDate("yyyy-MM-dd 'at' HH", region: rome)

// Support for locale
let itRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
let enRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)

let srcString = "July 15 - 15:30"
// it returns nil because itRegion has Locales.italian
let _ = srcString.toDate(["yyyy-MM-dd","MMM dd '-' HH:mm"], region: itRegion)
// it's okay because enRegion has locale set to english
let _ = srcString.toDate(["yyyy-MM-dd","MMM dd '-' HH:mm"], region: enRegion)
```

> **PERFORMANCES** In order to preserve performances you should pass the `format` parameter if you know the input format.

> **LOCALE PARAMETER** If you use readable unit names (like `MMM` for months) be sure to select the right locale inside the `region` parameter in order to get valid results.

### ISO8601 Parsing
A special note must be made for ISO8601. This format (the extended version and all its variants) may include the timezone information.
If you need to parse an ISO8601 datetime you should therefore use the `.toISODate()` function of `String` in order to get a complete result.

The following function:

`func toISODate(_ options: ISOParser.Options?, region: Region) -> DateInRegion?`

takes 2 arguments:

- `options | ISOParserOptions` allows you to customize some parser attributes: `timeSeparator` (by default is `:`), `calendar` (by default is the gregorian calendar) and the strict parsing behaviour (by default is `false`). Usually you can omit this parameter.
- `region | Region` used to define the region of the date. By default is set to `Region.ISO` (gregorian/gmt/english posix). If parsed string also contains `timezone` it will override the parameter passed by the region.

Examples:

```swift
let date = "2017-08-05T16:04:03+02:00".toISODate(region: Region.ISO)!
// returned date's region.zone is GMT+2 not the default's Region.ISO's GMT0.
// This because value is read from the string itself.
```


[^ Top](#index)