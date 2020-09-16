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

/// Time period groups are the final abstraction of date and time in DateTools.
/// Here, time periods are gathered and organized into something useful.
/// There are two main types of time period groups, `TimePeriodCollection` and `TimePeriodChain`.
open class TimePeriodGroup: Sequence, Equatable {

	/// Array of periods that define the group.
	internal var periods: [TimePeriodProtocol] = []

	/// The earliest beginning date of a `TimePeriod` in the group.
	/// `nil` if any `TimePeriod` in group has a nil beginning date (indefinite).
	public internal(set) var start: DateInRegion?

	/// The latest end date of a `TimePeriod` in the group.
	/// `nil` if any `TimePeriod` in group has a nil end date (indefinite).
	public internal(set) var end: DateInRegion?

	/// The total amount of time between the earliest and latest dates stored in the periods array.
	/// `nil` if any beginning or end date in any contained period is `nil`.
	public var duration: TimeInterval? {
		guard let start = start, let end = end else { return nil }
		return end.timeIntervalSince(start)
	}

	/// The number of periods in the periods array.
	public var count: Int {
		return periods.count
	}

	// MARK: - Equatable

	public static func == (lhs: TimePeriodGroup, rhs: TimePeriodGroup) -> Bool {
		return TimePeriodGroup.hasSameElements(array1: lhs.periods, rhs.periods)
	}

	// MARK: - Initializers

	public init(_ periods: [TimePeriodProtocol]? = nil) {
		self.periods = (periods ?? [])
	}

	// MARK: - Sequence Protocol

	public func makeIterator() -> IndexingIterator<[TimePeriodProtocol]> {
		return periods.makeIterator()
	}

	public func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
		return try periods.map(transform)
	}

	public func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
		return try periods.filter(isIncluded)
	}

	public func forEach(_ body: (TimePeriodProtocol) throws -> Void) rethrows {
		return try periods.forEach(body)
	}

	public func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (TimePeriodProtocol) throws -> Bool) rethrows -> [AnySequence<TimePeriodProtocol>] {
		return try periods.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator).map(AnySequence.init)
	}

	public subscript(index: Int) -> TimePeriodProtocol {
		get {
			return periods[index]
		}
	}

	internal func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
		return try periods.reduce(initialResult, nextPartialResult)
	}

	// MARK: - Internal Helper Functions

	internal static func hasSameElements(array1: [TimePeriodProtocol], _ array2: [TimePeriodProtocol]) -> Bool {
		guard array1.count == array2.count else {
			return false // No need to sorting if they already have different counts
		}

		let compArray1: [TimePeriodProtocol] = array1.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
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
		let compArray2: [TimePeriodProtocol] = array2.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
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
		for x in 0..<compArray1.count {
			if !compArray1[x].equals(compArray2[x]) {
				return false
			}
		}
		return true
	}
}
