//
//  DateInRegion+Components.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public extension DateInRegion {

	/// Indicates whether the month is a leap month.
	public var isLeapMonth: Bool {
		let calendar = self.region.calendar
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if calendar.identifier == Calendar.Identifier.gregorian && self.year > 1582 {
			guard let range: Range<Int> = calendar.range(of: .day, in: .month, for: self.date) else {
				return false
			}
			return ((range.upperBound - range.lowerBound) == 29)
		}
		// For other calendars:
		return calendar.dateComponents([.day, .month, .year], from: self.date).isLeapMonth!
	}

	/// Indicates whether the year is a leap year.
	public var isLeapYear: Bool {
		let calendar = self.region.calendar
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if calendar.identifier == Calendar.Identifier.gregorian {
			var newComponents = self.dateComponents
			newComponents.month = 2
			newComponents.day = 10
			let testDate = DateInRegion(components: newComponents, region: self.region)
			return testDate!.isLeapMonth
		} else if calendar.identifier == Calendar.Identifier.chinese {
			/// There are 12 or 13 months in each year and 29 or 30 days in each month.
			/// A 13-month year is a leap year, which meaning more than 376 days is a leap year.
			return ( self.dateAtStartOf(.year).toUnit(.day, to: self.dateAtEndOf(.year)) > 375 )
		}
		// For other calendars:
		return calendar.dateComponents([.day, .month, .year], from: self.date).isLeapMonth!
	}

	/// Julian day is the continuous count of days since the beginning of
	/// the Julian Period used primarily by astronomers.
	public var julianDay: Double {
		let destRegion = Region(calendar: Calendars.gregorian, zone: Zones.gmt, locale: Locales.english)
		let utc = self.convertTo(region: destRegion)

		let year = Double(utc.year)
		let month = Double(utc.month)
		let day = Double(utc.day)
		let hour = Double(utc.hour) + Double(utc.minute) / 60.0 + (Double(utc.second) + Double(utc.nanosecond) / 1e9) / 3600.0

		var jd = 367.0 * year - floor( 7.0 * ( year + floor((month + 9.0) / 12.0)) / 4.0 )
		jd -= floor( 3.0 * (floor( (year + (month - 9.0) / 7.0) / 100.0 ) + 1.0) / 4.0 )
		jd += floor(275.0 * month / 9.0) + day + 1_721_028.5 + hour / 24.0

		return jd
	}

	/// The Modified Julian Date (MJD) was introduced by the Smithsonian Astrophysical Observatory
	/// in 1957 to record the orbit of Sputnik via an IBM 704 (36-bit machine)
	/// and using only 18 bits until August 7, 2576.
	public var modifiedJulianDay: Double {
		return self.julianDay - 2_400_000.5
	}

	/// Return elapsed time expressed in given components since the current receiver and a reference date.
	/// Time is evaluated with the fixed measumerent of each unity.
	///
	/// - Parameters:
	///   - refDate: reference date (`nil` to use current date in the same region of the receiver)
	///   - component: time unit to extract.
	/// - Returns: value
	public func getInterval(toDate: DateInRegion?, component: Calendar.Component) -> Int64 {
		let refDate = (toDate ?? self.region.nowInThisRegion())
		switch component {
		case .year:
			let end = self.calendar.ordinality(of: .year, in: .era, for: refDate.date)
			let start = self.calendar.ordinality(of: .year, in: .era, for: self.date)
			return Int64(end! - start!)

		case .month:
			let end = self.calendar.ordinality(of: .month, in: .era, for: refDate.date)
			let start = self.calendar.ordinality(of: .month, in: .era, for: self.date)
			return Int64(end! - start!)

		case .day:
			let end = self.calendar.ordinality(of: .day, in: .era, for: refDate.date)
			let start = self.calendar.ordinality(of: .day, in: .era, for: self.date)
			return Int64(end! - start!)

		case .hour:
			let interval = refDate.date.timeIntervalSince(self.date)
			return Int64(interval / 1.hours.timeInterval)

		case .minute:
			let interval = refDate.date.timeIntervalSince(self.date)
			return Int64(interval / 1.minutes.timeInterval)

		case .second:
			return Int64(refDate.date.timeIntervalSince(self.date))

		case .weekday:
			let end = self.calendar.ordinality(of: .weekday, in: .era, for: refDate.date)
			let start = self.calendar.ordinality(of: .weekday, in: .era, for: self.date)
			return Int64(end! - start!)

		case .weekdayOrdinal:
			let end = self.calendar.ordinality(of: .weekdayOrdinal, in: .era, for: refDate.date)
			let start = self.calendar.ordinality(of: .weekdayOrdinal, in: .era, for: self.date)
			return Int64(end! - start!)

		case .weekOfYear:
			let end = self.calendar.ordinality(of: .weekOfYear, in: .era, for: refDate.date)
			let start = self.calendar.ordinality(of: .weekOfYear, in: .era, for: self.date)
			return Int64(end! - start!)

		default:
			debugPrint("Passed component cannot be used to extract values using interval() function between two dates. Returning 0.")
			return 0
		}
	}

	/// The interval between the receiver and the another parameter.
	/// If the receiver is earlier than anotherDate, the return value is negative.
	/// If anotherDate is nil, the results are undefined.
	///
	/// - Parameter date: The date with which to compare the receiver.
	/// - Returns: time interval between two dates
	public func timeIntervalSince(_ date: DateInRegion) -> TimeInterval {
		return self.date.timeIntervalSince(date.date)
	}

}
