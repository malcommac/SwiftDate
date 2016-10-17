<p align="center" >
  <img src="https://raw.githubusercontent.com/malcommac/SwiftDate/master/swiftdate-4-logo.png" width=189px height=191 alt="SwiftDate" title="SwiftDate">
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CI Status](https://travis-ci.org/malcommac/SwiftDate.svg)](https://travis-ci.org/malcommac/SwiftDate) [![Version](https://img.shields.io/cocoapods/v/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![License](https://img.shields.io/cocoapods/l/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate) [![Platform](https://img.shields.io/cocoapods/p/SwiftDate.svg?style=flat)](http://cocoadocs.org/docsets/SwiftDate)

## CHANGELOG

### SwiftDate 4.0.6
Released on: Mon Oct 17, 2016, [Download](https://github.com/malcommac/SwiftDate/releases/tag/4.0.6)
* [#303](https://github.com/malcommac/SwiftDate/issues/303) `Date.defaultRegion()` is now set to `Region.Local()` as specified in doc (not `Region.GMT()`)
* [#302](https://github.com/malcommac/SwiftDate/issues/302) Fixed an issue with colloquial dates and future dates; also fixed an issue when reporting colloquial differences expressed in weeks
* [#301](https://github.com/malcommac/SwiftDate/issues/301) Add `.locale` property in `ISO8601DateTimeFormatter`

### SwiftDate 4.0.5
Released on: Mon Oct 10, 2016, [Download](https://github.com/malcommac/SwiftDate/releases/tag/4.0.5)
* [#284](https://github.com/malcommac/SwiftDate/issues/284) Fixed a crash with .colloquial() function and # weeks evaluation
* [#287](https://github.com/malcommac/SwiftDate/issues/287) Added Simplified Chinese translation (thanks to @codingrhythm)
* [#288](https://github.com/malcommac/SwiftDate/issues/288) Added Indonesian translation (thanks to @suprie)
* [#286](https://github.com/malcommac/SwiftDate/issues/286) Added French translation (thanks to @pierrolivier)
* [#293](https://github.com/malcommac/SwiftDate/issues/293) Added .withInternetDateTimeExtended as options of ISO8601DateTimeFormatter
* [#292](https://github.com/malcommac/SwiftDate/issues/292) .setDefaultRegion and .defaultRegion are now static func/prop of the Date object


### SwiftDate 4.0.4
Released on: Tue Oct 4, 2016, [Download](https://github.com/malcommac/SwiftDate/releases/tag/4.0.4)
* [#277](https://github.com/malcommac/SwiftDate/issues/277): Remove `throws` from Date.add(components:) in Date+Math.swift 
* [#276](https://github.com/malcommac/SwiftDate/issues/276): Remove Development team from framework 

### SwiftDate 4.0.3
Released on: Mon Oct 3, 2016, [Download](https://github.com/malcommac/SwiftDate/releases/tag/4.0.3)

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

### SwiftDate 4.0.2
Released on: 2016-09-30, [Download](https://github.com/malcommac/SwiftDate/releases/tag/4.0.2)

Changes:
- Minor fix for cocoapods compatibility (SwiftDate.bundle was not copied)

### SwiftDate 4.0.0
Released on: 2016-09-29, [Download](https://github.com/malcommac/SwiftDate/releases/tag/4.0.0)

Changes:
- Major rewrite, fully compatible with Swift 3.0
- Function names and parameter now fully adopt Swift conventions (*we should make a complete list of changes soon*)
- Various fixes with locale management and timezones
- Web site and complete documentation
- Jazzy support
- Unit tests now compiles under XCode 8 and Swift 3
