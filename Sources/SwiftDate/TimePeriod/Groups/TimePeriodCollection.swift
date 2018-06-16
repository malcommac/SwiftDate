//
//  TimePeriodCollection.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

/// Time period collections serve as loose sets of time periods.
/// They are unorganized unless you decide to sort them, and have their own characteristics
/// like a `start` and `end` that are extrapolated from the time periods within.
/// Time period collections allow overlaps within their set of time periods.
open class TimePeriodCollection: TimePeriodGroup {

	// MARK: - Collection Manipulation

	/// Append a TimePeriodProtocol to the periods array and check if the Collection's start and end should change.
	///
	/// - Parameter period: TimePeriodProtocol to add to the collection
	public func append(_ period: TimePeriodProtocol) {
		periods.append(period)
		updateExtremes(period: period)
	}

	/// Append a TimePeriodProtocol array to the periods array and check if the Collection's
	/// start and end should change.
	///
	/// - Parameter periodArray: TimePeriodProtocol list to add to the collection
	public func append(_ periodArray: [TimePeriodProtocol]) {
		for period in periodArray {
			periods.append(period)
			updateExtremes(period: period)
		}
	}

	/// Append a TimePeriodGroup's periods array to the periods array of self and check if the Collection's
	/// start and end should change.
	///
	/// - Parameter newPeriods: TimePeriodGroup to merge periods arrays with
	public func append<C: TimePeriodGroup>(contentsOf newPeriods: C) {
		for period in newPeriods as TimePeriodGroup {
			periods.append(period)
			updateExtremes(period: period)
		}
	}

	/// Insert period into periods array at given index.
	///
	/// - Parameters:
	///   - newElement: The period to insert
	///   - index: Index to insert period at
	public func insert(_ newElement: TimePeriodProtocol, at index: Int) {
		periods.insert(newElement, at: index)
		updateExtremes(period: newElement)
	}

	/// Remove from period array at the given index.
	///
	/// - Parameter at: The index in the collection to remove
	public func remove(at: Int) {
		periods.remove(at: at)
		updateExtremes()
	}

	/// Remove all periods from period array.
	public func removeAll() {
		periods.removeAll()
		updateExtremes()
	}

	// MARK: - Sorting

	/// Sort periods array in place by start
	public func sortByStart() {
		self.sort { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
			if period1.start == nil && period2.start == nil {
				return false
			} else if period1.start == nil {
				return true
			} else if period2.start == nil {
				return false
			} else {
				return period2.start! < period1.start!
			}
		}
	}

	/// Sort periods array in place
	public func sort(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) {
		self.periods.sort(by: areInIncreasingOrder)
	}

	/// Return collection with sorted periods array by start
	///
	/// - Returns: Collection with sorted periods
	public func sortedByStart() -> TimePeriodCollection {
		let array = self.periods.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
			if period1.start == nil && period2.start == nil {
				return false
			} else if period1.start == nil {
				return true
			} else if period2.start == nil {
				return false
			} else {
				return period2.start! < period1.start!
			}
		}
		let collection = TimePeriodCollection()
		collection.append(array)
		return collection
	}

	/// Return collection with sorted periods array
	///
	/// - Returns: Collection with sorted periods
	public func sorted(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) -> TimePeriodCollection {
		let collection = TimePeriodCollection()
		collection.append(self.periods.sorted(by: areInIncreasingOrder))
		return collection
	}

	// MARK: - Collection Relationship

	/// Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
	/// whose start and end dates fall completely inside the interval of the given `TimePeriod`.
	///
	/// - Parameter period: The period to compare each other period against
	/// - Returns: Collection of periods inside the given period
	public func allInside(in period: TimePeriodProtocol) -> TimePeriodCollection {
		let collection = TimePeriodCollection()
		collection.periods = self.periods.filter({ $0.isInside(period) })
		return collection
	}

	/**
	*  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s containing
	*  the given date.
	*
	* - parameter date: The date to compare each period to
	*
	* - returns: Collection of periods intersected by the given date
	*/
	public func periodsIntersected(by date: DateInRegion) -> TimePeriodCollection {
		let collection = TimePeriodCollection()
		collection.periods = self.periods.filter({ $0.contains(date: date, interval: .closed) })
		return collection
	}

	/// Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
	/// containing either the start date or the end date--or both--of the given `TimePeriod`.
	///
	/// - Parameter period: The period to compare each other period to
	/// - Returns: Collection of periods intersected by the given period
	public func periodsIntersected(by period: TimePeriodProtocol) -> TimePeriodCollection {
		let collection = TimePeriodCollection()
		collection.periods = self.periods.filter({ $0.intersects(with: period) })
		return collection
	}

	// MARK: - Map

	public func map(_ transform: (TimePeriodProtocol) throws -> TimePeriodProtocol) rethrows -> TimePeriodCollection {
		var mappedArray = [TimePeriodProtocol]()
		mappedArray = try periods.map(transform)
		let mappedCollection = TimePeriodCollection()
		for period in mappedArray {
			mappedCollection.periods.append(period)
			mappedCollection.updateExtremes(period: period)
		}
		return mappedCollection
	}

	// MARK: - Helpers

	internal func updateExtremes(period: TimePeriodProtocol) {
		//Check incoming period against previous start and end date
		if self.count == 1 {
			self.start = period.start
			self.end = period.end
		} else {
			self.start = nilOrEarlier(date1: self.start, date2: period.start)
			self.end = nilOrLater(date1: self.end, date2: period.end)
		}

	}

	internal func updateExtremes() {
		if periods.count == 0 {
			self.start = nil
			self.end = nil
		} else {
			self.start = periods[0].start
			self.end = periods[0].end
			for i in 1..<periods.count {
				self.start = nilOrEarlier(date1: self.start, date2: periods[i].start)
				self.end = nilOrEarlier(date1: self.end, date2: periods[i].end)
			}
		}
	}

	internal func nilOrEarlier(date1: DateInRegion?, date2: DateInRegion?) -> DateInRegion? {
		if date1 == nil || date2 == nil {
			return nil
		} else {
			return date1!.earlierDate(date2!)
		}
	}

	internal func nilOrLater(date1: DateInRegion?, date2: DateInRegion?) -> DateInRegion? {
		if date1 == nil || date2 == nil {
			return nil
		} else {
			return date1!.laterDate(date2!)
		}
	}
}
