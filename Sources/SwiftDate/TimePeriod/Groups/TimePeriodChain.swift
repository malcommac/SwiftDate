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

/// Time period chains serve as a tightly coupled set of time periods.
/// They are always organized by start and end date, and have their own characteristics like
/// a StartDate and EndDate that are extrapolated from the time periods within.
/// Time period chains do not allow overlaps within their set of time periods.
/// This type of group is ideal for modeling schedules like sequential meetings or appointments.
open class TimePeriodChain: TimePeriodGroup {
	
	// MARK: - Initializers
	
	public override init(_ periods: [TimePeriodProtocol]? = nil) {
		super.init(periods)
		
		updateExtremes()
	}
	
	// MARK: - Chain Existence Manipulation

	/**
	*  Adds a period of equivalent length to the end of the chain, regardless of
	*  whether the period intersects with the chain or not.
	*
	* - parameter period: TimePeriodProtocol to add to the collection
	*/
	public func append(_ period: TimePeriodProtocol) {
		guard isPeriodHasExtremes(period) else {
			print("All TimePeriods in a TimePeriodChain must contain a defined start and end date")
			return;
		}
		
		if let startDate = periods.last?.end! ?? period.start {
			let newPeriod = TimePeriod(start: startDate, duration: period.duration)
			periods.append(newPeriod)
			
			updateExtremes()
		}
	}
	
	/**
	*  Adds a periods of equivalent length of group to the end of the chain, regardless of
	*  whether the period intersects with the chain or not.
	*
	* - parameter periodArray: TimePeriodProtocol list to add to the collection
	*/
	public func append<G: TimePeriodGroup>(contentsOf group: G) {
		for period in group.periods {
			append(period)
		}
	}
	
	/**
	*  Adds a period of equivalent length to the start of the chain, regardless of
	*  whether the period intersects with the chain or not.
	*
	* - parameter period: TimePeriodProtocol to add to the collection
	*/
	public func prepend(_ period: TimePeriodProtocol) {
		guard isPeriodHasExtremes(period) else {
			print("All TimePeriods in a TimePeriodChain must contain a defined start and end date")
			return;
		}
		
		if let endDate = periods.first?.start! ?? period.end {
			let startDate = endDate.addingTimeInterval(-period.duration)
			
			let newPeriod = TimePeriod(start: startDate, duration: period.duration)
			periods.insert(newPeriod, at: periods.startIndex)
			
			updateExtremes()
		}
	}
	
	/**
	*  Adds a periods of equivalent length of group to the start of the chain, regardless of
	*  whether the period intersects with the chain or not.
	*
	* - parameter periodArray: TimePeriodProtocol list to add to the collection
	*/
	
	public func prepend<G: TimePeriodGroup>(contentsOf group: G) {
		for period in group.periods {
			prepend(period)
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
				let duration = periods[i].duration
				periods[i].start = periods[i - 1].end
				periods[i].end = periods[i].start!.addingTimeInterval(duration)
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
	
	/// Shifts chain's start date and all chain's periods to the given date
	///
	/// - Parameter date: The date to which the period's start is shifted
	public func shiftStart(to date: DateInRegion) {
		if let firstPeriodStart = periods.first?.start! {
			let difference = date - firstPeriodStart
			shift(by: difference)
		}
	}
	
	/// Shifts chain's end date and all chain's periods to the given date
	///
	/// - Parameter date: The date to which the period's end is shifted
	public func shiftEnd(to date: DateInRegion) {
		if let firstPeriodEnd = periods.last?.end! {
			let difference = date - firstPeriodEnd
			shift(by: difference)
		}
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
	
	internal func isPeriodHasExtremes (_ period: TimePeriodProtocol) -> Bool {
		period.start != nil && period.end != nil
	}

}
