//: # SwiftDate
//: Welcome to SwiftDate, the best way to play with Date, Times and TimeZone in Swift. The following playground will introduce you to all APIs currently available into the library.
//: If you need a detailed documentation you can use the official documentation page or looking inside comments into the the source code.
//: Fell free to open a Issue in GitHub if you need help or you want to suggest a new feature.

//: ## Absolute Time
//: Cocoa and CocoaTouch uses `Date` object as central class to manage date and time in `Foundation`. This object encapsulates a moment in time that is internally stored as the number of seconds since `Jan 1, 2011 at 00:00 UTC`. This is what we call Universal Time because it represent the same moment everywhere around the world.
//: You can see absolute time as the moment that someone in the USA has a telephone conversation with someone in Dubai; both have that conversation at the same moment (the absolute time) but the local time will be different due to time zones, different calendars, alphabets or notation methods.
//: If you also need to work with time zone, calendar and locales you need to combine `Date` with three other objects: `TimeZone`, `Calendar` and `Locale`. SwiftDate main focus is to provide a set of functions and constructors which allows to manage all of these object easily and without pain.
//: That's the current absolute datetime:

import UIKit
import SwiftDate

var now = Date()

//: ## `Date` vs `DateInRegion` & `Region`
//: Fundamentally there are two ways to represent a DateTime in SwiftDate: using plain `Date` object to represent an universal time interval, or via `DateInRegion` to represent the same interval in a specified world region (by combining it with particular timezone, locale and calendar attribute).
//: All the functions exposed by the library are equally available both for `Date` and `DateInRegion`.
//: While you may choose to still work with `Date` (or mix and match both), in order to avoid struggling our suggestion is to replace `Date` with `DateInRegion` in your code.
//: `DateInRegion` combines and represent an absolute `Date` in a particular geographic region defined by a `Region`.
//: Each `Region` has three important attributes:
//: - A **TimeZone**: defines in which geographic region the date is expressed in. Time zone objects represent geopolitical regions. Consequently, these objects have names for these regions. Time zone objects also represent a temporal offset, either plus or minus, from Greenwich Mean Time (GMT) and an abbreviation (such as PST for Pacific Standard Time).
//: - A **Calendar**: encapsulate information about systems of reckoning time in which the beginning, length, and divisions of a year are defined. They provide information about the calendar and support for calendrical computations such as determining the range of a given calendrical unit and adding units to a given absolute time.
//: - A **Locale**: encapsulate information about linguistic, cultural, and technological conventions and standards. Examples of information encapsulated by a locale include the symbol used for the decimal separator in numbers and the way dates are formatted.
//: Combining a `Date` in a `Region` you can create a `DateInRegion` instance.
//: The following example represent the date created above in New York timezone (with default Gregorian calendar and US Locale):

let regionNY = Region(tz: TimeZoneName.americaNewYork,
                      cal: CalendarName.gregorian,
                      loc: LocaleName.englishUnitedStates)
let nowInNY = DateInRegion(absoluteDate: now, in: regionNY)

//: As you can see `nowInNY` show the current datetime adjusted to NY timezone.
//: Since now querying and making operations with `nowInNY` includes everything related to the region itself. Don't worry, you can still get the absolute datetime by using `absoluteDate` property.

let absoluteDate = nowInNY.absoluteDate

//: `Region` is a struct; you are encouraged to create your own regions and reeuse them in your code.
//: By default all operations exposed by SwiftDate for `Date` instances (and others where optional region parameter is omitted) uses what we call `Default Region`.
//: `Default Region` is a special region which is initially set to the currently local region (`Region.Local()`) where:
//: - `timezone` is set to the current's device timezone
//: - `calendar` is set to the current's device calendar
//: - `locale` is set to the current's device locale
//: All operations with `Date`, and func where region is optional will use `Default Region` as standard region.
//:
//: Let's print the current datetime in your device's locale region
let currentRegion = Date.defaultRegion
let dateFormat = "yyyy-MM-dd HH:mm"
print(now.string(format: .custom(dateFormat)))

//: Change the region to NY and print it again:
Date.setDefaultRegion(regionNY)
print(now.string(format: .custom(dateFormat)))

//: Did you noticed? Last printed date is adjusted to our new default region, New York.

//: ## Get Date Components
//: The following functions are defined both for `Date` and `DateInRegion` objects. As said above, if not specified all functions exposed for `Date` instances uses the default region while for `DateInRegion` is used the associated region.
//: The examples below are done by querying the `DateInRegion` so all properties and operations are adjusted to `regionNY` region's attributes.

//: Year Component
let n_era = nowInNY.era
let n_year = nowInNY.year
let n_ywy = nowInNY.yearForWeekOfYear
let n_isLeapYear = nowInNY.leapYear

//: Month Component
let n_month = nowInNY.month
let n_monthdays = nowInNY.monthDays
let n_quarter = nowInNY.quarter

let n_monthName = nowInNY.monthName
let n_shortMonthName = nowInNY.shortMonthName
let n_isLeapMonth = nowInNY.leapMonth

let n_prevMonth = nowInNY.prevMonth
let n_nextMonth = nowInNY.nextMonth

//: Day Component
let n_day = nowInNY.day
let n_julianDay = nowInNY.julianDay
let n_modifiedJulianDay = nowInNY.modifiedJulianDay
let n_isYesterday = nowInNY.isYesterday
let n_isToday = nowInNY.isToday
let n_isTomorrow = nowInNY.isTomorrow
let n_startOfTheDay = nowInNY.startOfDay
let n_endOfTheDay = nowInNY.endOfDay

//: Hour Time Component
let n_hour = nowInNY.hour
let n_nhour = nowInNY.nearestHour // nearest hour to the current datetime

//: Minute/Second/Nanosecond Component
let n_minute = nowInNY.minute
let n_seconds = nowInNY.second
let n_nano = nowInNY.nanosecond
let n_isInTheMorning = nowInNY.isMorning
let n_isInTheEvening = nowInNY.isEvening
let n_isInTheAfteroon = nowInNY.isAfternoon
let n_isInTheNight = nowInNY.isNight

//: Week Component
let n_startOfWeek = nowInNY.startWeek
let n_endOfWeek = nowInNY.endWeek

let n_weekOfYear = nowInNY.weekOfYear
let n_weekday = nowInNY.weekday
let n_isTodayInWeekend = nowInNY.isInWeekend
let n_weekOrdinal = nowInNY.weekdayOrdinal
let n_weekdayName = nowInNY.weekdayName
let n_weekMonth = nowInNY.weekOfMonth

//: Weekend Component
let n_prevWeekendRange = nowInNY.previousWeekend
let n_thisWeekendRange = nowInNY.thisWeekend
let n_nextWeekendRange = nowInNY.nextWeekend

//: Others
let n_isPastDateTime = nowInNY.isInPast
let n_isFutureDateTime = nowInNY.isInFuture
let n_intervalSinceRefDate = nowInNY.timeIntervalSinceReferenceDate
let n_distantFuture = Date.distantFuture
let n_distantPast = Date.distantPast

//: Start/End Of Calendar Components
let n_startOfCurrentHour = nowInNY.startOf(component: .hour)
let n_endOfCurrentMinute = nowInNY.endOf(component: .minute)
let n_firstDayOfCurrentMonth = nowInNY.startOf(component: .month)

// Adjust date to specified time
let n_adjustedTime = nowInNY.atTime(hour: 08, minute: 00, second: 20)


