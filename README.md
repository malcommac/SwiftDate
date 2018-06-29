<p align="center" >
<img src="Documentation/SwiftDate.png" width=597px alt="SwiftDate" title="SwiftDate">
</p>


SwiftDate is the definitive toolchain to manipulate and display dates and time zones on all Apple platform and even on Linux and Swift Server Side frameworks like Vapor or Kitura.

### What you can do with SwiftDate?

#### 1. Date Parsing
SwiftDate can recognize all the major datetime formats  automatically (ISO8601, RSS, Alt RSS, .NET, SQL, HTTP...) and you can also provide your own formats.
Creating a new date has never been so easy!

```swift
// All default datetime formats (15+) are recognized automatically
let _ = "2010-05-20 15:30:00".toDate()
// You can also provide your own format!
let _ = "2010-05-20 15:30".toDate("yyyy-MM-dd HH:mm")
// All ISO8601 variants are supported too with timezone parsing!
let _ = "2017-09-17T11:59:29+02:00".toISODate()
// RSS, Extended, HTTP, SQL, .NET and all the major variants are supported!
let _ = "19 Nov 2015 22:20:40 +0100".toRSS(alt: true)

```

#### 2. Date Manipulation
Date can be manipulated by adding or removing time components using a natural language; time unit extraction is also easy and includes the support for timezone, calendar and locales!

Manipulation can be done with standard math operators and between dates, time intervals, date components and relevant time units!

```swift
// Math operations support time units
let _ = ("2010-05-20 15:30:00".toDate() + 3.months - 2.days)
let _ = Date() + 3.hours
let _ = date1 + [.year:1, .month:2, .hour:5]
let _ = date1 + date2
// extract single time unit components from date manipulation
let over1Year = (date3 - date2).year > 1
```

#### 3. Date Comparison
SwiftDate include an extensive set of comparison functions; you can compare two dates by granularity, check if a date is an particular day, range and pratically any other comparison you ever need.

Comparison is also available via standard math operators like (`>, >=, <, <=`).

```swift
// Standard math comparison is allowed
let _ = dateA >= dateB || dateC < dateB

// Complex comparisons includes granularity support
let _ = dateA.compare(toDate: dateB, granularity: .hour) == .orderedSame
let _ = dateA.isAfterDate(dateB, orEqual: true, granularity: .month) // > until month granularity
let _ = dateC.isInRange(date: dateA, and: dateB, orEqual: true, granularity: .day) // > until day granularity
let _ = dateA.earlierDate(dateB) // earlier date
let _ = dateA.laterDate(dateB) // later date

// Check if date is close to another with a given precision
let _ = dateA.compareCloseTo(dateB, precision: 1.hours.timeInterval

// Compare for relevant events:
// .isToday, .isYesterday, .isTomorrow, .isWeekend, isNextWeek
// .isSameDay, .isMorning, .isWeekday ...
let _ = date.compare(.isToday)
let _ = date.compare(.isNight)
let _ = date.compare(.isNextWeek)
let _ = date.compare(.isThisMonth)
let _ = date.compare(.startOfWeek)
let _ = date.compare(.isNextYear)
// ...and MORE THAN 30 OTHER COMPARISONS BUILT IN

// Operation in arrays (oldestIn, newestIn, sortedByNewest, sortedByOldest...)
let _ = DateInRegion.oldestIn(list: datesArray)
let _ = DateInRegion.sortedByNewest(list: datesArray)
```

#### 4. Date Creation with Region (Timezone, Calendar & Locale)
You can create new dates from a string, time intervals or using date components. SwiftDate offers a wide set of functions to create and derivate your dates even with random generation!

```swift
// All dates includes timezone, calendar and locales!
// Create from string
let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
let date1 = DateInRegion("2010-01-01 00:00:00", region: rome)!

// Create date from intervals
let _ = DateInRegion(seconds: 39940, region: rome)
let _ = DateInRegion(milliseconds: 5000, region: rome)

// Date from components
let _ = DateInRegion(components: {
	$0.year = 2001
	$0.month = 9
	$0.day = 11
	$0.hour = 12
	$0.minute = 0
}, region: rome)
let _ = DateInRegion(year: 2001, month: 1, day: 5, hour: 23, minute: 30, second: 0, region: rome)

// Random date generation with/without bounds
let _ = DateInRegion.randomDate(region: rome)
let _ = DateInRegion.randomDate(withinDaysBeforeToday: 5)
let _ = DateInRegion.randomDates(count: 50, between: lowerLimitDate, and: upperLimitDate, region: rome)
```

#### 5. Derivated Dates
Date can be also generated starting from other dates; SwiftDate includes an extensive set of functions to generate.
Over 20 different derivated dates can be created easily using `dateAt()` function.

```swift
let _ = DateInRegion().dateAt(.endOfDay) // today at the end of the day
// Over 20 different relevant dates including .startOfDay,
// .endOfDay, .startOfWeek, .tomorrow, .nextWeekday, .nextMonth, .prevYear, .nearestMinute and many others!
let _ = dateA.nextWeekday(.friday) // the next friday after dateA
let _ = (date.dateAt(.startOfMonth) - 3.days)
let _ = dateA.compare(.endOfWeek)
```

#### 6. Components Extraction