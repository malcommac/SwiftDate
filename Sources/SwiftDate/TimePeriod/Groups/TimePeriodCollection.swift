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

/// Sort type
///
/// - ascending: sort in ascending order
/// - descending: sort in descending order
public enum SortMode {
	case ascending
	case descending
}

/// Sorting type
///
/// - start: sort by start date
/// - end: sort by end date
/// - duration: sort by duration
/// - custom: sort using custom function
public enum SortType {
	case start(_: SortMode)
	case end(_: SortMode)
	case duration(_: SortMode)
	case custom(_: ((TimePeriodProtocol, TimePeriodProtocol) -> Bool))
}

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

	/// Sort elements in place using given method.
	///
	/// - Parameter type: sorting method
	public func sort(by type: SortType) {
		switch type {
		case .duration(let mode):	periods.sort(by: sortFuncDuration(mode))
		case .start(let mode):		periods.sort(by: sortFunc(byStart: true, type: mode))
		case .end(let mode):		periods.sort(by: sortFunc(byStart: false, type: mode))
		case .custom(let f):		periods.sort(by: f)
		}
	}

	/// Generate a new `TimePeriodCollection` where items are sorted with specified method.
	///
	/// - Parameters:
	///   - type: sorting method
	/// - Returns: collection ordered by given function
	public func sorted(by type: SortType) -> TimePeriodCollection {
		var sortedList: [TimePeriodProtocol]!
		switch type {
		case .duration(let mode):	sortedList = periods.sorted(by: sortFuncDuration(mode))
		case .start(let mode):		sortedList = periods.sorted(by: sortFunc(byStart: true, type: mode))
		case .end(let mode):		sortedList = periods.sorted(by: sortFunc(byStart: false, type: mode))
		case .custom(let f):		sortedList = periods.sorted(by: f)
		}
		return TimePeriodCollection(sortedList)
	}

	// MARK: - Collection Relationship

	/// Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
	/// whose start and end dates fall completely inside the interval of the given `TimePeriod`.
	///
	/// - Parameter period: The period to compare each other period against
	/// - Returns: Collection of periods inside the given period
	public func periodsInside(period: TimePeriodProtocol) -> TimePeriodCollection {
		return TimePeriodCollection(periods.filter({ $0.isInside(period) }))
	}

	//  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s containing the given date.
	///
	/// - Parameter date: The date to compare each period to
	/// - Returns: Collection of periods intersected by the given date
	public func periodsIntersected(by date: DateInRegion) -> TimePeriodCollection {
		return TimePeriodCollection(periods.filter({ $0.contains(date: date, interval: .closed) }))
	}

	/// Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
	/// containing either the start date or the end date--or both--of the given `TimePeriod`.
	///
	/// - Parameter period: The period to compare each other period to
	/// - Returns: Collection of periods intersected by the given period
	public func periodsIntersected(by period: TimePeriodProtocol) -> TimePeriodCollection {
		return TimePeriodCollection(periods.filter({ $0.intersects(with: period) }))
	}

	/// Returns an instance of DTTimePeriodCollection with all the time periods in the receiver that overlap a given time period.
	/// Overlap with the given time period does NOT include other time periods that simply touch it.
	/// (i.e. one's start date is equal to another's end date)
	///
	/// - Parameter period: The time period to check against the receiver's time periods.
	/// - Returns: Collection of periods overlapped by the given period
	public func periodsOverlappedBy(_ period: TimePeriodProtocol) -> TimePeriodCollection {
		return TimePeriodCollection(periods.filter({ $0.overlaps(with: period) }))
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

	private func sortFuncDuration(_ type: SortMode) -> ((TimePeriodProtocol, TimePeriodProtocol) -> Bool) {
		switch type {
		case .ascending: 	return { $0.duration < $1.duration }
		case .descending: 	return { $0.duration > $1.duration }
		}
	}

	private func sortFunc(byStart start: Bool = true, type: SortMode) -> ((TimePeriodProtocol, TimePeriodProtocol) -> Bool) {
		return {
			let date0 = (start ? $0.start : $0.end)
			let date1 = (start ? $1.start : $1.end)
			if date0 == nil && date1 == nil {
				return false
			} else if date0 == nil {
				return true
			} else if date1 == nil {
				return false
			} else {
				return (type == .ascending ? date1! > date0! : date0! > date1!)
			}
		}
	}

	private func updateExtremes(period: TimePeriodProtocol) {
		//Check incoming period against previous start and end date
		guard count != 1 else {
			start = period.start
			end = period.end
			return
		}
		start = nilOrEarlier(date1: start, date2: period.start)
		end = nilOrLater(date1: end, date2: period.end)
	}

	private func updateExtremes() {
		guard periods.count > 0 else {
			start = nil
			end = nil
			return
		}

		start = periods.first!.start
		end = periods.first!.end
		for i in 1..<periods.count {
			start = nilOrEarlier(date1: start, date2: periods[i].start)
			end = nilOrEarlier(date1: end, date2: periods[i].end)
		}
	}

	private func nilOrEarlier(date1: DateInRegion?, date2: DateInRegion?) -> DateInRegion? {
		guard date1 != nil && date2 != nil else { return nil }
		return date1!.earlierDate(date2!)
	}

	private func nilOrLater(date1: DateInRegion?, date2: DateInRegion?) -> DateInRegion? {
		guard date1 != nil && date2 != nil else { return nil }
		return date1!.laterDate(date2!)
	}

}
