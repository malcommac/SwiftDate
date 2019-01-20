//
//  TimePeriodChain.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

/// Time period chains serve as a tightly coupled set of time periods.
/// They are always organized by start and end date, and have their own characteristics like
/// a StartDate and EndDate that are extrapolated from the time periods within.
/// Time period chains do not allow overlaps within their set of time periods.
/// This type of group is ideal for modeling schedules like sequential meetings or appointments.
open class TimePeriodChain: TimePeriodGroup {

	// MARK: - Chain Existence Manipulation

	/**
	*  Append a TimePeriodProtocol to the periods array and update the Chain's
	*  beginning and end.
	*
	* - parameter period: TimePeriodProtocol to add to the collection
	*/
	public func append(_ period: TimePeriodProtocol) {
		let beginning = (periods.count > 0) ? periods.last!.end! : period.start

		let newPeriod = TimePeriod(start: beginning!, duration: period.duration)
		periods.append(newPeriod)

		//Update updateExtremes
		if periods.count == 1 {
			start = period.start
			end = period.end
		} else {
			end = end?.addingTimeInterval(period.duration)
		}
	}

	/**
	*  Append a TimePeriodProtocol array to the periods array and update the Chain's
	*  beginning and end.
	*
	* - parameter periodArray: TimePeriodProtocol list to add to the collection
	*/
	public func append<G: TimePeriodGroup>(contentsOf group: G) {
		for period in group.periods {
			let beginning = (periods.count > 0) ? periods.last!.end! : period.start

			let newPeriod = TimePeriod(start: beginning!, duration: period.duration)
			periods.append(newPeriod)

			//Update updateExtremes
			if periods.count == 1 {
				start = period.start
				end = period.end
			} else {
				end = end?.addingTimeInterval(period.duration)
			}
		}
	}

	/// Insert period into periods array at given index.
	///
	/// - Parameters:
	///   - period: The period to insert
	///   - index: Index to insert period at
	public func insert(_ period: TimePeriodProtocol, at index: Int) {
		//Check for special zero case which takes the beginning date
		if index == 0 && period.start != nil && period.end != nil {
			//Insert new period
			periods.insert(period, at: index)
		} else if period.start != nil && period.end != nil {
			//Insert new period
			periods.insert(period, at: index)
		} else {
			print("All TimePeriods in a TimePeriodChain must contain a defined start and end date")
			return
		}

		//Shift all periods after inserted period
		for i in 0..<periods.count {
			if i > index && i > 0 {
				let currentPeriod = TimePeriod(start: period.start, end: period.end)
				periods[i].start = periods[i - 1].end
				periods[i].end = periods[i].start!.addingTimeInterval(currentPeriod.duration)
			}
		}

		updateExtremes()
	}

	/// Remove from period array at the given index.
	///
	/// - Parameter index: The index in the collection to remove
	public func remove(at index: Int) {
		//Retrieve duration of period to be removed
		let duration = periods[index].duration

		//Remove period
		periods.remove(at: index)

		//Shift all periods after inserted period
		for i in index..<periods.count {
			periods[i].shift(by: -duration)
		}
		updateExtremes()
	}

	/// Remove all periods from period array.
	public func removeAll() {
		periods.removeAll()
		updateExtremes()
	}

	// MARK: - Chain Content Manipulation

	/// In place, shifts all chain time periods by a given time interval
	///
	/// - Parameter duration: The time interval to shift the period by
	public func shift(by duration: TimeInterval) {
		for var period in periods {
			period.shift(by: duration)
		}
		start = start?.addingTimeInterval(duration)
		end = end?.addingTimeInterval(duration)
	}

	public override func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
		return try periods.map(transform)
	}

	public override func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
		return try periods.filter(isIncluded)
	}

	internal override func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
		return try periods.reduce(initialResult, nextPartialResult)
	}

	/// Removes the last object from the `TimePeriodChain` and returns it
	public func pop() -> TimePeriodProtocol? {
		let period = periods.popLast()
		updateExtremes()

		return period
	}

	internal func updateExtremes() {
		start = periods.first?.start
		end = periods.last?.end
	}

}
