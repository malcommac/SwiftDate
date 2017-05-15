//
//  TimePeriodChained.swift
//  SwiftDate
//
//  Created by daniele on 09/05/2017.
//  Copyright © 2017 Daniele Margutti. All rights reserved.
//

import Foundation

public class TimePeriodChained: TimePeriodGroup {
	
	public override func map<T>(_ transform: (TimePeriod) throws -> T) rethrows -> [T] {
		return try periods.map(transform)
	}
	
	public override func filter(_ isIncluded: (TimePeriod) throws -> Bool) rethrows -> [TimePeriod] {
		return try periods.filter(isIncluded)
	}
	
	public override func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriod) throws -> Result) rethrows -> Result {
		return try periods.reduce(initialResult, nextPartialResult)
	}
	
	/// Append a `TimePeriod` to the periods array and update the Chain's beginning and end.
	///
	/// - Parameter period: `TimePeriod` to add to the collection
	public func append(_ period: TimePeriod) {
		let start = self.count > 0 ? self.periods.last!.endDate! : period.startDate!
		let new_period = TimePeriod(from: start, duration: period.duration!)
		self.periods.append(new_period)
		self.adjustBounds(period)
	}
	
	/// Append a TimePeriodProtocol array to the periods array and update the Chain's beginning and end.
	///
	/// - Parameter group: TimePeriodProtocol list to add to the collection
	public func append<G: TimePeriodGroup>(contentsOf group: G) {
		group.periods.forEach { self.append($0) }
	}
	
	/// Insert period into periods array at given indesx
	///
	/// - Parameters:
	///   - period: period to insert
	///   - index: index to insert period at
	public func insert(_ period: TimePeriod, at index: Int) {
		if index == 0 && period.startDate != nil && period.endDate != nil {
			self.periods.insert(period, at: index)
		}
		else if period.startDate != nil && period.endDate != nil {
			self.periods.insert(period, at: index)
		}
		else {
			fatalError("All time periods in a chain must have a valid start/end date")
		}
		
		for i in 0..<self.periods.count {
			if i > index && i > 0 {
				let current = TimePeriod(from: period.startDate, to: period.endDate)
				self.periods[i].startDate = self.periods[i-1].endDate
				self.periods[i].endDate = self.periods[i].startDate?.add(interval: current.duration!)
			}
		}
		
		self.adjustBounds()
	}
	
	
	/// Remove from period array at the given index.
	///
	/// - Parameter index: index of the item to remove
	public func remove(at index: Int) {
		let duration = self.periods[index].duration!
		self.periods.remove(at: index)
		
		for i in index..<periods.count {
			self.periods[i].shift(byInterval: -duration)
		}
		self.adjustBounds()
	}
	
	/// Remove all periods from period array
	public func removeAll() {
		self.periods.removeAll()
		self.adjustBounds()
	}
	
	/// In place, shifts all chain time periods by a given time interval
	///
	/// - Parameter interval: The time interval expressed in seconds to shift the period by
	public func shift(by interval: TimeInterval) {
		for period in self.periods {
			period.shift(byInterval: interval)
		}
		self.startDate?.addInterval(interval)
		self.endDate?.addInterval(interval)
	}
	
	
	/// Removes the last object from the `TimePeriodChain` and returns it
	///
	/// - Returns: removed period
	public func pop() -> TimePeriod? {
		let period = self.periods.popLast()
		adjustBounds()
		return period
	}
	
	private func adjustBounds(_ period: TimePeriod? = nil) {
		guard let period = period else {
			self.startDate = self.periods.first?.startDate
			self.endDate = self.periods.last?.endDate
			return
		}
		
		guard self.periods.count != 1 else {
			self.startDate = period.startDate
			self.endDate = period.endDate
			return
		}
		self.endDate = self.endDate?.add(interval: period.duration!)
	}
	
	public static func ==(left: TimePeriodChained, right: TimePeriodChained) -> Bool {
		return left == right
	}

}
