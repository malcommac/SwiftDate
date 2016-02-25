# Design decisions

Decision | Rationale & consequences
----|---
Time zones, locales and calendars are defined by predefined types `TimeZoneName`, `LocaleName` and `CalendarName` respecively | Easy and early definition of these types
Encapsulation of calendar, time zone and locale in a `Region`class | One of the works with a certain location in mind when converting dates. All properties necessary to reproduce a date are now abstracted into a separate class.
We follow the [SWIFT Style Guide](https://github.com/raywenderlich/swift-style-guide) as much as possible|- Generally accepted style makes code accessible to as many programmers as possible.<br>- It is more effective to adopt ideas that have been evaluated by many than to invent an idea of a few.
To produce a new object of class `B` from an object of class `A` we use `a.b()` rather than `B(a)` |Asynchronous or event driven processing starts with the producing object in mind.<br>If an initialiser `A(b)` is required from within the module from reasons of efficiency, it should be declared `internal`.
`date.funcX() == date.inRegion(localRegion).funcX() == date.inRegion().funcX()` | SwiftDate NSDate extensions should be equivalent to DateInRegion 
Just one function should be implemented to achieve a goal.|Avoid confusions on the function to use. Avoid double work.

Much under construction. Not all targets are met yet but we are working on it.
