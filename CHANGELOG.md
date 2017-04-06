<p align="center" >
  <img src="https://raw.githubusercontent.com/malcommac/SwiftDate/master/logo.png" width=189px height=191 alt="SwiftDate" title="SwiftDate">
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CI Status](https://travis-ci.org/malcommac/SwiftDate.svg)](https://travis-ci.org/malcommac/SwiftDate) [![Version](https://img.shields.io/cocoapods/v/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![License](https://img.shields.io/cocoapods/l/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![Platform](https://img.shields.io/cocoapods/p/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)

## CHANGELOG

* Version **[4.1.1](#411)**
* Version **[4.1.0](#410)**
* Version **[4.0.14](#4014)**
* Version **[4.0.13](#4013)**
* Version **[4.0.12](#4012)**
* Version **[4.0.11](#4011)**
* Version **[4.0.10](#4010)**
* Version **[4.0.9](#409)**
* Version **[4.0.8](#408)**
* Version **[4.0.7](#407)**
* Version **[4.0.6](#406)**
* Version **[4.0.5](#405)**
* Version **[4.0.4](#404)**
* Version **[4.0.3](#403)**
* Version **[4.0.2](#402)**
* Version **[4.0.0](#400)**

<a name="411" />

## SwiftDate 4.1.1
---
- **Release Date**: 2017/04/06
- **Zipped Version**: [Download 4.1.1](https://github.com/malcommac/SwiftDate/releases/tag/4.1.1)

#### New Features
- [#408](https://github.com/malcommac/SwiftDate/pull/408) `Date` and `DateInRegion` has now two functions to round a date to certain interval (expressed in `seconds` or `minutes`). `DateInRegion` exposes `roundAt()` which directly modify the date itself; `Date`, as immutable object, exposes the same feature in `roundedAt()` function (which return a new `Date` instances).
- [#]() Added Daylight Saving Time functions: `.isDST` in `DateInRegion` (it returns true if the date uses daylight saving time);  `.DSTOffset` in `DateInRegion` (it returns the value (in seconds)  of the daylight saving time offset of the represented date),  `. nextDSTTransitionDate` in `DateInRegion` (it returns the next daylight saving time transition after currently represented date when expressed); `nextDSTTransitionDate()` func in `Date` (it returns the next dst transition date when receiver is expressed in a particular timezone); `DSTOffset()` func in `Date` (it returns the offset of daylight saving time when receiver is expressed in a particular timezone); `isDST()` func in `Date` (it returns if receiver date uses daylight saving time when expressed in a particular timezone).

#### Fixes
- [#](https://github.com/malcommac/SwiftDate/pull/) Several fixes while parsing less common `ISO8601` formats (weeks only w/wo implicit year/month/day).
- [#](https://github.com/malcommac/SwiftDate/pull/) Parsing an `ISO8601` string now results in a `DateInRegion` which contains the correct timezone defined (`Date` instances are now converted automatically to be time-independent).
- [#]() Updated Unit Tests to become compatible with the new APIs changes. All tests now passes.
- [#409](https://github.com/malcommac/SwiftDate/pull/409) Fixed an issue converting a difference between two dates when its more than 24 hours, but less than 48 hours (incorrectly the colloquial values returns 'yesterday')
- [#]() Single framework target in XCode Project (iOS, macOS, tvOS and watchOS)

<a name="410" />

## SwiftDate 4.1.0
---
- **Release Date**: 2017/03/31
- **Zipped Version**: [Download 4.1.0](https://github.com/malcommac/SwiftDate/releases/tag/4.1.0)

#### New Features
- [#402](https://github.com/malcommac/SwiftDate/pull/402) Added Greek localization (thanks to @dimmdesign)
- [#399](https://github.com/malcommac/SwiftDate/pull/399) `colloquialSinceNow` also allows to set `unitsStyle` params to specify the type of values you want to print.
- [#400](https://github.com/malcommac/SwiftDate/pull/400) `DateInRegion` has a class func named `date(formats:fromRegion)` which allows parsing a single string with multiple formats (the first one that succeeds returns the instance of the `DateInRegion`). Also available as `String` extension (with the same name).
- [#223](https://github.com/malcommac/SwiftDate/pull/223) `ISO8601DateTimeFormatter` now recognize the timezone of an ISO string and create a date with the correct value.
- [#407](https://github.com/malcommac/SwiftDate/pull/407) SwiftDate now can parse ISO8601 strings without specifyng the ISO format; it evaluates the best format automatically. Also the parser faster than the previous built one. Since now `.iso8601` parsing format is used only as formatter (from date to string, viceversa any given value is ignored. You are encouraged to use `.iso8601Auto` instead).

	The following ISO8601 variants are supported:

```
YYYYMMDD
YYYY-MM-DD
YYYY-MM
YYYY
YY //century 
```

IMPLIED CENTURY: YY is 00-99

```
YYMMDD
YY-MM-DD
-YYMM
-YY-MM
-YY
```

IMPLIED YEAR

```
--MMDD
--MM-DD
--MM
```

IMPLIED YEAR AND MONTH

```
---DD
```

ORDINAL DATES: DDD IS THE NUMBER OF THE DAY IN THE YEAR (1-366)

```
YYYYDDD
YYYY-DDD
YYDDD
YY-DDD
-DDD
```

WEEK-BASED DATES: ww IS THE NUMBER OF THE WEEK, AND d IS THE NUMBER (1-7) OF THE DAY IN THE WEEK

```
yyyyWwwd
yyyy-Www-d
yyyyWww
yyyy-Www
yyWwwd
yy-Www-d
yyWww
yy-Www
```

YEAR OF THE IMPLIED DECADE

```
-yWwwd
-y-Www-d
-yWww
-y-Www
```

WEEK AND DAY OF IMPLIED YEAR

```
-Wwwd
-Www-d
```

WEEK ONLY OF IMPLIED YEAR

```
-Www
```

DAY ONLY OF IMPLIED WEEK

```
-W-d
```

#### Fixes
- [#405](https://github.com/malcommac/SwiftDate/pull/405) Fixed some translation issues in Swedish (thanks to @deville)
- [#368](https://github.com/malcommac/SwiftDate/pull/368) Deprecated `at(unitsWithValues dict: [Calendar.Component : Int])` in `Date` and `DateInRegion` and replaced with functional `at(values: [Calendar.Component : Int], keep: Set<Calendar.Component>)`
- [#392](https://github.com/malcommac/SwiftDate/pull/392) Fixed an issue with report negative interval when making operation with dates `a` and `b` where `a - b < 0 iff a < b`.
- [#397](https://github.com/malcommac/SwiftDate/pull/397) Fixed an issue with `colloquial` func which report wrong difference of `1 day` when two dates are distant < 24h but in two different days.

<a name="4014" />

## SwiftDate 4.0.14
---
- **Release Date**: 2017/03/29
- **Zipped Version**: [Download 4.0.14](https://github.com/malcommac/SwiftDate/releases/tag/4.0.14)

- [#404](https://github.com/malcommac/SwiftDate/pull/404) Compatibility with Swift 3.1


<a name="4013" />

## SwiftDate 4.0.13
---
- **Release Date**: 2017/02/12
- **Zipped Version**: [Download 4.0.13](https://github.com/malcommac/SwiftDate/releases/tag/4.0.13)

#### New Features
- [#384](https://github.com/malcommac/SwiftDate/pull/384) Added Arabic translation (thanks to @abdualrhmanIO)
- [#356](https://github.com/malcommac/SwiftDate/pull/356) Added a new formatter option called `strict`. Using `strict` instead of `custom` disable heuristics date guessing of the formatter (ie. 1999-02-31 become an invalid date to parse, while with heuristics enabled guessing date 1999-03-03 is returned instead).

<a name="4012" />

## SwiftDate 4.0.12
---
- **Release Date**: 2017/01/30
- **Zipped Version**: [Download 4.0.12](https://github.com/malcommac/SwiftDate/releases/tag/4.0.12)

#### Fixes
- [#372](https://github.com/malcommac/SwiftDate/issues/372) Fix for `Local.collatorIdentifier` (Returns zh-hans-CN and zh-hant-CN) 
- [#374](https://github.com/malcommac/SwiftDate/pull/374) `DateZeroBehavior` options are now public outside the library

#### New Features
- [#379](https://github.com/malcommac/SwiftDate/pull/379) Added Hebrew translation (thanks to @ilandbt)
- [#376](https://github.com/malcommac/SwiftDate/pull/376) Added Swedish translation (thanks to @traneHead)
- [#381](https://github.com/malcommac/SwiftDate/pull/381) Replaced `useImminentInterval` in `DateInRegionFormatter` with a configurable value called `imminentInterval`. With a default value of 5 it fallback to `just now` version. If `nil` fallback is disabled.
- [#380](https://github.com/malcommac/SwiftDate/pull/380) `DateInRegionFormatter` is now able to load custom localization both from `LocaleName` and custom `.strings` files (just set the `formatter.localization = Localization(path: [PATH_TO_YOUR_STRINGS_FILE]`)

<a name="4011" />

## SwiftDate 4.0.11
---
- **Release Date**: 2017/01/08
- **Zipped Version**: [Download 4.0.11](https://github.com/malcommac/SwiftDate/releases/tag/4.0.11)

#### Fixes
- [#370](https://github.com/malcommac/SwiftDate/issues/370) Cannot format colloquial date when a time component value is zero and `allowedComponents` does not contains lower time components (ie. cannot print "today" when set formatter to accept only `allowedComponents = [.day]` and day difference between dates is zero).
- [#371](https://github.com/malcommac/SwiftDate/issues/371) `DateInRegionFormatter` crashes with any non-default `.allowedComponents`.

#### New Features
- [#365](https://github.com/malcommac/SwiftDate/issues/365) Brazilian Portuguese support (thanks to @ipedro)

<a name="4010" />

## SwiftDate 4.0.10
---
- **Release Date**: 2016/12/21
- **Zipped Version**: [Download 4.0.10](https://github.com/malcommac/SwiftDate/releases/tag/4.0.10)

#### Fixes
- [#364](https://github.com/malcommac/SwiftDate/issues/364) Fixes Japanaese translation

<a name="409" />

## SwiftDate 4.0.9
---
- **Release Date**: 2012/12/20
- **Zipped Version**: [Download 4.0.9](https://github.com/malcommac/SwiftDate/releases/tag/4.0.9)

#### New Features
* [#353](https://github.com/malcommac/SwiftDate/issues/353) Timezone, region and locale are now public accessible from Region (read-only)
- [#354](https://github.com/malcommac/SwiftDate/issues/354) Added Vietnamese translation (thanks to @solbadguyky)
- [#355](https://github.com/malcommac/SwiftDate/issues/355) Added Japanese translation (thanks to @bati668)
- [#360](https://github.com/malcommac/SwiftDate/issues/360) Catalan translation

#### Fixes
- [#359](https://github.com/malcommac/SwiftDate/issues/359) Wrong colloquial string ("just now") when gap between two dates are expressed in minutes and the left comparing operand is a future date.
* [#349](https://github.com/malcommac/SwiftDate/issues/349) Fixed an issue with ISO8601Formatter where we need to manually set the locale to "en_US_POSIX" in order to get correct results (ie. in 12/24h cases).
* [#350](https://github.com/malcommac/SwiftDate/issues/350) Fixed relevant time formatting for Danish translation
- [#358](https://github.com/malcommac/SwiftDate/issues/358) Missing German translation strings are now added.
- [#361](https://github.com/malcommac/SwiftDate/issues/361) Minor fixes for unit test reports
- [#362](https://github.com/malcommac/SwiftDate/issues/362) Added tests for iSO8601 formatter with .internetDateTimeExtended.
- [#363](https://github.com/malcommac/SwiftDate/issues/363) Fallback to main language code when language code + region code is not available (ie. "fr-BE" fall in "fr-FR").

<a name="408" />

## SwiftDate 4.0.8
---
- **Release Date**: 2012/12/01
- **Zipped Version**: [Download 4.0.8](https://github.com/malcommac/SwiftDate/releases/tag/4.0.8)

#### New Features
* [#214](https://github.com/malcommac/SwiftDate/issues/214), Added `.next(day:)` both for `Date` and `DateInRegion` to get the next weekday (ie. "next friday from today") after specified date.
* [#310](https://github.com/malcommac/SwiftDate/issues/310) Added static func `.dates(between:and:increment:)` both for `Date` and `DateInRegion` which allows to enumerate dates between two interval with given increment in term of `DateComponents`.
* [#337](https://github.com/malcommac/SwiftDate/issues/337) DateComponents now implements `.in()` func you can use to express an interval (like using `TimeInterval`) in terms of other time units (for example `let x = 120.seconds.in(.minute)` will return 2 minutes).
* [#348](https://github.com/malcommac/SwiftDate/issues/348) `DateComponents` can now be merged using `&&` operator. So if you have `A = 1.hours, 3.minutes, 2.seconds` and `B = 1.year, 40.minutes`, using `let C = A && B` you will get a new `DateComponents` instance with: `C = 1.year, 1.hours, 43.minutes, 2.seconds`.
* [#340](https://github.com/malcommac/SwiftDate/issues/340), [#320](https://github.com/malcommac/SwiftDate/issues/320) Added Spanish support (thanks to @Sepho and @adrimarti).
* [#323](https://github.com/malcommac/SwiftDate/issues/323), Added Korean support (thanks to @KisukPark).
* [#328](https://github.com/malcommac/SwiftDate/issues/328), Added Slovak support (thanks to @beretis).
* [#329](https://github.com/malcommac/SwiftDate/issues/329), Added Danish support (thanks to @emilpedersen).
* [#331](https://github.com/malcommac/SwiftDate/issues/331), Added Czech support (thanks to @rbukovansky).
* [#187](https://github.com/malcommac/SwiftDate/issues/187), Added `.startWeek` (get the first day of the sender's week) and `.endWeek` (get the last day of the sender's week) both for `Date` and `DateInRegion`

#### Fixes:
* [#344](https://github.com/malcommac/SwiftDate/issues/344) `.inDateDefaultRegion()` is also used as standard value for region in `.add()` function of the `Date` object
* [#339](https://github.com/malcommac/SwiftDate/issues/339) Fixed an issue with reverse interval fatal error when subtracting two dates
* [#317](https://github.com/malcommac/SwiftDate/issues/317) Fixed an issue with language transations. Now all translations are specified in term of language+region settings (ie. `en-US` and not only `en`). All translation files were updated to reflect this new behaviour.
* [#346](https://github.com/malcommac/SwiftDate/issues/346) Workaround to fix a rounding problem when comparing two `Date` or `DateInRegion` in terms of `.nanosecond` granularity. Now the comparision result is correct.
* [#315](https://github.com/malcommac/SwiftDate/issues/315), Fixed an issue with `Date().add(components:)` and daylight saving dates.
* [#319](https://github.com/malcommac/SwiftDate/issues/319), Added missing translation for german loc (thanks to @jaweinkauff)

<a name="407" />

## SwiftDate 4.0.7
---
**Release Date**: 2012/12/20
**Zipped Version**: [Download](https://github.com/malcommac/SwiftDate/releases/tag/4.0.7)


* [#306](https://github.com/malcommac/SwiftDate/issues/306) Fixed a date ordering issue with time interval
* [#308](https://github.com/malcommac/SwiftDate/issues/308) Added singular component for `.year,.month,.day,.hour,.minute,.second` time components
* [#309](https://github.com/malcommac/SwiftDate/issues/309) Added Traditional Chinese support (thanks to @rynecheow)
* [#314](https://github.com/malcommac/SwiftDate/issues/314) Restored French translation strings

<a name="406" />

## SwiftDate 4.0.6
---
- **Release Date**: 2012/10/17
- **Zipped Version**: [Download 4.0.8](https://github.com/malcommac/SwiftDate/releases/tag/4.0.6)

* [#303](https://github.com/malcommac/SwiftDate/issues/303) `Date.defaultRegion()` is now set to `Region.Local()` as specified in doc (not `Region.GMT()`)
* [#302](https://github.com/malcommac/SwiftDate/issues/302) Fixed an issue with colloquial dates and future dates; also fixed an issue when reporting colloquial differences expressed in weeks
* [#301](https://github.com/malcommac/SwiftDate/issues/301) Add `.locale` property in `ISO8601DateTimeFormatter`

<a name="405" />

## SwiftDate 4.0.5
---
- **Release Date**: 2012/10/10
- **Zipped Version**: [Download 4.0.5]

* [#284](https://github.com/malcommac/SwiftDate/issues/284) Fixed a crash with .colloquial() function and # weeks evaluation
* [#287](https://github.com/malcommac/SwiftDate/issues/287) Added Simplified Chinese translation (thanks to @codingrhythm)
* [#288](https://github.com/malcommac/SwiftDate/issues/288) Added Indonesian translation (thanks to @suprie)
* [#286](https://github.com/malcommac/SwiftDate/issues/286) Added French translation (thanks to @pierrolivier)
* [#293](https://github.com/malcommac/SwiftDate/issues/293) Added .withInternetDateTimeExtended as options of ISO8601DateTimeFormatter
* [#292](https://github.com/malcommac/SwiftDate/issues/292) .setDefaultRegion and .defaultRegion are now static func/prop of the Date object


<a name="404" />

## SwiftDate 4.0.4
---
- **Release Date**: 2012/10/04
- **Zipped Version**: [Download 4.0.4](https://github.com/malcommac/SwiftDate/releases/tag/4.0.4)

* [#277](https://github.com/malcommac/SwiftDate/issues/277): Remove `throws` from Date.add(components:) in Date+Math.swift 
* [#276](https://github.com/malcommac/SwiftDate/issues/276): Remove Development team from framework 

<a name="403" />

## SwiftDate 4.0.3
---
- **Release Date**: 2012/10/03
- **Zipped Version**: [Download 4.0.3](https://github.com/malcommac/SwiftDate/releases/tag/4.0.3)

Changes:
* [#271](https://github.com/malcommac/SwiftDate/issues/271): Added fallback to english translation when required translation is not available for colloquial functions
* [#112](https://github.com/malcommac/SwiftDate/issues/112): Fixed an issue when optimization level is `-fast`
* [#269](https://github.com/malcommac/SwiftDate/issues/269): Fixed unnecessary strings printed in console when using `.timeComponents()` function
* [#266](https://github.com/malcommac/SwiftDate/issues/266): Removed unnecessary `Region.copy()` function
* [#267](https://github.com/malcommac/SwiftDate/issues/267): `.absoluteDate` is now a public property for `DateInRegion`
* [#268](https://github.com/malcommac/SwiftDate/issues/268): Added new german translation to `SwiftDate.bundle`
* [#272](https://github.com/malcommac/SwiftDate/issues/272): Failed to calculate a colloquial date when diff in seconds = 0. It throw a `.FailedToCalculate` exception.
* [#274](https://github.com/malcommac/SwiftDate/issues/274): Fixed a bug with padding in Time Components formatter. Now SwiftDate uses `DateComponentsFormatter` internally; old timeComponents/timeComponentsSinceNow (in Date and DateInRegion) are now deprecated (there are other functions with the same name which takes a `ComponentsFormatterOptions` struct as input). Also `.string()` function in `TimeInterval` is now replaced by a counterpart which take `ComponentsFormatterOptions` struct.
* [#275](https://github.com/malcommac/SwiftDate/issues/275): `.formatter.useSharedFormatters` in `DateInRegion` is now accessible so, if strictly needed user can user a custom instance of DateTime Formatters per single `DateInRegion`.

<a name="402" />

## SwiftDate 4.0.2
---
- **Release Date**: 2012/09/30
- **Zipped Version**: [Download 4.0.2](https://github.com/malcommac/SwiftDate/releases/tag/4.0.2)

- Minor fix for cocoapods compatibility (SwiftDate.bundle was not copied)

<a name="400" />
### SwiftDate 4.0.0
---
- **Release Date**: 2012/09/29
- **Zipped Version**: [Download 4.0.0](https://github.com/malcommac/SwiftDate/releases/tag/4.0.0)

- Major rewrite, fully compatible with Swift 3.0
- Function names and parameter now fully adopt Swift conventions (*we should make a complete list of changes soon*)
- Various fixes with locale management and timezones
- Web site and complete documentation
- Jazzy support
- Unit tests now compiles under XCode 8 and Swift 3
