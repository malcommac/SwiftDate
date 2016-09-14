//
//  Extensions.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation


public extension String {
	
	public func date(format: DateFormat, fromRegion region: Region? = nil) throws -> DateInRegion {
		return try DateInRegion(string: self, format: format, fromRegion: region)
	}
	
}

internal extension String {
	
	internal func dotNETParseSeconds() -> TimeInterval? {
		let pattern = "\\/Date\\((-?\\d+)((?:[\\+\\-]\\d+)?)\\)\\/"
		do {
			let dotNetExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
			guard let match = dotNetExpression.firstMatch(in: self, options: .reportCompletion, range: NSMakeRange(0, self.characters.count)) else {
				return nil
			}
			let msRange = match.rangeAt(1)
			if msRange.location == NSNotFound { return nil }
			guard let range = self.range(from: msRange) else {
				return nil
			}
			let value = self.substring(with: range)
			let valueInSeconds = (TimeInterval(value)! / 1000.0)
			return valueInSeconds
		} catch {
			return nil
		}
	}
	
	internal func range(from nsRange: NSRange) -> Range<String.Index>? {
		guard
			let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
			let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
			let from = String.Index(from16, within: self),
			let to = String.Index(to16, within: self)
			else { return nil }
		return from ..< to
	}
}

public extension Int {
	
	internal func toDateComponents(type: Calendar.Component) -> DateComponents {
		var dateComponents = DateComponents()
		dateComponents.setValue(self, for: type)
		return dateComponents
	}

	
	public var nanoseconds: DateComponents {
		return self.toDateComponents(type: .nanosecond)
	}
	
	public var seconds: DateComponents {
		return self.toDateComponents(type: .second)
	}
	
	public var minutes: DateComponents {
		return self.toDateComponents(type: .minute)
	}
	
	public var hours: DateComponents {
		return self.toDateComponents(type: .hour)
	}
	
	public var days: DateComponents {
		return self.toDateComponents(type: .day)
	}
	
	public var weeks: DateComponents {
		return self.toDateComponents(type: .weekOfYear)
	}
	
	public var months: DateComponents {
		return self.toDateComponents(type: .month)
	}
	
	public var years: DateComponents {
		return self.toDateComponents(type: .year)
	}
}

