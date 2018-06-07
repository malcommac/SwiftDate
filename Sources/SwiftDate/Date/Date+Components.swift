//
//  Date+Components.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 07/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public extension Date {
	
	/// Indicates whether the month is a leap month.
	public var isLeapMonth: Bool {
		return self.inDefaultRegion().isLeapMonth
	}
	
	/// Indicates whether the year is a leap year.
	public var isLeapYear: Bool {
		return self.inDefaultRegion().isLeapYear
	}
	
	/// Julian day is the continuous count of days since the beginning of
	/// the Julian Period used primarily by astronomers.
	public var julianDay: Double {
		return self.inDefaultRegion().julianDay
	}
	
	/// The Modified Julian Date (MJD) was introduced by the Smithsonian Astrophysical Observatory
	/// in 1957 to record the orbit of Sputnik via an IBM 704 (36-bit machine)
	/// and using only 18 bits until August 7, 2576.
	public var modifiedJulianDay: Double {
		return self.inDefaultRegion().modifiedJulianDay
	}
	
	/// Return given time unit components related to the difference between two dates.
	/// Note: 	Intervals is evaluated accounting the calendar/timezone of the receiver and in order to give correct
	///			results also the `toDate` must be expressed in the same context.
	///
	/// - Parameters:
	///   - units: time units to extract.
	///   - toDate: reference date (if `nil` the current date expressed in the same region of the receiver date is used)
	/// - Returns: a dictionary with extract `Calendar.Component` items with their associated values.
	public func `in`(_ units: [Calendar.Component], toDate: Date?) -> [Calendar.Component: Int] {
		let components = self.region.calendar.dateComponents(Calendar.Component.toSet(units), from: self.date, to: (toDate ?? Date()))
		return components.toDict()
	}
	
	/// Return given time unit component related to the difference between two dates.
	/// Note: 	Intervals is evaluated accounting the calendar/timezone of the receiver and in order to give correct
	///			results also the `toDate` must be expressed in the same context.
	///
	/// - Parameters:
	///   - unit: time unit to extract.
	///   - toDate: reference date (if `nil` the current date expressed in the same region of the receiver date is used)
	/// - Returns: non optional value
	public func `in`(_ unit: Calendar.Component, toDate: Date?) -> Int {
		return self.in([unit], toDate: toDate)[unit]!
	}
	
	/// Return elapsed time expressed in given components since the current receiver and a reference date.
	///
	/// - Parameters:
	///   - refDate: reference date (`nil` to use current date in the same region of the receiver)
	///   - component: time unit to extract.
	/// - Returns: value
	public func getInterval(toDate: Date?, component: Calendar.Component) -> Int64 {
		return self.inDefaultRegion().getInterval(toDate: toDate?.inDefaultRegion(), component: component)
	}
}

