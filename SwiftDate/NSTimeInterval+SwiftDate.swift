//
//  NSTimeInterval+SwiftDate.swift
//  TestSwiftDate
//
//  Created by daniele on 16/01/16.
//  Copyright © 2016 daniele. All rights reserved.
//

import Foundation

public extension NSTimeInterval {
	
	/// Returns an NSDate object initialized relative to the current date and time by a given number of seconds.
	public var fromNow: NSDate? {
		return NSDate(timeIntervalSinceNow: self)
	}
	
	/// Returns an NSDate object initialized relative to the current date and time by a given number of seconds in the past
	public var ago: NSDate? {
		return NSDate(timeIntervalSinceNow: -self)
	}
	
	/**
	Convert a time interval to a formatted string representing its absolute value
	
	- parameter style: style attributes to use
	
	- returns: a formatted string or nil if formatter fails
	*/
	public func toString(style :FormatterStyle = FormatterStyle()) -> String? {
		let formatter :NSDateComponentsFormatter = sharedDateComponentsFormatter()
		return formatter.beginSessionContext({ (Void) -> (String?) in
			style.restoreInto(formatter)
			return formatter.stringFromTimeInterval(self)
		})
	}
}