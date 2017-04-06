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

// MARK: - Shortcuts to convert Date to DateInRegion

public extension Date {
	
	/// Return the current absolute datetime in local's device region (timezone+calendar+locale)
	///
	/// - returns: a new `DateInRegion` instance object which express passed absolute date in the context of the local device's region
	public func inLocalRegion() -> DateInRegion {
		return DateInRegion(absoluteDate: self)
	}
	
	/// Return the current absolute datetime in UTC/GMT timezone. `Calendar` and `Locale` are set automatically to the device's current settings.
	///
	/// - returns: a new `DateInRegion` instance object which express passed absolute date in UTC timezone
	public func inGMTRegion() -> DateInRegion {
		return DateInRegion(absoluteDate: self, in: Region.GMT())
	}
	
	/// Return the current absolute datetime in the context of passed `Region`.
	///
	/// - parameter region: region you want to use to express `self` date.
	///
	/// - returns: a new `DateInRegion` which represent `self` in the context of passed `Region`
	public func inRegion(region: Region? = nil) -> DateInRegion {
		return DateInRegion(absoluteDate: self, in: region)
	}
	
	/// Create a new Date object which is the sum of passed calendar components in `DateComponents` to `self`
	///
	/// - parameter components: components to set
	///
	/// - returns: a new `Date`
	public func add(components: DateComponents) -> Date {
		let date: DateInRegion = self.inDateDefaultRegion() + components
		return date.absoluteDate
	}
	
	/// Create a new Date object which is the sum of passed calendar components in dictionary of `Calendar.Component` values to `self`
	///
	/// - parameter components: components to set
	///
	/// - returns: a new `Date`
	public func add(components: [Calendar.Component: Int]) -> Date {
		let date: DateInRegion = self.inDateDefaultRegion() + components
		return date.absoluteDate
	}
	
	/// Enumerate dates between two intervals by adding specified time components and return an array of dates.
	/// `startDate` interval will be the first item of the resulting array. The last item of the array is evaluated automatically.
	///
	/// - throws: throw `.DifferentCalendar` if dates are expressed in a different calendar, '.FailedToCalculate'
	///
	/// - Parameters:
	///   - startDate: starting date
	///   - endDate: ending date
	///   - components: components to add
	/// - Returns: an array of DateInRegion objects
	public static func dates(between startDate: Date, and endDate: Date, increment components: DateComponents) -> [Date] {
		
		var dates = [startDate]
		var currentDate = startDate
		
		repeat {
			currentDate = currentDate.add(components: components)
			dates.append(currentDate)
		} while (currentDate <= endDate)
		
		return dates
	}
	
	/// Adjust time of the date by rounding to the next `value` interval.
	/// Interval can be `seconds` or `minutes` and you can specify the type of rounding function to use.
	///
	/// - Parameters:
	///   - value: value to round
	///   - type: type of rounding
	public func roundedAt(_ value: IntervalType, type: IntervalRoundingType = .ceil) -> Date {
		var roundedInterval: TimeInterval = 0
		let seconds = value.seconds
		switch type  {
		case .round:
			roundedInterval = (self.timeIntervalSinceReferenceDate / seconds).rounded() * seconds
		case .ceil:
			roundedInterval = ceil(self.timeIntervalSinceReferenceDate / seconds) * seconds
		case .floor:
			roundedInterval = floor(self.timeIntervalSinceReferenceDate / seconds) * seconds
		}
		return Date(timeIntervalSinceReferenceDate: roundedInterval)
	}
	
	/// Returns a boolean value that indicates whether the represented absolute date uses daylight saving time when
	/// expressed in passed timezone.
	///
	/// - Parameter tzName: destination timezone
	/// - Returns: `true` if date uses DST when represented in given timezone, `false` otherwise
	public func isDST(in tzName: TimeZoneName) -> Bool {
		return tzName.timeZone.isDaylightSavingTime(for: self)
	}
	
	/// The current daylight saving time offset of the represented date when expressed in passed timezone.
	///
	/// - Parameter tzName: destination timezone
	/// - Returns: interval of DST expressed in seconds
	public func DSTOffset(in tzName: TimeZoneName) -> TimeInterval {
		return tzName.timeZone.daylightSavingTimeOffset(for: self)
	}
	
	/// The date of the next daylight saving time transition after currently represented date when expressed
	/// in given timezone.
	///
	/// - Parameter tzName: destination timezone
	/// - Returns: next transition date
	public func nextDSTTransitionDate(in tzName: TimeZoneName) -> Date? {
		guard let next_date = tzName.timeZone.nextDaylightSavingTimeTransition(after: self) else {
			return nil
		}
		return next_date
	}
	
}

// MARK: - Sum of Dates and Date & Components

public func - (lhs: Date, rhs: DateComponents) -> Date {
	return lhs + (-rhs)
}

public func + (lhs: Date, rhs: DateComponents) -> Date {
	return lhs.add(components: rhs)
}

public func + (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(rhs)
}

public func - (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(-rhs)
}

public func + (lhs: Date, rhs: [Calendar.Component : Int]) -> Date {
	return lhs.add(components: DateInRegion.componentsFrom(values: rhs))
}

public func - (lhs: Date, rhs: [Calendar.Component : Int]) -> Date {
	return lhs.add(components: DateInRegion.componentsFrom(values: rhs, multipler: -1))
}

public func - (lhs: Date, rhs: Date) -> TimeInterval {
	return DateTimeInterval(start: lhs, end: rhs).duration
}
