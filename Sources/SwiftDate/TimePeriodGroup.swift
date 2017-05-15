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

public class TimePeriodGroup: Sequence, Equatable {
	
	/// The array of periods that define the group
	internal var periods: [TimePeriod] = []
	
	/// The earliest beginning date of a `TimePeriod` in the group
	/// `nil` if any `TimePeriod` in group has a nil start date (indefinite).
	internal(set) var startDate: DateInRegion?
	
	/// The latest end date of a `TimePeriod` in the group
	/// `nil` if any `TimePeriod` in group has a nil end date (indefinite).
	internal(set) var endDate: DateInRegion?
	
	/// Number of items into the group
	public var count: Int {
		return self.periods.count
	}
	
	public init() {
		
	}
	
	/// Returns an iterator over the elements of the collection.
	///
	/// - Returns: the iterator of the periods
	public func makeIterator() -> IndexingIterator<Array<TimePeriod>> {
		return self.periods.makeIterator()
	}
	
	public func map<T>(_ transform: (TimePeriod) throws -> T) rethrows -> [T] {
		return try self.periods.map(transform)
	}
	
	public func filter(_ isIncluded: (TimePeriod) throws -> Bool) rethrows -> [TimePeriod] {
		return try self.periods.filter(isIncluded)
	}
	
	public func forEach(_ body: (TimePeriod) throws -> Void) rethrows {
		return try self.periods.forEach(body)
	}
	
	public func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (TimePeriod) throws -> Bool) rethrows -> [AnySequence<TimePeriod>] {
		return try self.periods.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
	}
	
	subscript(index: Int) -> TimePeriod {
		get {
			return self.periods[index]
		}
	}
	
	public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriod) throws -> Result) rethrows -> Result {
		return try self.periods.reduce(initialResult, nextPartialResult)
	}
	
	/// The total amount of time between the earliest and latest dates stored in the
	/// periods array. `nil` if any beginning or end date in any contained period is `nil`.
	public var duration: TimeInterval? {
		guard let start = startDate, let end = endDate else {
			return nil
		}
		return end.absoluteDate.timeIntervalSince(start.absoluteDate)
	}
	
	/// Returns a Boolean value indicating whether two values are equal.
	///
	/// Equality is the inverse of inequality. For any values `a` and `b`,
	/// `a == b` implies that `a != b` is `false`.
	///
	/// - Parameters:
	///   - lhs: A value to compare.
	///   - rhs: Another value to compare.
	public static func ==(lhs: TimePeriodGroup, rhs: TimePeriodGroup) -> Bool {
		
		func compareElements(lhs: [TimePeriod], rhs: [TimePeriod]) -> Bool {
			guard lhs.count == rhs.count else { return false }
			
			func sortFunc(a: TimePeriod, b: TimePeriod) -> Bool {
				if a.startDate == nil && b.startDate == nil { return false }
				else if a.startDate == nil { return true }
				else if b.startDate == nil { return false }
				else { return b.startDate! < a.startDate! }
			}
			
			let sort_a = lhs.sorted(by: sortFunc)
			let sort_b = rhs.sorted(by: sortFunc)
			for x in 0..<sort_a.count {
				if sort_a[x] != sort_b[x] {
					return false
				}
			}
			return true
		}
		
		return compareElements(lhs: lhs.periods, rhs: rhs.periods)
	}
}
