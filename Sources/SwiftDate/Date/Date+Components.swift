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

public extension Date {

	/// Indicates whether the month is a leap month.
	var isLeapMonth: Bool {
        inDefaultRegion().isLeapMonth
	}

	/// Indicates whether the year is a leap year.
	var isLeapYear: Bool {
        inDefaultRegion().isLeapYear
	}

	/// Julian day is the continuous count of days since the beginning of
	/// the Julian Period used primarily by astronomers.
	var julianDay: Double {
        inDefaultRegion().julianDay
	}

	/// The Modified Julian Date (MJD) was introduced by the Smithsonian Astrophysical Observatory
	/// in 1957 to record the orbit of Sputnik via an IBM 704 (36-bit machine)
	/// and using only 18 bits until August 7, 2576.
	var modifiedJulianDay: Double {
        inDefaultRegion().modifiedJulianDay
	}

	/// Return elapsed time expressed in given components since the current receiver and a reference date.
	///
	/// - Parameters:
	///   - refDate: reference date (`nil` to use current date in the same region of the receiver)
	///   - component: time unit to extract.
	/// - Returns: value
	func getInterval(toDate: Date?, component: Calendar.Component) -> Int64 {
        inDefaultRegion().getInterval(toDate: toDate?.inDefaultRegion(), component: component)
	}
}
