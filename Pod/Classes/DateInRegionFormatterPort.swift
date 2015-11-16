//
//  DateInRegionFormatterPort.swift
//  Pods
//
//  Created by Jeroen Houtzager on 01/11/15.
//
//

import Foundation

// MARK: - NSDateFormatter port

public extension DateInRegion {

    /// Returns a date representation of a given string interpreted using the receiver’s current settings.
    ///
    /// - Returns: A date representation of *string* interpreted using the receiver’s current settings.
    ///
    public func toString(format: String) -> String? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.locale = self.locale
        formatter.calendar = self.calendar
        formatter.timeZone = self.timeZone
        return formatter.stringFromDate(date)
    }

    public func toString(
        style: NSDateFormatterStyle? = nil,
        dateStyle: NSDateFormatterStyle? = nil,
        timeStyle: NSDateFormatterStyle? = nil) -> String? {

            let formatter = NSDateFormatter()
            formatter.dateStyle = style ?? dateStyle ?? .NoStyle
            formatter.timeStyle = style ?? timeStyle ?? .NoStyle
            if formatter.dateStyle == .NoStyle && formatter.timeStyle == .NoStyle {
                formatter.dateStyle = .MediumStyle
                formatter.timeStyle = .MediumStyle
            }
            formatter.locale = self.locale
            formatter.calendar = self.calendar
            formatter.timeZone = self.timeZone
            return formatter.stringFromDate(date)
    }

    /// Returns a relative date representation of a given string interpreted using the receiver’s current settings.
    /// If a date formatter uses relative date formatting, where possible it replaces the date component of its 
    /// output with a phrase—such as “today” or “tomorrow”—that indicates a relative date. The available phrases 
    /// depend on the locale for the date formatter; whereas, for dates in the future, English may only allow 
    /// “tomorrow,” French may allow “the day after the day after tomorrow,”.
    ///
    /// - Returns: A relative date representation of *string* interpreted using the receiver’s current settings.
    ///
    public func toRelativeString() -> String? {
        let formatter = NSDateFormatter()
        formatter.locale = self.locale
        formatter.calendar = self.calendar
        formatter.timeZone = self.timeZone
        formatter.dateStyle = .MediumStyle
        formatter.doesRelativeDateFormatting = true
        return formatter.stringFromDate(date)
    }
}