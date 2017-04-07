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

public enum TimeUnit {
	case years
	case weeks
	case days
	case hours
	case minutes
	case seconds
}

public struct TimeFragment : Equatable {
	public var seconds:	Int = 0
	public var minutes:	Int = 0
	public var hours:	Int = 0
	public var days:	Int = 0
	public var weeks:	Int = 0
	public var months:	Int = 0
	public var years:	Int = 0
	
	
	/// Initialize a new time fragment with all components zeroed
	public init() { }
	
	/// Initialize a new time fragment with given component
	///
	/// - Parameters:
	///   - years: years value
	///   - months: months value
	///   - weeks: weeks value
	///   - days: days value
	///   - hours: hours value
	///   - minutes: minutes value
	///   - seconds: seconds value
	public init(years: Int? = 0, months: Int? = 0, weeks: Int? = 0, days: Int? = 0,
	            hours: Int? = 0, minutes: Int? = 0, seconds: Int? = 0) {
		self.years = years ?? 0
		self.months = months ?? 0
		self.weeks = weeks ?? 0
		self.days = days ?? 0
		self.hours = hours ?? 0
		self.minutes = minutes ?? 0
		self.seconds = seconds ?? 0
	}
	
	public init(components: DateComponents) {
		
	}
	
	public var dateComponents: DateComponents {
		var components = DateComponents()
		components.year = self.years
		components.month = self.months
		components.day = self.days + (self.weeks * 7)
		components.hour = self.hours
		components.minute = self.minutes
		components.second = self.seconds
		return components
	}
	
	
	/// Returns the given `DateInRegion` decreased by the amount in self.
	///
	/// - Parameter refDate: reference date
	/// - Returns: a new `DateInRegion` with components decreased according to the variables of self
	/// - Throws: throw an exception if date cannot be generated
	public func ealier(than refDate: DateInRegion? = nil) throws -> DateInRegion {
		guard let refDate = refDate else {
			return try DateInRegion().add(components: self.dateComponents)
		}
		return try refDate.add(components: self.dateComponents)
	}
	
	
	/// Returns the given `DateInRegion` increased by the amount in self
	///
	/// - Parameter refDate: reference date
	/// - Returns: A new date with components increased according to the variables of self
	/// - Throws: throw an exception if date cannot be generated
	public func later(than refDate: DateInRegion? = nil) throws -> DateInRegion {
		guard let refDate = refDate else {
			return try DateInRegion().add(components: -self.dateComponents)
		}
		return try refDate.add(components: -self.dateComponents)
	}
	
	
	/// In place, increase the variables of self by the variables of the given fragment
	///
	/// - Parameter fragment: fragment
	public mutating func lengthened(byFragment fragment: TimeFragment) {
		self.seconds += fragment.seconds
		self.minutes += fragment.minutes
		self.hours += fragment.hours
		self.days += fragment.days
		self.weeks += fragment.weeks
		self.months += fragment.months
		self.years += fragment.years
	}
	
	/// In place, decrease the variables of self by the variables of the given fragment
	///
	/// - Parameter fragment: fragment
	public mutating func shortened(byFragment fragment: TimeFragment) {
		self.seconds -= fragment.seconds
		self.minutes -= fragment.minutes
		self.hours -= fragment.hours
		self.days -= fragment.days
		self.weeks -= fragment.weeks
		self.months -= fragment.months
		self.years -= fragment.years
	}
	
