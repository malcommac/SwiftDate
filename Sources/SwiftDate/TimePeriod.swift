//
//	SwiftDate, an handy tool to manage date and timezones in swift
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

public enum TimePeriodRelation {
	case After
	case StartTouching
	case StartInside
	case InsideStartTouching
	case EnclosingStartTouching
	case Enclosing
	case EnclosingEndTouching
	case ExtactMatch
	case Inside
	case InsideEndTouching
	case EndInside
	case EndTouching
	case Before
	case None
}

public enum TimePeriodSize {
	case Second
	case Minute
	case Hour
	case Day
	case Week
	case Month
	case Year
}

public enum TimePeriodInterval {
	case Open
	case Close
}

public enum TimeIntervalShift {
	case Earlier
	case Later
}

public enum TimePeriodAnchor {
	case Start
	case Center
	case End
}

public class TimePeriod: Equatable {
	public var startDate: DateInRegion!
	public var endDate: DateInRegion!
	
	public init(fromDate f: DateInRegion!, toDate t: DateInRegion!) {
		self.startDate = f
		self.endDate = t
	}
	
	public static func initWithLargePeriod() -> TimePeriod {
		let region = Region(timeZoneName: TimeZoneName.Gmt)
		let f = DateInRegion(absoluteTime: NSDate.distantPast(), region: region)
		let t = DateInRegion(absoluteTime: NSDate.distantFuture(), region: region)
		return TimePeriod(fromDate: f, toDate: t)
	}
	
	public func isEqualTo(period p: TimePeriod) -> Bool {
		return self == p
	}
	
	public func isInside(period p: TimePeriod) -> Bool {
		return p.startDate <= self.startDate && p.endDate >= self.endDate
	}
	
	public func contains(period p: TimePeriod) -> Bool {
		return self.startDate <= p.startDate && self.endDate >= p.endDate
	}
	
	public func overlapsWith(period p: TimePeriod) -> Bool {
		// Outside -> Inside
		if p.startDate <= self.startDate && p.endDate >= self.endDate {
			return true
		}
		// Enclosing
		if p.startDate >= self.startDate && p.endDate <= self.endDate {
			return true
		}
		// Inside->Out
		if p.startDate <= self.endDate && p.endDate > self.endDate {
			return true
		}
		return false
	}
	
	public func intersecs(period p: TimePeriod) -> Bool {
		// Outside -> Inside
		if p.startDate <= self.startDate && p.endDate >= self.endDate {
			return true
		}
		// Enclosing
		if p.startDate >= self.startDate && p.endDate <= self.endDate {
			return true
		}
		// Inside -> Out
		if p.startDate <= self.endDate && p.endDate > self.endDate {
			return true
		}
		return false
	}
	
	public func relationWith(period p: TimePeriod) -> TimePeriodRelation {
		guard self.startDate < self.endDate && p.startDate < p.endDate else { return .None }
		
		if p.endDate < self.startDate { return .StartTouching }
		if p.startDate < self.startDate && p.endDate < self.endDate { return .StartInside }
		if p.startDate == self.startDate && p.endDate > self.endDate { return .InsideStartTouching }
		if p.startDate == self.startDate && p.endDate < self.endDate { return .EnclosingStartTouching }
		if p.startDate > self.startDate && p.endDate < self.endDate { return .Enclosing }
		if p.startDate > self.startDate && p.endDate == self.endDate { return .EnclosingEndTouching }
		if p.startDate == self.startDate && p.endDate == self.endDate { return .ExtactMatch }
		if p.startDate < self.startDate && p.endDate > self.endDate { return .Inside }
		if p.startDate < self.startDate && p.endDate == self.endDate { return .InsideEndTouching }
		if p.startDate < self.endDate && p.endDate > self.endDate { return .EndInside }
		if p.startDate == self.endDate && p.endDate > self.endDate { return .EndTouching }
		if p.startDate > self.endDate { return .Before }
		return .None
	}
	
	public func gapWith(period p: TimePeriod) -> NSTimeInterval {
		if self.endDate < p.startDate { return fabs(self.endDate.absoluteTime.timeIntervalSinceDate(p.startDate.absoluteTime)) }
		if p.endDate < self.startDate { return fabs(p.endDate.absoluteTime.timeIntervalSinceDate(self.startDate.absoluteTime)) }
		return 0
	}
	
	public func containsDate(date d: DateInRegion, interval i: TimePeriodInterval = .Open) -> Bool {
		switch i {
		case .Open:
			return (self.startDate < d && self.endDate > d)
		case .Close:
			return (self.startDate <= d && self.endDate >= d)
		}
	}
	
	public func shiftPeriod(direction dir: TimeIntervalShift, by amount: Int = 1, of unit: NSCalendarUnit) {
		let incrementValue = (amount < 0 ? -amount : amount)
		self.startDate = self.startDate.add(components: [unit : incrementValue])
		self.endDate = self.endDate.add(components: [unit : incrementValue])
	}
	
	public func lengthenWithAnchor(anchor: TimePeriodAnchor, by amount: Int = 1, of unit: NSCalendarUnit) {
		switch anchor {
		case .Start:
			self.endDate = self.endDate.add(components: [unit : amount])
		case .Center:
			self.startDate = self.startDate.add(components: [unit : -(amount/2)])
			self.endDate = self.endDate.add(components: [unit : (amount/2)])
		case .End:
			self.startDate = self.startDate.add(components: [unit : -amount])
		}
	}
	
	public func shortenWithAnchor(anchor: TimePeriodAnchor, by amount: Int = 1, of unit: NSCalendarUnit) {
		switch anchor {
		case .Start:
			self.endDate = self.endDate.add(components: [unit : -amount])
		case .Center:
			self.startDate = self.startDate.add(components: [unit : (amount/2)])
			self.endDate = self.endDate.add(components: [unit : -(amount/2)])
		case .End:
			self.startDate = self.startDate.add(components: [unit : amount])
		}
	}
	
	public func durationIn(unit: NSCalendarUnit) -> NSInteger {
		return self.startDate.difference(self.endDate, unitFlags: [unit])!.valueForComponent(unit)
	}
	
}

public func ==(left: TimePeriod, right: TimePeriod) -> Bool {
	return left.startDate.isEqualToDate(right.startDate) && left.endDate.isEqualToDate(right.endDate)
}
