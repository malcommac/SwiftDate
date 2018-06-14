//
//  TimePeriod.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

open class TimePeriod: TimePeriodProtocol {
	
	/// The start date for a TimePeriod representing the starting boundary of the time period
	public var start: DateInRegion?
	
	/// The end date for a TimePeriod representing the ending boundary of the time period
	public var end: DateInRegion?
	
	// MARK: - Initializers
	
	public init() { }
	
	public init(start: DateInRegion?, end: DateInRegion?) {
		self.start = start
		self.end = end
	}
	
	public init(start: DateInRegion, duration: TimeInterval) {
		self.start = start
		self.end = DateInRegion(start.date.addingTimeInterval(duration), region: start.region)
	}
	
	public init(end: DateInRegion, duration: TimeInterval) {
		self.end = end
		self.start = end.addingTimeInterval(-duration)
	}
	
	// MARK: - Shifted
	
	/// Shift the `TimePeriod` by a `TimeInterval`
	///
	/// - Parameter timeInterval: The time interval to shift the period by
	/// - Returns: The new, shifted `TimePeriod`
	public func shifted(by timeInterval: TimeInterval) -> TimePeriod {
		let timePeriod = TimePeriod()
		timePeriod.start = self.start?.addingTimeInterval(timeInterval)
		timePeriod.end = self.end?.addingTimeInterval(timeInterval)
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
			timePeriod.start = self.start
			timePeriod.end = self.end?.addingTimeInterval(timeInterval)
			break
		case .center:
			timePeriod.start = self.start?.addingTimeInterval(-timeInterval)
			timePeriod.end = self.end?.addingTimeInterval(timeInterval)
			break
		case .end:
			timePeriod.start = self.start?.addingTimeInterval(-timeInterval)
			timePeriod.end = self.end
			break
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
			break
		case .center:
			timePeriod.start = start?.addingTimeInterval(-timeInterval/2)
			timePeriod.end = end?.addingTimeInterval(timeInterval/2)
			break
		case .end:
			timePeriod.start = start?.addingTimeInterval(timeInterval)
			timePeriod.end = end
			break
		}
		return timePeriod
	}
	
	// MARK: - Operator Overloads
	
	/// Operator overload for checking if two `TimePeriod`s are equal
	public static func == (leftAddend: TimePeriod, rightAddend: TimePeriod) -> Bool {
		return (leftAddend == rightAddend)
	}
	
	/// Default anchor = beginning
	/// Operator overload for lengthening a `TimePeriod` by a `TimeInterval`
	public static func + (leftAddend: TimePeriod, rightAddend: TimeInterval) -> TimePeriod {
		return leftAddend.lengthened(by: rightAddend, at: .beginning)
	}
	
	/// Default anchor = beginning
	/// Operator overload for shortening a `TimePeriod` by a `TimeInterval`
	public static func -(minuend: TimePeriod, subtrahend: TimeInterval) -> TimePeriod {
		return minuend.shortened(by: subtrahend, at: .beginning)
	}
	
	/// Operator overload for checking if a `TimePeriod` is equal to a `TimePeriodProtocol`
	public static func ==(left: TimePeriod, right: TimePeriodProtocol) -> Bool {
		return left.equals(right)
	}
	
}
