//
//  DateInRegion+Formatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 11/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public extension DateInRegion {
	
	public func string(format: DateFormat) -> String {
		switch format {
		case .custom(let format):
			return self.region.formatter(format: format).string(from: self.absoluteDate)
		case .iso8601(let options):
			return self.region.iso8601Formatter(options: options).string(from: self.absoluteDate)
		case .rss(let isAltRSS):
			let format = (isAltRSS ? "d MMM yyyy HH:mm:ss ZZZ" : "EEE, d MMM yyyy HH:mm:ss ZZZ")
			return self.region.formatter(format: format).string(from: self.absoluteDate)
		case .extended:
			let format = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
			return self.region.formatter(format: format).string(from: self.absoluteDate)
		case .dotNET:
			let milliseconds = (self.absoluteDate.timeIntervalSince1970 * 1000.0)
			let tzOffsets = (self.region.timeZone.secondsFromGMT(for: self.absoluteDate) / 3600)
			let formattedStr = String(format: "/Date(%.0f%+03d00)/", milliseconds,tzOffsets)
			return formattedStr
		}
	}
	
	public func string(toDate date: DateInRegion, dateStyle: DateIntervalFormatter.Style, timeStyle: DateIntervalFormatter.Style) -> String {
		let formatter = self.region.intervalFormatter()
		formatter.dateStyle = dateStyle
		formatter.timeStyle = timeStyle
		return formatter.string(from: self.absoluteDate, to: date.absoluteDate)
	}
	
	public func string(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
		let formatter = self.region.formatter()
		formatter.dateStyle = dateStyle
		formatter.timeStyle = timeStyle
		return formatter.string(from: self.absoluteDate)
	}
	
	public func colloquialSinceNow() throws -> (date: String, time: String?) {
		let formatter = DateInRegionFormatter()
		let now = DateInRegion(absoluteDate: Date(), in: self.region.copy())
		return try formatter.colloquial(from: self, to: now)
	}
	
	public func colloquial(toDate date: DateInRegion) throws -> (date: String, time: String?) {
		let formatter = DateInRegionFormatter()
		return try formatter.colloquial(from: self, to: date)
	}
}
