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

/// Sorting function for time period groups
///
/// - byStartDate: sort by startDate of the period
/// - custom->Bool: custom sort function
public enum TimePeriodGroupSort {
	public typealias SortFunction = ((_: TimePeriod, _: TimePeriod) -> Bool)
	
	case byStartDate
	case custom(_: SortFunction)
	
	public var sortFunction: SortFunction {
		switch self {
		case .custom(let custom_sort_func):
			return custom_sort_func
		case .byStartDate:
			let sort_bydate: SortFunction = { a,b in
				if a.startDate == nil && b.startDate == nil {
					return false
				}
				else if a.startDate == nil {
					return true
				}
				else if b.startDate == nil {
					return false
				}
				return b.startDate! < a.startDate!
			}
			return sort_bydate
		}
	}
}

// MARK: - Extension of DateInRegion

public extension DateInRegion {
	
	
	/// Return the fragment between self and another date
	///
	/// - Parameter date: date to compare at
	/// - Returns: fragment
	public func fragment(with date: DateInRegion) -> TimeFragment {
		let cmps = self.region.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date.absoluteDate)
		return TimeFragment(components: cmps)
	}
	
}


/// Sum a `TimeFragment` to `DateInRegion`
///
/// - Parameters:
///   - lhs: date
///   - rhs: time fragment
/// - Returns: a new date in region
public func +(lhs: DateInRegion, rhs: TimeFragment) -> DateInRegion? {
	do {
		return try lhs.add(components: rhs.dateComponents)
	} catch {
		return nil
	}
}

/// Subtract a `TimeFragment` from a `DateInRegion`
///
/// - Parameters:
///   - lhs: date
///   - rhs: time fragment
/// - Returns: a new date in region
public func -(lhs: DateInRegion, rhs: TimeFragment) -> DateInRegion? {
	do {
		return try lhs.add(components: -rhs.dateComponents)
	} catch {
		return nil
	}
}

/// When a time period is lrengthened or shortened it does so anchoring one date
/// of the time period and then chaning the other one.
/// There is also an option to anchor the centerpoint of the time period, changing
/// both the start and the end dates.
///
/// - start: modify the start date
/// - center: modify both of dates
/// - end: modify the end date
public enum TimeAnchor {
	case start
	case center
	case end
}


/// There may come a need, say when you are making a scheduling app, when
/// it might be good to know how two time periods relate to one another.
///
/// Are they the same? Is one inside of another? All these questions may be
/// asked using the relationship methods of DTTimePeriod.
public enum TimePeriodRelation {
	case after
	case startTouching
	case startInside
	case insideStartTouching
	case enclosingStartTouching
	case enclosing
	case enclosingEndTouching
	case exactMatch
	case inside
	case insideEndTouching
	case endInside
	case endTouching
	case before
	case unknown
}


/// Whether the time period is Open or Closed
///
/// - opened: The boundary moment of time is included in calculations
/// - closed: The boundary moment of time represents a boundary value
///           which is excluded in regard to calculations.
public enum TimePeriodType {
	case opened
	case closed
}
