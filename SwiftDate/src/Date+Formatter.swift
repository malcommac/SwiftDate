//
//  Date+Formatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 15/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public extension Date {
	
	public func string(custom formatString: String) -> String {
		return self.string(format: .custom(formatString))
	}
	
	public func iso8601(options opts: ISO8601DateFormatter.Options) -> String {
		return self.string(format: .iso8601(options: opts))
	}
	
	public func string(format: DateFormat, in region: Region? = nil) -> String {
		let srcRegion = region ?? DateDefaultRegion
		return DateInRegion(absoluteDate: self, in: srcRegion).string(format: format)
	}
	
	public func string(toDate: Date, in region: Region? = nil, dateStyle: DateIntervalFormatter.Style, timeStyle: DateIntervalFormatter.Style) -> String {
		let srcRegion = region ?? DateDefaultRegion
		let srcDate = DateInRegion(absoluteDate: self, in: srcRegion)
		let toDateInRegion = DateInRegion(absoluteDate: toDate, in: srcRegion)
		return srcDate.string(toDate: toDateInRegion, dateStyle: dateStyle, timeStyle: timeStyle)
	}
	
	public func string(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium, in region: Region? = nil) -> String {
		let srcRegion = region ?? DateDefaultRegion
		return DateInRegion(absoluteDate: self, in: srcRegion).string(dateStyle: dateStyle, timeStyle: timeStyle)
	}
	
	public func colloquialSinceNow(in region: Region? = nil) throws -> (date: String, time: String?) {
		let srcRegion = region ?? DateDefaultRegion
		return try DateInRegion(absoluteDate: self, in: srcRegion).colloquialSinceNow()
	}
	
	public func colloquial(to: Date, in region: Region? = nil) throws -> (date: String, time: String?) {
		let srcRegion = region ?? DateDefaultRegion
		let toDateInRegion = DateInRegion(absoluteDate: to, in: srcRegion)
		return try DateInRegion(absoluteDate: self, in: srcRegion).colloquial(toDate: toDateInRegion)
	}
}
