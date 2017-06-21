//
//	SwiftDate, Full featured Swift date library for parsing, validating, manipulating, and formatting dates and timezones.
//	Created by:				Daniele Margutti
//	Main contributors:		Jeroen Houtzager
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.


import Foundation

// MARK: - DateInRegion Components Extension

extension DateInRegion {
	
	
	/// This function is used to extract a particular `Calendar.Component` from a given `DateInRegion`.
	/// Result respect the `Region` in which the date itself is expressed.
	///
	/// - parameter cmp: calendar component to extract (as `Calendar.Component`)
	///
	/// - returns: the value of the component or 0
	internal func value(forComponent cmp: Calendar.Component) -> Int {
		if cmp == .calendar || cmp == .timeZone {
			assertionFailure("You can't get the value of the calendar/timezone component")
		}
		let components = self.region.calendar.dateComponents([cmp], from: self.absoluteDate)
		let value = components.value(for: cmp)
		return value ?? 0
	}
	
	
	/// Extract the `DateComponents` from the `DateInRegion` by respecting the `Region` in which the date is expressed.
	public var components: DateComponents {
		return self.region.calendar.dateComponents(DateComponents.allComponentsSet, from: self.absoluteDate)
	}
	
	
	/// The number of era units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var era: Int {
		return self.value(forComponent: .era)
	}
	
	/// The number of years units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var year: Int {
		return self.value(forComponent: .year)
	}
	
	/// The number of era months for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var month: Int {
		return self.value(forComponent: .month)
	}
	
	/// The number of day units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var day: Int {
		return self.value(forComponent: .day)
	}
	
	/// The number of hour units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var hour: Int {
		return self.value(forComponent: .hour)
	}
	
	
	/// Nearest rounded hour from the date
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var nearestHour: Int {
		let date: DateInRegion = (self + 30.minutes)
		return Int(date.hour)
	}
	
	
	/// The number of minute units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var minute: Int {
		return self.value(forComponent: .minute)
	}
	
	/// The number of second units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var second: Int {
		return self.value(forComponent: .second)
	}
	
	/// The number of nanosecond units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var nanosecond: Int {
		return self.value(forComponent: .nanosecond)
	}
	
	/// The number of week-numbering units for the receiver.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var yearForWeekOfYear: Int {
		return self.value(forComponent: .yearForWeekOfYear)
	}
	
	/// The week date of the year for the receiver
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var weekOfYear: Int {
		return self.value(forComponent: .weekOfYear)
	}
	
	/// The number of weekday units for the receiver
	/// Weekday units are the numbers 1 though n, where n is the number of days in the week.
	/// For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
	///
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var weekday: Int {
		return self.value(forComponent: .weekday)
	}
	
	/// The ordinal number of weekday units for the receiver.
	/// Weekday ordinal units represent the position of the weekday within the next larger calendar
	/// unit , such as the month.
	/// For example, 2 is the weekday ordinal unit for the second Friday of the month.
	///
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var weekdayOrdinal: Int {
		return self.value(forComponent: .weekdayOrdinal)
	}
	
	/// Week day name of the date
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var weekdayName: String {
		return self.formatters.dateFormatter(format: "EEEE").string(from: self.absoluteDate)
	}
	
	/// Weekday short name
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var weekdayShortName: String {
		return self.formatters.dateFormatter(format: "EE").string(from: self.absoluteDate)
	}
	
	/// Number of days into current's date month expressed in current region calendar and locale
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var monthDays: Int {
		let range: Range<Int> = self.region.calendar.range(of: .day, in: .month, for: self.absoluteDate)!
		return (range.upperBound - range.lowerBound)
	}
	
	/// The number of quarter units for the receiver.
	/// - note: there is known bug for quarter component in Calendar object.
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var quarter: Int? {
		return self.value(forComponent: .quarter)
	}
	
	
	/// The week number in the month for the receiver
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var weekOfMonth: Int {
		return self.value(forComponent: .weekOfMonth)
	}
	
	
	/// Month name of the date
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var monthName: String {
		return self.formatters.dateFormatter().monthSymbols[self.month-1]
	}
	
	
	/// Short month name of the date
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var shortMonthName: String {
		return self.formatters.dateFormatter().shortMonthSymbols[self.month-1]
	}
	
	
	/// Boolean value that indicates whether the month is a leap month.
	/// It return `true` if the month is a leap month, `false` otherwise.
	///
	/// - note: This value is interpreted in the context of the calendar with which it is used
	public var leapMonth: Bool {
		let calendar = self.region.calendar
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if calendar.identifier == Calendar.Identifier.gregorian && self.year > 1582 {
			guard let range: Range<Int> = calendar.range(of: .day, in: .month, for: self.absoluteDate) else {
				return false
			}
			return ((range.upperBound - range.lowerBound) == 29)
		}
		// For other calendars:
		return calendar.dateComponents([.day,.month,.year], from: self.absoluteDate).isLeapMonth!
	}
	
	
	/// Boolean value that indicates whether the year is a leap year.
	/// It return `true` if the month is a leap month, `false` otherwise.
	///
	/// - note: This value is interpreted in the context of the calendar with which it is used
	public var leapYear: Bool {
		let calendar = self.region.calendar
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if calendar.identifier == Calendar.Identifier.gregorian {
			var newComponents = self.components
			newComponents.month = 2
			newComponents.day = 10
			let testDate = newComponents.dateInRegion!
			return testDate.leapMonth
		}
		// For other calendars:
		return calendar.dateComponents([.day,.month,.year], from: self.absoluteDate).isLeapMonth!
	}
	
	
	/// Julian day is the continuous count of days since the beginning of the Julian Period used primarily by astronomers.
	public var julianDay: Double {
		let destRegion = Region(tz: TimeZoneName.gmt, cal: CalendarName.gregorian, loc: LocaleName.english)
		let utc = self.toRegion(destRegion)
		
		let year = Double(utc.year)
		let month = Double(utc.month)
		let day = Double(utc.day)
		let hour = Double(utc.hour) + Double(utc.minute)/60.0 + (Double(utc.second)+Double(utc.nanosecond)/1e9)/3600.0
		
		var jd = 367.0*year - floor( 7.0*( year+floor((month+9.0)/12.0))/4.0 )
		jd -= floor( 3.0*(floor( (year+(month-9.0)/7.0)/100.0 ) + 1.0)/4.0 )
		jd += floor(275.0*month/9.0) + day + 1721028.5 + hour/24.0
		
		return jd
	}
	
	/// The Modified Julian Date (MJD) was introduced by the Smithsonian Astrophysical Observatory
	/// in 1957 to record the orbit of Sputnik via an IBM 704 (36-bit machine) and using only 18 bits until August 7, 2576.
	public var modifiedJulianDay: Double {
		return self.julianDay - 2400000.5
	}
	
	/// Get the first day of the week according to the current calendar set
	public var startWeek: DateInRegion {
		return self.startOf(component: .weekOfYear)
	}
	
	/// Get the last day of the week according to the current calendar set
	public var endWeek: DateInRegion {
		return self.endOf(component: .weekOfYear)
	}
	
	/// Returns two `DateInRegion` objects indicating the start and the end of the current weekend.
	///
	/// - Returns: a tuple of two `DateInRegion` objects indicating the start and the end of
	///   the current weekend. If this is unto a weekend, then `nil` is returned.
	///
	public var thisWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		guard self.region.calendar.isDateInWeekend(self.absoluteDate) else {
			return nil
		}
		let date: DateInRegion = (self - 2.days)
		return date.nextWeekend
	}
	
	/// Returns two `DateInRegion` objects indicating the start and the end
	/// of the next weekend after the date.
	///
	/// - Returns: a tuple of two `DateInRegion` objects indicating the
	///   start and the end of the next weekend after the date.
	///
	/// - Note: The weekend returned when the receiver is in a weekend
	///   is the next weekend not the current one.
	///
	public var nextWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		var wkStart: Date = self.absoluteDate
		var tInt: TimeInterval = 0
		let d = self.absoluteDate
		
		let calendar = self.region.calendar
		if calendar.nextWeekend(startingAfter: d, start: &wkStart, interval: &tInt) == false {
			return nil
		}
		
		// Subtract one thousandth of a second to distinguish from Midnigth
		// on the next Monday for the `isEqual()` function of `Date` and `DateInRegion`
		let wkEnd = wkStart.addingTimeInterval(tInt - 0.001)
		
		let startDate = DateInRegion(absoluteDate: wkStart, in: region)
		let endDate = DateInRegion(absoluteDate: wkEnd, in: region)
		return (startDate, endDate)
	}
	
	/// Returns two `DateInRegion` objects indicating the start and the end of
	/// the previous weekend before the date.
	///
	/// - Returns: a tuple of two `DateInRegion` objects indicating the start
	///   and the end of the next weekend previous the date.
	///
	/// - Note: The weekend returned when the receiver is in a weekend is
	///   the previous weekend not the current one.
	///
	public var previousWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		let date: DateInRegion = (self - 9.days)
		return date.nextWeekend
	}
	
	
	/// Returns whether the given date is in today as boolean.
	///
	/// - note: This value is interpreted in the context of the calendar of the receiver
	public var isToday: Bool {
		return self.region.calendar.isDateInToday(self.absoluteDate)
	}
	
	/// Returns whether the given date is in yesterday.
	///
	/// - note: This value is interpreted in the context of the calendar of the receiver
	public var isYesterday: Bool {
		return self.region.calendar.isDateInYesterday(self.absoluteDate)
	}
	
	/// Returns whether the given date is in tomorrow.
	///
	/// - note: This value is interpreted in the context of the calendar of the receiver
	public var isTomorrow: Bool {
		return self.region.calendar.isDateInTomorrow(self.absoluteDate)
	}
	
	/// Returns whether the given date is in the weekend.
	///
	/// - note: This value is interpreted in the context of the calendar of the receiver
	public var isInWeekend: Bool {
		return self.region.calendar.isDateInWeekend(self.absoluteDate)
	}
	
	/// Return true if given date represent a passed date
	public var isInPast: Bool {
		return self.absoluteDate < Date()
	}
	
	/// Return true if given date represent a future date
	public var isInFuture: Bool {
		return self.absoluteDate > Date()
	}
    
    /// Returns whether the given date is in the morning.
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    public var isMorning: Bool {
        let hour = self.region.calendar.component(.hour, from: self.absoluteDate)
        return hour >= 5 && hour < 12
    }
    
    /// Returns whether the given date is in the afternoon.
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    public var isAfternoon: Bool {
        let hour = self.region.calendar.component(.hour, from: self.absoluteDate)
        return hour >= 12 && hour < 17
    }
    
    /// Returns whether the given date is in the evening.
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    public var isEvening: Bool {
        let hour = self.region.calendar.component(.hour, from: self.absoluteDate)
        return hour >= 17 && hour < 21
    }
    
    /// Returns whether the given date is in the night.
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    public var isNight: Bool {
        let hour = self.region.calendar.component(.hour, from: self.absoluteDate)
        return hour >= 21 || hour < 5
    }
	
	/// Returns whether the given date is on the same day as the receiver in the time zone and calendar of the receiver.
	///
	/// - parameter date: a date to compare against
	///
	/// - returns:	a boolean indicating whether the receiver is on the same day as the given date in
	///				the time zone and calendar of the receiver.
	public func isInSameDayOf(date: DateInRegion) -> Bool {
		return self.region.calendar.isDate(self.absoluteDate, inSameDayAs: date.absoluteDate)
	}
	
	
	/// Return the instance representing the first moment date of the given date expressed in the context of the calendar of the receiver
	public var startOfDay: DateInRegion {
		let absoluteDate = self.region.calendar.startOfDay(for: self.absoluteDate)
		return DateInRegion(absoluteDate: absoluteDate, in: self.region)
	}
	
	/// Return the instance representing the last moment date of the given date expressed in the context of the calendar of the receiver
	public var endOfDay: DateInRegion {
		let cal = self.region.calendar
		var dCmps = DateComponents()
		dCmps.day = 1
		let nextDay = cal.startOfDay(for: cal.date(byAdding: dCmps, to: self.absoluteDate)!)
		return DateInRegion(absoluteDate: nextDay.addingTimeInterval(-0.001), in: self.region)
	}
	
	/// Return a new instance of the date plus one month
	public var nextMonth: DateInRegion {
		let refDate = self.startOfDay.absoluteDate
		let nextMonth = self.region.calendar.date(byAdding: .month, value: 1, to: refDate)
		return DateInRegion(absoluteDate: nextMonth!, in: self.region)
	}
	
	/// Return a new instance of the date minus one month
	public var prevMonth: DateInRegion {
		let refDate = self.startOfDay.absoluteDate
		let prevMonth = self.region.calendar.date(byAdding: .month, value: -1, to: refDate)
		return DateInRegion(absoluteDate: prevMonth!, in: self.region)
	}
	
	/// Return the next weekday after today.
	/// For example using now.next(.friday) it will return the first Friday after self represented date.
	///
	/// - Parameter day: weekday you want to get
	/// - Returns: the next weekday after sender date
	public func next(day: WeekDay) -> DateInRegion? {
		var cal = Calendar(identifier: self.region.calendar.identifier)
		cal.firstWeekday = 2 // Sunday = 1, Saturday = 7
		var components = DateComponents()
		components.weekday = day.rawValue
		guard let next = cal.nextDate(after: self.absoluteDate, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents) else {
			return nil
		}
		return DateInRegion(absoluteDate: next, in: self.region)
	}
	
	/// Takes a date unit and returns a date at the start of that unit.
	///
	/// - parameter component: target component
	///
	/// - returns: the date representing that start of that unit
	public func startOf(component: Calendar.Component) -> DateInRegion {
		let absoluteTime = self.region.calendar.rangex(of: component, for: self.absoluteDate)!.start
		return DateInRegion(absoluteDate: absoluteTime, in: self.region)
	}
	
	
	/// Takes a date unit and returns a date at the end of that unit.
	///
	/// - parameter component: target component
	///
	/// - returns: the date representing that end of that unit
	public func endOf(component: Calendar.Component) -> DateInRegion {
		// RangeOfUnit returns the start of the next unit; we will subtract one thousandth of a
		// second
		let startOfNextUnit = self.region.calendar.rangex(of: component, for: self.absoluteDate)!.end
		let endOfThisUnit = Date(timeInterval: -0.001, since: startOfNextUnit)
		return DateInRegion(absoluteDate: endOfThisUnit, in: self.region)
	}
	
	
	/// Time interval since the reference date at 1 January 2001
	/// Return the number of seconds as a `TimeInterval` value.
	public var timeIntervalSinceReferenceDate: TimeInterval {
		return self.absoluteDate.timeIntervalSinceReferenceDate
	}
	
	
	/// Creates and returns a `DateInRegion` object representing a date in the distant past (in terms
	/// of centuries).
	public static var distantFuture: DateInRegion {
		return DateInRegion(absoluteDate: Date.distantFuture)
	}
	
	
	/// Creates and returns a `DateInRegion` object representing a date in the distant future (in
	/// terms of centuries).
	public static var distantPast: DateInRegion {
		return DateInRegion(absoluteDate: Date.distantPast)
	}
	
	
	/// Create a new instance calculated with the given time from self `DateInRegion`
	///
	/// - parameter hour:   the hour value
	/// - parameter minute: the minute value
	/// - parameter second: the second value
	///
	/// - returns: a new `DateInRegion` object calculated at given time; `nil` if date cannot be evaluated
	public func atTime(hour: Int, minute: Int, second: Int) -> DateInRegion? {
		let calendar = self.region.calendar
		let absoluteDate = self.absoluteDate
		guard let newDate = calendar.date(bySettingHour: hour, minute: minute, second: second, of: absoluteDate) else {
			return nil
		}
		return DateInRegion(absoluteDate: newDate, in: self.region)
	}

	
	/// Create a new instance calculated by setting a specific component of a given date to a given value, while trying to keep lower 
	/// components the same.
	///
	/// - parameter unit:  The unit to set with the given value
	/// - parameter value: The value to set for the given calendar unit.
	///
	/// - returns: a new `DateInRegion` object calculated at given unit value
	public func at(unit: Calendar.Component, value: Int) -> DateInRegion? {
		guard let newDate = self.region.calendar.date(bySetting: unit, value: value, of: self.absoluteDate) else {
			return nil
		}
		return DateInRegion(absoluteDate: newDate, in: self.region)
	}
	
	
	/// Create a new instance of the date by keeping passed calendar components and alter
	///
	/// - Parameters:
	///   - values: values to alter in new instance
	///   - keep: values to keep from self instance
	/// - Returns: a new instance of `DateInRegion` with passed altered values
	public func at(values: [Calendar.Component : Int], keep: Set<Calendar.Component>) -> DateInRegion? {
		let calendar = self.region.calendar
		var newComponents = calendar.dateComponents(keep, from: self.absoluteDate)
	
		values.forEach { newComponents.setValue($0.value, for: $0.key) }
		
		guard let calculatedDate = calendar.date(from: newComponents) else {
			return nil
		}
		return DateInRegion(absoluteDate: calculatedDate, in: self.region)

	}
	
	/// Create a new instance calculated by setting a list of components of a given date to given values (components
	/// are evaluated serially - in order), while trying to keep lower components the same.
	///
	/// - parameter dict: a dictionary with `Calendar.Component` and it's value
	///
	/// - throws: throw a `FailedToCalculate` exception.
	///
	/// - returns: a new `DateInRegion` object calculated at given units values
	@available(*, deprecated: 4.1.0, message: "This method has know issues. Use at(values:keep:) instead")
	@discardableResult
	public func at(unitsWithValues dict: [Calendar.Component : Int]) throws -> DateInRegion {
		var calculatedDate = self.absoluteDate
		try DateComponents.allComponents.forEach { component in
			let value = dict[component]
			if value != nil {
				guard let newDate = self.region.calendar.date(bySetting: component, value: value!, of: calculatedDate) else {
					throw DateError.FailedToSetComponent(component)
				}
				calculatedDate = newDate
			}
		}
		return DateInRegion(absoluteDate: calculatedDate, in: self.region)
	}
	
	
	/// Returns a `DateInRegion` object representing a date that is the earliest (old) from a given range
	/// of dates.
	/// The dates are compared in absolute time, i.e. time zones, locales and calendars have no
	/// effect on the comparison.
	///
	/// - parameter list: a list of `DateInRegion` to evaluate
	///
	/// - returns: a `DateInRegion` object representing a date that is the earliest from a given
	///            range of dates.
	public static func oldestDate(_ list: [DateInRegion]) -> DateInRegion {
		return list.oldestDate
	}
	
	
	/// Returns a DateInRegion object representing a date that is the latest (most recent) from a given range of
	/// dates. The dates are compared in absolute time, i.e. time zones, locales and calendars have
	/// no effect on the comparison.
	///
	/// - parameter list: a list of `DateInRegion` to evaluate
	///
	/// - returns: a `DateInRegion` object representing a date that is the latest from a given
	///     range of dates.
	public static func recentDate(_ list: [DateInRegion]) -> DateInRegion {
		return list.recentDate
	}
	
	/// Returns a boolean value that indicates whether the represented date uses daylight saving time.
	public var isDST: Bool {
		return self.region.timeZone.isDaylightSavingTime(for: self.absoluteDate)
	}
	
	/// The current daylight saving time offset of the represented date.
	public var DSTOffset: TimeInterval {
		return self.region.timeZone.daylightSavingTimeOffset(for: self.absoluteDate)
	}
	
	/// The date of the next daylight saving time transition after currently represented date.
	/// Date is reported in the same timezone of the receiver.
	public var nextDSTTransitionDate: DateInRegion? {
		guard let next_transition = self.region.timeZone.nextDaylightSavingTimeTransition(after: self.absoluteDate) else {
			return nil
		}
		return DateInRegion(absoluteDate: next_transition, in: self.region)
	}
}

public extension Array where Element: DateInRegion {
	
	/// Get the latest date from a list
	public var recentDate: DateInRegion {
		var currentMaximum = DateInRegion.distantPast
		self.forEach { cDate in
			if currentMaximum < cDate {
				currentMaximum = cDate
			}
		}
		return currentMaximum
	}
	
	/// Get the earliest date from a list
	public var oldestDate: DateInRegion {
		var currentMinimum = DateInRegion.distantFuture
		self.forEach { cDate in
			if currentMinimum > cDate {
				currentMinimum = cDate
			}
		}
		return currentMinimum
	}
	
}