	/// Return `true` if two fragments are equals
	///
	/// - Parameters:
	///   - lhs: left item to compare
	///   - rhs: right item to compare
	/// - Returns: a boolean
	public static func ==(lhs: TimeFragment, rhs: TimeFragment) -> Bool {
		return (lhs.years == rhs.years) && (lhs.months == rhs.months) && (lhs.weeks == rhs.weeks) && (lhs.days == rhs.days) && (lhs.hours == rhs.hours) && (lhs.minutes == rhs.minutes) && (lhs.seconds == rhs.seconds)
	}
	
	
	/// Sum of fragments
	///
	/// - Parameters:
	///   - lhs: left operator
	///   - rhs: right operator
	/// - Returns: new fragment
	public static func +(lhs: TimeFragment, rhs: TimeFragment) -> TimeFragment {
		var newFragment = TimeFragment()
		newFragment.seconds = lhs.seconds + rhs.seconds
		newFragment.minutes = lhs.minutes + rhs.minutes
		newFragment.hours = lhs.hours + rhs.hours
		newFragment.days = lhs.days + rhs.days
		newFragment.weeks = lhs.weeks + rhs.weeks
		newFragment.months = lhs.months + rhs.months
		newFragment.years = lhs.years + rhs.years
		return newFragment
	}
	
	
	/// Subtract of fragments
	///
	/// - Parameters:
	///   - lhs: left operator
	///   - rhs: right operastor
	/// - Returns: new fragment
	public static func -(lhs: TimeFragment, rhs: TimeFragment) -> TimeFragment {
		var newFragment = TimeFragment()
		newFragment.seconds = lhs.seconds - rhs.seconds
		newFragment.minutes = lhs.minutes - rhs.minutes
		newFragment.hours = lhs.hours - rhs.hours
		newFragment.days = lhs.days - rhs.days
		newFragment.weeks = lhs.weeks - rhs.weeks
		newFragment.months = lhs.months - rhs.months
		newFragment.years = lhs.years - rhs.years
		return newFragment
	}
	
	public func `in`(_ unit: TimeUnit) -> Int {
		guard self.months == 0 else {
			fatalError("Months are not supported due to their dependncy from a calendar")
		}
		
		switch unit {
		case .seconds:
			var total = self.seconds
			total += self.minutes * Int(SECONDS_IN_MINUTE)
			total += self.hours * Int(SECONDS_IN_HOUR)
			total += self.days * Int(SECONDS_IN_DAY)
			total += self.weeks * Int(SECONDS_IN_WEEK)
			total += self.years * Int(SECONDS_IN_YEAR)
			return total
		case .minutes:
			var total = self.minutes
			total += self.seconds / Int(SECONDS_IN_MINUTE)
			total += self.hours * Int(MINUTES_IN_HOUR)
			total += self.days * Int(MINUTES_IN_DAYS)
			total += self.weeks * Int(MINUTES_IN_WEEK)
			total += self.years * Int(MINUTES_IN_YEAR)
			return total
		case .hours:
			var total = self.hours
			let secondsToMinutes = self.seconds / Int(SECONDS_IN_MINUTE)
			total += (self.minutes + secondsToMinutes) / Int(SECONDS_IN_MINUTE)
			total += self.days * Int(HOURS_IN_DAY)
			total += self.weeks * Int(HOURS_IN_WEEK)
			total += self.years * Int(HOURS_IN_YEAR)
			return total
		case .days:
			var total = self.days
			let secondsToMinutes = self.seconds / Int(SECONDS_IN_MINUTE)
			let minutesToHours = (self.minutes + secondsToMinutes) / Int(SECONDS_IN_MINUTE)
			total += (self.hours + minutesToHours) / Int(HOURS_IN_DAY)
			total += self.weeks * 7
			total += self.years * 365
			return total
		case .weeks:
			var total = self.weeks
			let secondsToMinutes = self.seconds / Int(SECONDS_IN_MINUTE)
			let minutesToHours = (self.minutes + secondsToMinutes) / Int(SECONDS_IN_MINUTE)
			let hoursToDays = (self.hours + minutesToHours) / Int(HOURS_IN_DAY)
			total += (self.days + hoursToDays) / 7
			total += self.years * 52
			return total
		case .years:
			var total = self.years
			let secondsToMinutes = self.seconds / Int(SECONDS_IN_MINUTE)
			let minutesToHours = (self.minutes + secondsToMinutes) / Int(SECONDS_IN_MINUTE)
			let hoursToDays = (self.hours + minutesToHours) / Int(HOURS_IN_DAY)
			let weeksToDays = weeks * 7
			total += (self.days + hoursToDays + weeksToDays) / 365
			return total
		}
	}
	
	
}

