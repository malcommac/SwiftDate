![](./SwiftDate.png)

<a name="introduction"/>

## Introduction

- [How `Date` works in Cocoa](#how_date_works)
- [`Region` and `DateInRegion`](#region_dateinregion)

<a name="how_date_works"/>

### How `Date` works in Cocoa

Generally when you talk about dates you are brought to think about a particular instance of time in a particular location of the world. However, in order to get a fully generic implementationn Apple made `Date` fully indipendent from any particular geographic location, calendar or locale.

A plain `Date` object just represent an absolute value: in fact it count the number of seconds elapsed since January 1, 2001.

This is what we call **Universal Time because it represent the same moment everywhere around the world**.

You can see absolute time as the moment that someone in the USA has a telephone conversation with someone in Dubai; both have that conversation at the same moment (the absolute time) but the local time will be different due to time zones, different calendars, alphabets or notation methods.

```swift
let now = Date()
print("\(now.timeIntervalSinceReferenceDate) seconds elapsed since Jan 1, 2001 @ 00:00 UTC")
```

However, we often need to represent a date in a more specific context: **a particular place in the world, printing them using the rules of a specified locale and more**.

In order to accomplish it we need to introduce several other objects: a `Calendar`, a `TimeZone` and a `Locale`; combining these attributes we're finally ready to provide a **representation** of the date into the real world.

SwiftDate allows you to parse, create, manipulate and inspect dates in an easy and more natural way than Cocoa itself.

[^ Top](#introduction)

<a name="region_dateinregion"/>

### `Region` & `DateInRegion`

In order to simplify the date management in a specific context SwiftDate introduces two simple structs:

- `Region` is a struct which define a region in the world (`TimeZone`) a language (`Locale`) and reference calendar (`Calendar`).
- `DateInRegion` represent an absolute date in a specific region. When you work with this object all components are evaluated in the context of the region in which the object was created.

