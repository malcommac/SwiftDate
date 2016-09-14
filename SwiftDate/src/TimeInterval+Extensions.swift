//
//  TimeInterval+Extensions.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 11/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

internal func componentsToSet(_ src: [Calendar.Component]) -> Set<Calendar.Component> {
	var l: Set<Calendar.Component> = []
	src.forEach { l.insert($0) }
	return l
}

public extension TimeInterval {
	
	public func `in`(_ components: [Calendar.Component], of calendar: Calendars? = nil) -> [Calendar.Component : Int] {
		let cal = calendar ?? Calendars.current
		let dateTo = Date()
		let dateFrom: Date = dateTo.addingTimeInterval(-self)
		let cmps = cal.calendar.dateComponents(componentsToSet(components), from: dateFrom, to: dateTo)
		return cmps.toComponentsDict()
	}
	
	public func `in`(_ component: Calendar.Component, of calendar: Calendars? = nil) -> Int? {
		let cal = calendar ?? Calendars.current
		let dateTo = Date()
		let dateFrom: Date = dateTo.addingTimeInterval(-self)
		let components: Set<Calendar.Component> = [component]
		let value = cal.calendar.dateComponents(components, from: dateFrom, to: dateTo).value(for: component)
		return value
	}

	public func string(unitStyle: DateComponentsFormatter.UnitsStyle = .short, max: Int? = nil, zero: DateZeroBehaviour? = nil, separator: String? = nil) throws -> String? {
		let formatter = DateInRegionFormatter()
		formatter.maxComponentCount = max
		formatter.unitStyle = unitStyle
		formatter.zeroBehavior = zero ?? .dropAll
		formatter.unitSeparator = separator ?? ","
		return try formatter.timeComponents(interval: self)
	}

}
