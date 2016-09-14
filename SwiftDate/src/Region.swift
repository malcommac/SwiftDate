//
//  Region.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public class Region {
	private(set) var timeZone: TimeZone
	private(set) var calendar: Calendar
	private(set) var locale: Locale
	
	private lazy var dateFormatter: DateFormatter = {
		let parser = DateFormatter()
		parser.timeZone = self.timeZone
		parser.calendar = self.calendar
		parser.locale = self.locale
		return parser
	}()
	
	private lazy var iso8601Formatter: ISO8601DateFormatter = {
		let parser = ISO8601DateFormatter()
		parser.timeZone = self.timeZone
		return parser
	}()
	
	private lazy var dateIntervalFormatter: DateIntervalFormatter = {
		let parser = DateIntervalFormatter()
		parser.timeZone = self.timeZone
		parser.calendar = self.calendar
		parser.locale = self.locale
		return parser
	}()
	
	public init(tz: TimeZone, cal: Calendar, loc: Locale) {
		self.timeZone = tz
		self.calendar = cal
		self.locale = loc
	}
	
	public init(tz: TimeZones, cal: Calendars, loc: Locales) {
		self.timeZone = tz.timeZone
		self.calendar = cal.calendar
		self.locale = loc.locale
	}
	
	public func copy() -> Region {
		let selfCopy = Region(tz: self.timeZone, cal: self.calendar, loc: self.locale)
		return selfCopy
	}
	
	public convenience init?(components: DateComponents) {
		guard let tz = components.timeZone, let cal = components.calendar, let loc = components.calendar?.locale else {
			return nil
		}
		self.init(tz: tz, cal: cal, loc: loc)
	}
	
	public static func GMT() -> Region {
		let tz = TimeZones.gmt.timeZone
		let cal = Calendars.current.calendar
		let loc = Locale.autoupdatingCurrent
		return Region(tz: tz, cal: cal, loc: loc)
	}
	
	public static func Local(autoUpdate auto: Bool = true) -> Region {
		let tz = (auto ? TimeZones.currentAutoUpdating : TimeZones.current).timeZone
		let cal = (auto ? Calendars.currentAutoUpdating : Calendars.current).calendar
		let loc = (auto ? Locale.autoupdatingCurrent : Locale.current)
		return Region(tz: tz, cal: cal, loc: loc)
	}
	
	internal func formatter(format: String? = nil) -> DateFormatter {
		if format != nil {
			self.dateFormatter.dateFormat = format!
		}
		return self.dateFormatter
	}
	
	internal func iso8601Formatter(options: ISO8601DateFormatter.Options) -> ISO8601DateFormatter {
		self.iso8601Formatter.formatOptions = options
		return self.iso8601Formatter
	}
	
	internal func intervalFormatter() -> DateIntervalFormatter {
		return self.dateIntervalFormatter
	}
}

extension Region: Equatable {}


public func == (left: Region, right: Region) -> Bool {
	if left.calendar.identifier != right.calendar.identifier {
		return false
	}
	
	if left.timeZone.identifier != right.timeZone.identifier {
		return false
	}
	
	if left.locale.identifier != right.locale.identifier {
		return false
	}
	
	return true
}
