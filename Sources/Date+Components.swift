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

/// This is the default region set. It will be set automatically at each startup as the local device's region
internal var DateDefaultRegion: Region = Region.Local()

// MARK: - Date Extension to work with date components

public extension Date {
	
	/// Define a default region to use when you work with components and function of SwiftDate
	/// and `Date` objects. Default region is set automatically at runtime to `Region.Local()` which defines
	/// a region identified by the device's current `TimeZone` (not updating), `Calendar` (not updating)
	/// and `Locale` (not updating).
	///
	/// - parameter region: region to set. If nil is passed default region is set to Region.Local()
	public static func setDefaultRegion(_ region: Region?) {
		DateDefaultRegion = region ?? Region.Local()
	}
	
	/// Return the default region set.
	///
	/// - returns: region set; if not changed is set to `Region.Local()`
	public static var defaultRegion: Region {
		return DateDefaultRegion
	}
	
	/// Create a DateInRegion instance from given date expressing it in default region (locale+timezone+calendar)
	///
	/// - returns: a new DateInRegion object
	internal func inDateDefaultRegion() -> DateInRegion {
		return self.inRegion(region: DateDefaultRegion)
	}
	
	/// The number of era units for the receiver expressed in the context of `defaultRegion`.
	public var era: Int {
		return self.inDateDefaultRegion().era
	}

	/// The number of year units for the receiver expressed in the context of `defaultRegion`.
	public var year: Int {
		return self.inDateDefaultRegion().year
	}
	
	/// The number of month units for the receiver expressed in the context of `defaultRegion`.
	public var month: Int {
		return self.inDateDefaultRegion().month
	}
	
	/// The number of day units for the receiver expressed in the context of `defaultRegion`.
	public var day: Int {
		return self.inDateDefaultRegion().day
	}
	
	/// The number of hour units for the receiver expressed in the context of `defaultRegion`.
	public var hour: Int {
		return self.inDateDefaultRegion().hour
	}
	
	/// Nearest rounded hour from the date expressed in the context of `defaultRegion`.
	public var nearestHour: Int {
		return self.inDateDefaultRegion().nearestHour
	}
	
	/// The number of minute units for the receiver expressed in the context of `defaultRegion`.
	public var minute: Int {
		return self.inDateDefaultRegion().minute
	}
	
	/// The number of second units for the receiver expressed in the context of `defaultRegion`.
	public var second: Int {
		return self.inDateDefaultRegion().second
	}
	
	/// The number of nanosecond units for the receiver expressed in the context of `defaultRegion`.
	public var nanosecond: Int {
		return self.inDateDefaultRegion().nanosecond
	}
	
	/// The number of week-numbering units for the receiver expressed in the context of `defaultRegion`.
	public var yearForWeekOfYear: Int {
		return self.inDateDefaultRegion().yearForWeekOfYear
	}
	
	/// The week date of the year for the receiver expressed in the context of `defaultRegion`.
	public var weekOfYear: Int {
		return self.inDateDefaultRegion().weekOfYear
	}
	
	/// The number of weekday units for the receiver expressed in the context of `defaultRegion`.
	public var weekday: Int {
		return self.inDateDefaultRegion().weekday
	}
	
	/// The ordinal number of weekday units for the receiver expressed in the context of `defaultRegion`.
	public var weekdayOrdinal: Int {
		return self.inDateDefaultRegion().weekdayOrdinal
	}
	
	/// Week day name of the date expressed in the context of `defaultRegion`.
	public var weekdayName: String {
		return self.inDateDefaultRegion().weekdayName
	}
	
	/// Weekday short name
	/// - note: This value is interpreted in the context of the calendar and timezone with which it is used
	public var weekdayShortName: String {
		return self.inDateDefaultRegion().weekdayShortName
	}
	
	/// Number of days into current's date month expressed in the context of `defaultRegion`.
	public var monthDays: Int {
		return self.inDateDefaultRegion().monthDays
	}
	
	/// he week number in the month expressed in the context of `defaultRegion`.
	public var weekOfMonth: Int {
		return self.inDateDefaultRegion().weekOfMonth
	}
	
	/// Month name of the date expressed in the context of `defaultRegion`.
	public var monthName: String {
		return self.inDateDefaultRegion().monthName
	}
	
	/// Short month name of the date expressed in the context of `defaultRegion`.
	public var shortMonthName: String {
		return self.inDateDefaultRegion().shortMonthName
	}
	
	/// Boolean value that indicates whether the month is a leap month.
	/// Calculation is made in the context of `defaultRegion`.
	public var leapMonth: Bool {
		return self.inDateDefaultRegion().leapMonth
	}
	
	/// Boolean value that indicates whether the year is a leap year.
	/// Calculation is made in the context of `defaultRegion`.
	public var leapYear: Bool {
		return self.inDateDefaultRegion().leapYear
	}
	
