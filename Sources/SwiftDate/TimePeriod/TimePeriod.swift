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

/// Time periods are represented by the TimePeriodProtocol protocol.
/// Required variables and method impleementations are bound below.
/// An inheritable implementation of the TimePeriodProtocol is available through the TimePeriod class.
open class TimePeriod: TimePeriodProtocol {

	/// The start date for a TimePeriod representing the starting boundary of the time period
	public var start: DateInRegion?

	/// The end date for a TimePeriod representing the ending boundary of the time period
	public var end: DateInRegion?

	// MARK: - Initializers

	public init() { }

	/// Create a new time period with given date range.
	///
	/// - Parameters:
	///   - start: start date
	///   - end: end date
	public init(start: DateInRegion?, end: DateInRegion?) {
		self.start = start
		self.end = end
	}

	/// Create a new time period with given start and a length specified in number of seconds.
	///
	/// - Parameters:
	///   - start: start of the period
	///   - duration: duration of the period expressed in seconds
	public init(start: DateInRegion, duration: TimeInterval) {
		self.start = start
		self.end = DateInRegion(start.date.addingTimeInterval(duration), region: start.region)
	}

	/// Create a new time period which ends at given date and start date is back on time by given interval.
	///
	/// - Parameters:
	///   - end: end date
	///   - duration: duration expressed in seconds (it will be subtracted from start date)
	public init(end: DateInRegion, duration: TimeInterval) {
		self.end = end
		self.start = end.addingTimeInterval(-duration)
	}

	/// Return a new instance of the TimePeriod that starts on the provided start date and is of the
	/// size provided.
	///
	/// - Parameters:
	///   - start: start of the period
	///   - duration: length of the period (ie. `2.days` or `14.hours`...)
	public init(start: DateInRegion, duration: DateComponents) {
		self.start = start
		self.end = (start + duration)
	}

	/// Return a new instance of the TimePeriod that starts at end time minus given duration.
	///
	/// - Parameters:
	///   - end: end date
	///   - duration: duration (it will be subtracted from end date in order to provide the start date)
	public init(end: DateInRegion, duration: DateComponents) {
		self.start = (end - duration)
		self.end = end
	}

	/// Returns a new instance of DTTimePeriod that represents the largest time period available.
	/// The start date is in the distant past and the end date is in the distant future.
	///
	/// - Returns: a new time period
	public static func infinity() -> TimePeriod {
		return TimePeriod(start: DateInRegion.past(), end: DateInRegion.future())
	}

	// MARK: - Shifted

	/// Shift the `TimePeriod` by a `TimeInterval`
	///
	/// - Parameter timeInterval: The time interval to shift the period by
	/// - Returns: The new, shifted `TimePeriod`
	public func shifted(by timeInterval: TimeInterval) -> TimePeriod {
		let timePeriod = TimePeriod()
		timePeriod.start = start?.addingTimeInterval(timeInterval)
		timePeriod.end = end?.addingTimeInterval(timeInterval)
		return timePeriod
	}

	/// Shift the `TimePeriod` by the specified components value.
	/// ie. `let shifted = period.shifted(by: 3.days)`
	///
	/// - Parameter components: components to shift
	/// - Returns: new period
	public func shifted(by components: DateComponents) -> TimePeriod {
		let timePeriod = TimePeriod()
		timePeriod.start = (hasStart ? (start! + components) : nil)
		timePeriod.end = (hasEnd ? (end! + components) : nil)
		return timePeriod
	}

	// MARK: - Lengthen / Shorten

	/// Lengthen the `TimePeriod` by a `TimeInterval`
	///
	/// - Parameters:
	///   - timeInterval: The time interval to lengthen the period by
	///   - anchor: The anchor point from which to make the change
	/// - Returns: The new, lengthened `TimePeriod`
	public func lengthened(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) -> TimePeriod {
		let timePeriod = TimePeriod()
		switch anchor {
		case .beginning:
			timePeriod.start = start
			timePeriod.end = end?.addingTimeInterval(timeInterval)
		case .center:
			timePeriod.start = start?.addingTimeInterval(-timeInterval)
			timePeriod.end = end?.addingTimeInterval(timeInterval)
		case .end:
			timePeriod.start = start?.addingTimeInterval(-timeInterval)
			timePeriod.end = end
		}
		return timePeriod
	}

	/// Shorten the `TimePeriod` by a `TimeInterval`
	///
	/// - Parameters:
	///   - timeInterval:  The time interval to shorten the period by
	///   - anchor: The anchor point from which to make the change
	/// - Returns: The new, shortened `TimePeriod`
	public func shortened(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) -> TimePeriod {
		let timePeriod = TimePeriod()
		switch anchor {
		case .beginning:
			timePeriod.start = start
			timePeriod.end = end?.addingTimeInterval(-timeInterval)
		case .center:
			timePeriod.start = start?.addingTimeInterval(-timeInterval / 2)
			timePeriod.end = end?.addingTimeInterval(timeInterval / 2)
		case .end:
			timePeriod.start = start?.addingTimeInterval(timeInterval)
			timePeriod.end = end
		}
		return timePeriod
	}

	// MARK: - Operator Overloads

	/// Default anchor = beginning
	/// Operator overload for lengthening a `TimePeriod` by a `TimeInterval`
	public static func + (leftAddend: TimePeriod, rightAddend: TimeInterval) -> TimePeriod {
		return leftAddend.lengthened(by: rightAddend, at: .beginning)
	}

	/// Default anchor = beginning
	/// Operator overload for shortening a `TimePeriod` by a `TimeInterval`
	public static func - (minuend: TimePeriod, subtrahend: TimeInterval) -> TimePeriod {
		return minuend.shortened(by: subtrahend, at: .beginning)
	}

	/// Operator overload for checking if a `TimePeriod` is equal to a `TimePeriodProtocol`
	public static func == (left: TimePeriod, right: TimePeriodProtocol) -> Bool {
		return left.equals(right)
	}

}

public extension TimePeriod {

    /// The start date of the time period
    var startDate: Date? {
        return start?.date
    }

    /// The end date of the time period
    var endDate: Date? {
        return end?.date
    }

    /// Create a new time period with the given start date, end date and region (default is UTC)
    convenience init(startDate: Date, endDate: Date, region: Region = Region.UTC) {
        let start = DateInRegion(startDate, region: region)
        let end = DateInRegion(endDate, region: region)
        self.init(start: start, end: end)
    }
}
