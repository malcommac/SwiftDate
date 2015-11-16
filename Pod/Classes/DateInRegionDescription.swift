//
//  DateInRegionDescription.swift
//  Pods
//
//  Created by Jeroen Houtzager on 26/10/15.
//
//

import Foundation

// MARK: - CustomStringConvertable delegate

extension DateInRegion : CustomDebugStringConvertible {

    /// Returns a full description of the class
    ///
    public var description: String {
        return "\(self.toString()!); region: \(region)"
    }

    /// Returns a full debug description of the class
    ///
    public var debugDescription: String {
        var descriptor: [String] = []

        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .LongStyle
        formatter.locale = self.locale
        formatter.calendar = self.calendar
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        descriptor.append("UTC\t\(formatter.stringFromDate(self.date))")
        formatter.timeZone = self.timeZone
        descriptor.append("Local\t\(formatter.stringFromDate(self.date))")

        descriptor.append("Calendar: \(calendar.calendarIdentifier)")
        descriptor.append("Time zone: \(timeZone.name)")
        descriptor.append("Locale: \(locale.localeIdentifier)")

        return descriptor.joinWithSeparator("\n")
    }
    
}


