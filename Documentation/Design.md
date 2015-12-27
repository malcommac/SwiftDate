# Design decisions

Decision | Rationale & consequences
----|---
Time zones and calendars are defined by predefined types `TimeZoneName` and `CalendarType`| Easy and early definition of these types
Encapsulation of calendar, time zone and locale in a `Region`class | One ofthe works with a certain location in mind when converting dates. All properties necessary to reproduce a date are now abstracted into a separate class.
[To be confirmed](https://github.com/malcommac/SwiftDate/issues/131)<br>We follow the [SWIFT Style Guide](https://github.com/raywenderlich/swift-style-guide) as much as possible|- Generally accepted style makes code accessible to as many programmers as possible.<br>- It is more effective to adopt ideas that have been evaluated by many than to invent an idea of a few.
To produce a new object of class `B` from an object of class `A` we use `a.b()` rather than `B(a)` |Asynchronous or event driven processing starts with the producing object in mind.<br>If an initialiser `A(b)` is required from within the module from reasons of efficiency, it should be declared `internal`.
