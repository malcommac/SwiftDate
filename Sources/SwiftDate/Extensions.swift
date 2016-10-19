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

//MARK: - String Extension

public extension String {
	
	/// Allows you to transform a string to a DateInRegion object
	///
	/// - parameter format: format of the date string
	/// - parameter region: region in which you want to describe the date
	///
	/// - throws: throw an exception if DateInRegion cannot be created
	///
	/// - returns: a new DateInRegion representing passed string in given region
	public func date(format: DateFormat, fromRegion region: Region? = nil) throws -> DateInRegion {
		return try DateInRegion(string: self, format: format, fromRegion: region)
	}
	
}

//MARK: - String Extension PRIVATE

internal extension String {
	
	/// Return the number of seconds in a .NET date format
	///
	/// - returns: number of seconds represented by the string
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
	
	
	/// Substring with NSRange
	///
	/// - parameter nsRange: range
	///
	/// - returns: substring with given range
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

//MARK: Int Extension

/// This allows us to transform a literal number in a `DateComponents` and use it in math operations
/// For example `5.days` will create a new `DateComponents` where `.day = 5`.

public extension Int {
	
	/// Internal transformation function
	///
	/// - parameter type: component to use
	///
	/// - returns: return self value in form of `DateComponents` where given `Calendar.Component` has `self` as value
	internal func toDateComponents(type: Calendar.Component) -> DateComponents {
		var dateComponents = DateComponents()
		dateComponents.setValue(self, for: type)
		return dateComponents
	}

	
	/// Create a `DateComponents` with `self` value set as nanoseconds
	public var nanoseconds: DateComponents {
		return self.toDateComponents(type: .nanosecond)
	}
	
	/// Create a `DateComponents` with `self` value set as seconds
	public var seconds: DateComponents {
		return self.toDateComponents(type: .second)
	}
	
	/// Create a `DateComponents` with `self` value set as minutes
	public var minutes: DateComponents {
		return self.toDateComponents(type: .minute)
	}
	
	/// Create a `DateComponents` with `self` value set as hours
	public var hours: DateComponents {
		return self.toDateComponents(type: .hour)
	}
	
	/// Create a `DateComponents` with `self` value set as days
	public var days: DateComponents {
		return self.toDateComponents(type: .day)
	}
	
	/// Create a `DateComponents` with `self` value set as weeks
	public var weeks: DateComponents {
		return self.toDateComponents(type: .weekOfYear)
	}
	
	/// Create a `DateComponents` with `self` value set as months
	public var months: DateComponents {
		return self.toDateComponents(type: .month)
	}
	
	/// Create a `DateComponents` with `self` value set as years
	public var years: DateComponents {
		return self.toDateComponents(type: .year)
	}
}


/// Singular variations of Int extension for DateComponents for readability
/// - note these properties behave exactly as their plural-named equivalents

public extension Int {
    public var nanosecond: DateComponents { return nanoseconds }
    public var second: DateComponents { return seconds }
    public var minute: DateComponents { return minutes }
    public var hour: DateComponents { return hours }
    public var day: DateComponents { return days }
    public var week: DateComponents { return weeks }
    public var month: DateComponents { return months }
    public var year: DateComponents { return years }
}

