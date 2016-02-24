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

public extension NSTimeInterval {

	/// Returns an NSDate object initialized relative to the current date and time
	/// by a given number of seconds.
	public var fromNow: NSDate? {
		return NSDate(timeIntervalSinceNow: self)
	}

	/// Returns an NSDate object initialized relative to the current date and time
	/// by a given number of seconds in the past
	public var ago: NSDate? {
		return NSDate(timeIntervalSinceNow: -self)
	}

	/**
	Convert a time interval to a formatted string representing its absolute value

	- parameter style: style attributes to use

	- returns: a formatted string or nil if formatter fails
	*/
	public func toString(style: FormatterStyle = FormatterStyle()) -> String? {
		let formatter: NSDateComponentsFormatter = sharedDateComponentsFormatter()
		return formatter.beginSessionContext({ (Void) -> (String?) in
			style.restoreInto(formatter)
			return formatter.stringFromTimeInterval(self)
		})
	}
}
