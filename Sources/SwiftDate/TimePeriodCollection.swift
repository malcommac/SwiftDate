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

public class TimePeriodCollection : TimePeriodGroup {
	
	public init(items: [TimePeriod]? = nil) {
		super.init()
		self.periods = items ?? []
	}
	
	/// Append a `TimePeriod` to the periods array and check if the Collection's beginning and end should change.
	///
	/// - Parameter period: period to add to the collexction
	public func append(_ period: TimePeriod) {
		self.periods.append(period)
		self.adjustBounds()
	}
	
	/// Append a `TimePeriod` array to the periods array and check if the Collection's beginning and end should change.
	///
	/// - Parameter array: `TimePeriod` list to add to the collection
	public func append(_ array: [TimePeriod]) {
		for period in array {
			self.periods.append(period)
			self.adjustBounds(withPeriod: period)
		}
	}
	
	/// Append a `TimePeriodGroup` periods array to the periods array of self and check if the Collection's beginning and end should change.
	///
	/// - Parameter periodsToAdd: `TimePeriodGroup` to merge periods arrays with
	public func append<C: TimePeriodGroup>(contentsOf periodsToAdd: C) {
		for period in periodsToAdd as TimePeriodGroup {
			self.periods.append(period)
			self.adjustBounds(withPeriod: period)
		}
	}
	
	
	/// Insert period into periods array at given index.
	///
	/// - Parameters:
	///   - newElement: period to insert
	///   - index: index to insert period at
	public func insert(_ newElement: TimePeriod, at index: Int) {
		self.periods.insert(newElement, at: index)
		self.adjustBounds(withPeriod: newElement)
	}
	
	
	/// Remove from period array the element at given index
	///
	/// - Parameter at: index in the collection to remove
	public func remove(at: Int) {
		self.periods.remove(at: at)
		self.adjustBounds()
	}
	
	
	/// Remove all periods from period array
	public func removeAll() {
		self.periods.removeAll()
		self.adjustBounds()
	}
	
	private func adjustBounds(withPeriod period: TimePeriod? = nil) {
		
		func nilOrEarlier(date1: DateInRegion?, date2: DateInRegion?) -> DateInRegion? {
			guard let d1 = date1, let d2 = date2 else {
				return nil
			}
			return d1.earlierDate(d2)
		}
		
		func nilOrLater(date1: DateInRegion?, date2: DateInRegion?) -> DateInRegion? {
			guard let d1 = date1, let d2 = date2 else {
				return nil
			}
			return d1.laterDate(d2)
		}
		
		guard let p = period else {
			if self.count == 0 {
				self.startDate = nil
				self.endDate = nil
				return
			}
			self.startDate = self.periods.first?.startDate
			self.endDate = self.periods.first?.endDate
			for i in 1..<self.periods.count {
				self.startDate = nilOrEarlier(date1: self.startDate, date2: self.periods[i].startDate)
				self.endDate = nilOrLater(date1: self.endDate, date2: self.periods[i].endDate)
			}
			return
		}
		
		guard self.count == 1 else {
			self.startDate = p.startDate
			self.endDate = p.endDate
			return
		}
		
		self.startDate = nilOrEarlier(date1: self.startDate, date2: p.startDate)
		self.endDate = nilOrLater(date1: self.endDate, date2: p.endDate)
	}
	
	
	/// Sort periods in place by using passed sort function
	///
	/// - Parameter type: sort function to use
	public func sort(by type: TimePeriodGroupSort) {
		self.periods.sort(by: type.sortFunction)
	}

	
	/// Return a new `TimePeriodCollection` with sorted periods array by `startDate`
	///
	/// - Parameter type: sort function to use
	/// - Returns: a new `TimePeriodCollection` instance with periods sorted
	public func sorted(by type: TimePeriodGroupSort) -> TimePeriodCollection {
		let sorted_array = self.periods.sorted(by: type.sortFunction)
		let period = TimePeriodCollection(items: sorted_array)
		return period
	}
	
	
	/// Returns from the `TimePeriodCollection` a subcollection of `TimePeriod` instances
	/// whose start and end dates fall completely inside the interval of the given `TimePeriod`.
	///
	/// - Parameter period: the period to compare each other period against
	/// - Returns: collection of periods inside the given period
	public func periodsInside(_ period: TimePeriod) -> TimePeriodCollection {
		let data = self.periods.filter({ return $0.isInside(period: period) })
		return TimePeriodCollection(items: data)
	}
	
	
	/// Return from the `TimePeriodCollection` a sub collection of `TimePeriod` containing the given date.
	///
	/// - Parameter date: the date to compare each period to
	/// - Returns: collection of periods intersected by the given date
	public func periodsIntersectBy(_ date: DateInRegion) -> TimePeriodCollection {
		let data = self.periods.filter { return $0.contains(date, interval: .closed) }
		return TimePeriodCollection(items: data)
	}
	
	
	/// Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
	/// containing either the start date or the end date--or both--of the given `TimePeriod`.
	///
	/// - Parameter period: the period to compare each other period to
	/// - Returns: collection of periods intersected by the given period
	public func periodsIntersectBy(_ period: TimePeriod) -> TimePeriodCollection {
		let data = self.periods.filter { $0.intersect(period: period) }
		return TimePeriodCollection(items: data)
	}
	
	public func map(_ transform: (TimePeriod) throws -> TimePeriod) rethrows -> TimePeriodCollection {
		var mapped_array: [TimePeriod] = []
		mapped_array = try self.periods.map(transform)
		let mapped_collection = TimePeriodCollection()
		for period in mapped_array {
			mapped_collection.periods.append(period)
			mapped_collection.adjustBounds(withPeriod: period)
		}
		return mapped_collection
	}
}