	/// Julian day is the continuous count of days since the beginning of the Julian Period used primarily by astronomers.
	/// Calculation is made in the context of `defaultRegion`.
	public var julianDay: Double {
		return self.inDateDefaultRegion().julianDay
	}
	
	/// The Modified Julian Date (MJD) was introduced by the Smithsonian Astrophysical Observatory
	/// in 1957 to record the orbit of Sputnik via an IBM 704 (36-bit machine) and using only 18 bits until August 7, 2576.
	/// Calculation is made in the context of `defaultRegion`.
	public var modifiedJulianDay: Double {
		return self.inDateDefaultRegion().modifiedJulianDay
	}
	
	/// Return the next weekday after today.
	/// For example using now.next(.friday) it will return the first Friday after self represented date.
	///
	/// - Parameter day: weekday you want to get
	/// - Returns: the next weekday after sender date
	public func next(day: WeekDay) -> Date? {
		return self.inDateDefaultRegion().next(day: day)?.absoluteDate
	}
	
	/// Get the first day of the week according to the current calendar set
	public var startWeek: Date {
		return self.startOf(component: .weekOfYear)
	}
	
	/// Get the last day of the week according to the current calendar set
	public var endWeek: Date {
		return self.endOf(component: .weekOfYear)
	}
	
	/// Returns two `DateInRegion` objects indicating the start and the end of the current weekend.
	/// Calculation is made in the context of `defaultRegion`.
	public var thisWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		return self.inDateDefaultRegion().thisWeekend
	}
	
	/// Returns two `DateInRegion` objects indicating the start and the end
	/// of the next weekend after the date.
	/// Calculation is made in the context of `defaultRegion`.
	public var nextWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		return self.inDateDefaultRegion().nextWeekend
	}
	
	/// Returns two `DateInRegion` objects indicating the start and the end of
	/// the previous weekend before the date.
	/// Calculation is made in the context of `defaultRegion`.
	public var previousWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		return self.inDateDefaultRegion().previousWeekend
	}
	
	/// Returns whether the given date is in today as boolean.
	/// Calculation is made in the context of `defaultRegion`.
	public var isToday: Bool {
		return self.inDateDefaultRegion().isToday
	}
	
	/// Returns whether the given date is in yesterday.
	/// Calculation is made in the context of `defaultRegion`.
	public var isYesterday: Bool {
		return self.inDateDefaultRegion().isYesterday
	}
	
	/// Returns whether the given date is in tomorrow.
	/// Calculation is made in the context of `defaultRegion`.
	public var isTomorrow: Bool {
		return self.inDateDefaultRegion().isTomorrow
	}
	
	/// Returns whether the given date is in the weekend.
	/// Calculation is made in the context of `defaultRegion`.
	public var isInWeekend: Bool {
		return self.inDateDefaultRegion().isInWeekend
	}
	
	/// Return true if given date represent a passed date
	/// Calculation is made in the context of `defaultRegion`.
	public var isInPast: Bool {
		return self.inDateDefaultRegion().isInPast
	}
	
	/// Return true if given date represent a future date
	/// Calculation is made in the context of `defaultRegion`.
	public var isInFuture: Bool {
		return self.inDateDefaultRegion().isInFuture
    }
    
    /// Returns whether the given date is in the morning.
    /// Calculation is made in the context of `defaultRegion`.
    public var isMorning: Bool {
        return self.inDateDefaultRegion().isMorning
    }
    
    /// Returns whether the given date is in the afternoon.
    /// Calculation is made in the context of `defaultRegion`.
    public var isAfternoon: Bool {
        return self.inDateDefaultRegion().isAfternoon
    }
    
    /// Returns whether the given date is in the evening.
    /// Calculation is made in the context of `defaultRegion`.
    public var isEvening: Bool {
        return self.inDateDefaultRegion().isEvening
    }
    
    /// Returns whether the given date is in the night.
    /// Calculation is made in the context of `defaultRegion`.
    public var isNight: Bool {
        return self.inDateDefaultRegion().isNight
    }
	
	/// Returns whether the given date is on the same day as the receiver in the time zone and calendar of the receiver.
	/// Calculation is made in the context of `defaultRegion`.
	///
	/// - parameter date: a date to compare against
	///
	/// - returns: a boolean indicating whether the receiver is on the same day as the given date in
	///				the time zone and calendar of the receiver.
	public func isInSameDayOf(date: Date) -> Bool {
		return self.inDateDefaultRegion().isInSameDayOf(date: date.inDateDefaultRegion())
	}
	
	/// Return the instance representing the first moment date of the given date expressed in the context of
	/// Calculation is made in the context of `defaultRegion`.
	public var startOfDay: Date {
		return self.inDateDefaultRegion().startOfDay.absoluteDate
	}
	
	/// Return the instance representing the last moment date of the given date expressed in the context of
	/// Calculation is made in the context of `defaultRegion`.
	public var endOfDay: Date {
		return self.inDateDefaultRegion().endOfDay.absoluteDate
	}
	
	/// Return a new instance of the date plus one month
	/// Calculation is made in the context of `defaultRegion`.
	public var nextMonth: Date {
		return self.inDateDefaultRegion().nextMonth.absoluteDate
	}
	
	/// Return a new instance of the date minus one month
	/// Calculation is made in the context of `defaultRegion`.
	public var prevMonth: Date {
		return self.inDateDefaultRegion().prevMonth.absoluteDate
	}
	
	/// Takes a date unit and returns a date at the start of that unit.
	/// Calculation is made in the context of `defaultRegion`.
	///
	/// - parameter component: target component
	///
	/// - returns: the `Date` representing that start of that unit
	public func startOf(component: Calendar.Component) -> Date {
		return self.inDateDefaultRegion().startOf(component: component).absoluteDate
	}
	
	/// Takes a date unit and returns a date at the end of that unit.
	/// Calculation is made in the context of `defaultRegion`.
	///
	/// - parameter component: target component
	///
	/// - returns: the `Date` representing that end of that unit
	public func endOf(component: Calendar.Component) -> Date {
		return self.inDateDefaultRegion().endOf(component: component).absoluteDate
	}
	
	/// Create a new instance calculated with the given time from self
	///
	/// - parameter hour:   the hour value
	/// - parameter minute: the minute value
	/// - parameter second: the second value
	///
	/// - returns: a new `Date` object calculated at given time
	public func atTime(hour: Int, minute: Int, second: Int) -> Date? {
		return self.inDateDefaultRegion().atTime(hour: hour, minute: minute, second: second)?.absoluteDate
	}
	
	/// Create a new instance calculated by setting a specific component of a given date to a given value, while trying to keep lower
	/// components the same.
	///
	/// - parameter unit:  The unit to set with the given value
	/// - parameter value: The value to set for the given calendar unit.
	///
	/// - returns: a new `Date` object calculated at given unit value
	public func at(unit: Calendar.Component, value: Int) -> Date? {
		return self.inDateDefaultRegion().at(unit: unit, value: value)?.absoluteDate
	}
	
	/// Create a new instance calculated by setting a list of components of a given date to given values (components
	/// are evaluated serially - in order), while trying to keep lower components the same.
	///
	/// - parameter dict: a dictionary with `Calendar.Component` and it's value
	///
	/// - throws: throw a `FailedToCalculate` exception.
	///
	/// - returns: a new `Date` object calculated at given units values
	@available(*, deprecated: 4.1.0, message: "This method has know issues. Use at(values:keep:) instead")
	public func at(unitsWithValues dict: [Calendar.Component : Int]) throws -> Date {
		return try self.inDateDefaultRegion().at(unitsWithValues: dict).absoluteDate
	}
	
	/// Create a new instance of the date by keeping passed calendar components and alter
	///
	/// - Parameters:
	///   - values: values to alter in new instance
	///   - keep: values to keep from self instance
	/// - Returns: a new instance of `DateInRegion` with passed altered values
	public func at(values: [Calendar.Component : Int], keep: Set<Calendar.Component>) -> Date? {
		return self.inDateDefaultRegion().at(values: values, keep: keep)?.absoluteDate
	}
	
	/// Returns a `Date` object representing a date that is the earliest (old) from a given range
	/// of dates.
	/// The dates are compared in absolute time, i.e. time zones, locales and calendars have no
	/// effect on the comparison.
	///
	/// - parameter list: a list of `Date` to evaluate
	///
	/// - returns: a `DateInRegion` object representing a date that is the earliest from a given
	///            range of dates.
	public static func oldestDate(_ list: [Date]) -> Date {
		var currentMinimum = Date.distantFuture
		list.forEach { cDate in
			if currentMinimum > cDate {
				currentMinimum = cDate
			}
		}
		return currentMinimum
	}
	
	
	/// Returns a Date object representing a date that is the latest from a given range of
	/// dates. The dates are compared in absolute time, i.e. time zones, locales and calendars have
	/// no effect on the comparison.
	///
	/// - parameter list: a list of `Date` to evaluate
	///
	/// - returns: a `DateInRegion` object representing a date that is the latest from a given
	///     range of dates.
	public static func recentDate(_ list: [Date]) -> Date {
		var currentMaximum = Date.distantPast
		list.forEach { cDate in
			if currentMaximum < cDate {
				currentMaximum = cDate
			}
		}
		return currentMaximum
	}
}
