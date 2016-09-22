//
//  ISO8601Parser.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 22/09/2016.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public class ISO8601Parser {
	
	public struct Format: OptionSet {
		public let rawValue: Int

		public init(rawValue: Int) {
			self.rawValue = rawValue
		}
		
		static let withYear = ISO8601Parser.Format(rawValue: 1 << 0)
		static let withMonth = ISO8601Parser.Format(rawValue: 1 << 1)
		static let withWeekOfYear = ISO8601Parser.Format(rawValue: 1 << 2)
		static let withDay = ISO8601Parser.Format(rawValue: 1 << 3)
		static let withTime = ISO8601Parser.Format(rawValue: 1 << 4)
		static let withTimeZone = ISO8601Parser.Format(rawValue: 1 << 5)
		static let withSpaceBetweenDateAndTime = ISO8601Parser.Format(rawValue: 1 << 6)
		static let withDashSeparatorInDate = ISO8601Parser.Format(rawValue: 1 << 7)
		static let withFullDate = ISO8601Parser.Format(rawValue: 1 << 8)
		static let withFullTime = ISO8601Parser.Format(rawValue: 1 << 9)
		static let withInternetDateTime = ISO8601Parser.Format(rawValue: 1 << 10)
	}
	
	public var formatOptions: ISO8601Parser.Format = ISO8601Parser.Format(rawValue: 0)
	public var timeZone: TimeZone {
		set {
			self.formatter.timeZone = newValue
		}
		get {
			return self.formatter.timeZone
		}
	}
	private var formatter: DateFormatter = DateFormatter()
	
	public init() {
		self.timeZone = TimeZone(secondsFromGMT: 0)!
	}
	
	public func string(from date: Date) -> String {
		self.formatter.dateFormat = self.formatterString
		return self.formatter.string(from: date)
	}
	
	public func date(from string: String) -> Date? {
		self.formatter.dateFormat = self.formatterString
		return self.formatter.date(from: string)
	}
	
	public var formatterString: String {
		if self.formatOptions.contains(.withInternetDateTime) {
			return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		}

		var format: String = ""
		if self.formatOptions.contains(.withFullDate) {
			format += "yyyy-MM-dd"
		} else {
			if self.formatOptions.contains(.withYear) {
				if self.formatOptions.contains(.withMonth) || self.formatOptions.contains(.withDay) {
					format += "yyyy"
				} else {
					// not valid
				}
			}
			if self.formatOptions.contains(.withMonth) {
				if self.formatOptions.contains(.withYear) || self.formatOptions.contains(.withDay) || self.formatOptions.contains(.withWeekOfYear) {
					format += "MM"
				} else {
					// not valid
				}
			}
			if self.formatOptions.contains(.withWeekOfYear) {
				if self.formatOptions.contains(.withDay) {
					format += "'W'ww"
				} else {
					if self.formatOptions.contains(.withYear) || self.formatOptions.contains(.withMonth) {
						if self.formatOptions.contains(.withDashSeparatorInDate) {
							format += "-'W'w"
						} else {
							format += "'W'w"
						}
					} else {
						// not valid
					}
				}
			}
			
			if self.formatOptions.contains(.withDay) {
				if self.formatOptions.contains(.withWeekOfYear) {
					format += "FF"
				} else if self.formatOptions.contains(.withMonth) {
					format += "dd"
				} else if self.formatOptions.contains(.withYear) {
					if self.formatOptions.contains(.withDashSeparatorInDate) {
						format += "-DDD"
					} else {
						format += "DDD"
					}
				} else {
					// not valid
				}
			}
		}

		if self.formatOptions.contains(.withFullDate) && self.formatOptions.contains(.withFullTime) {
			if self.formatOptions.contains(.withSpaceBetweenDateAndTime) {
				format += " "
			} else {
				format += "'T'"
			}
		}
		
		if self.formatOptions.contains(.withFullTime) {
			format += "HH:mm:ssZZZZZ"
		} else {
			if self.formatOptions.contains(.withTime) {
				format += "HH:mm:ss"
			}
			if self.formatOptions.contains(.withTimeZone) {
				format += "ZZZZZ"
			}
		}
		
		return format
	}
}
