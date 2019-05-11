//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import Foundation

public extension DateInRegion {

	/// Indicates whether the month is a leap month.
	var isLeapMonth: Bool {
		let calendar = region.calendar
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if calendar.identifier == Calendar.Identifier.gregorian && year > 1582 {
			guard let range: Range<Int> = calendar.range(of: .day, in: .month, for: date) else {
				return false
			}
			return ((range.upperBound - range.lowerBound) == 29)
		}
		// For other calendars:
		return calendar.dateComponents([.day, .month, .year], from: date).isLeapMonth!
	}

	/// Indicates whether the year is a leap year.
	var isLeapYear: Bool {
		let calendar = region.calendar
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if calendar.identifier == Calendar.Identifier.gregorian {
			var newComponents = dateComponents
			newComponents.month = 2
			newComponents.day = 10
			let testDate = DateInRegion(components: newComponents, region: region)
			return testDate!.isLeapMonth
		} else if calendar.identifier == Calendar.Identifier.chinese {
			/// There are 12 or 13 months in each year and 29 or 30 days in each month.
			/// A 13-month year is a leap year, which meaning more than 376 days is a leap year.
			return ( dateAtStartOf(.year).toUnit(.day, to: dateAtEndOf(.year)) > 375 )
		}
		// For other calendars:
		return calendar.dateComponents([.day, .month, .year], from: date).isLeapMonth!
	}

	/// Julian day is the continuous count of days since the beginning of
	/// the Julian Period used primarily by astronomers.
	var julianDay: Double {
		let destRegion = Region(calendar: Calendars.gregorian, zone: Zones.gmt, locale: Locales.english)
		let utc = convertTo(region: destRegion)

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
	var modifiedJulianDay: Double {
		return julianDay - 2_400_000.5
	}

	/// Return elapsed time expressed in given components since the current receiver and a reference date.
	/// Time is evaluated with the fixed measumerent of each unity.
	///
	/// - Parameters:
	///   - refDate: reference date (`nil` to use current date in the same region of the receiver)
	///   - component: time unit to extract.
	/// - Returns: value
	func getInterval(toDate: DateInRegion?, component: Calendar.Component) -> Int64 {
		let refDate = (toDate ?? region.nowInThisRegion())
		switch component {
		case .year:
			let end = calendar.ordinality(of: .year, in: .era, for: refDate.date)
			let start = calendar.ordinality(of: .year, in: .era, for: date)
			return Int64(end! - start!)

		case .month:
			let end = calendar.ordinality(of: .month, in: .era, for: refDate.date)
			let start = calendar.ordinality(of: .month, in: .era, for: date)
			return Int64(end! - start!)

		case .day:
			let end = calendar.ordinality(of: .day, in: .era, for: refDate.date)
			let start = calendar.ordinality(of: .day, in: .era, for: date)
			return Int64(end! - start!)

		case .hour:
			let interval = refDate.date.timeIntervalSince(date)
			return Int64(interval / 1.hours.timeInterval)

		case .minute:
			let interval = refDate.date.timeIntervalSince(date)
			return Int64(interval / 1.minutes.timeInterval)

		case .second:
			return Int64(refDate.date.timeIntervalSince(date))

		case .weekday:
			let end = calendar.ordinality(of: .weekday, in: .era, for: refDate.date)
			let start = calendar.ordinality(of: .weekday, in: .era, for: date)
			return Int64(end! - start!)

		case .weekdayOrdinal:
			let end = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: refDate.date)
			let start = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: date)
			return Int64(end! - start!)

		case .weekOfYear:
			let end = calendar.ordinality(of: .weekOfYear, in: .era, for: refDate.date)
			let start = calendar.ordinality(of: .weekOfYear, in: .era, for: date)
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
	func timeIntervalSince(_ date: DateInRegion) -> TimeInterval {
		return self.date.timeIntervalSince(date.date)
	}

	/// Extract DateComponents from the difference between two dates.
	///
	/// - Parameter rhs: date to compare
	/// - Returns: components
	func componentsTo(_ rhs: DateInRegion) -> DateComponents {
		return calendar.dateComponents(DateComponents.allComponentsSet, from: rhs.date, to: date)
	}

	/// Returns the difference between two dates (`date - self`) expressed as date components.
	///
	/// - Parameters:
	///   - date: reference date as initial date (left operand)
	///   - components: components to extract, `nil` to use default `DateComponents.allComponentsSet`
	/// - Returns: extracted date components
	func componentsSince(_ date: DateInRegion, components: [Calendar.Component]? = nil) -> DateComponents {
		if date.calendar != calendar {
			debugPrint("Date has different calendar, results maybe wrong")
		}
		let cmps = (components != nil ? Calendar.Component.toSet(components!) : DateComponents.allComponentsSet)
		return date.calendar.dateComponents(cmps, from: date.date, to: self.date)
	}

}
