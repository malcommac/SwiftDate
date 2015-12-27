# Design decisions

Decision | Rationale
----|---
Time zones and calendars are defined by predefined types `TimeZoneName` and `CalendarType`| Easy and early definition of these types
Encapsulation of calendar, time zone and locale in a `Region`class | One ofthe works with a certain location in mind when converting dates. All properties necessary to reproduce a date are now abstracted into a separate class.


