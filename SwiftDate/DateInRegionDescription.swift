//
//  DateInRegionDescription.swift
//  Pods
//
//  Created by Jeroen Houtzager on 26/10/15.
//
//

import Foundation

// MARK: - CustomStringConvertable delegate

extension DateInRegion: CustomDebugStringConvertible {

    /// Returns a full description of the class
    ///
    public var description: String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .LongStyle
        formatter.locale = self.locale
        formatter.calendar = self.calendar
        formatter.timeZone = self.timeZone
        return formatter.stringFromDate(self.absoluteTime)
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
        formatter.timeZone = self.timeZone
        descriptor.append(formatter.stringFromDate(self.absoluteTime))

        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        descriptor.append("UTC\t\(formatter.stringFromDate(self.absoluteTime))")

        descriptor.append("Calendar: \(calendar.calendarIdentifier)")
        descriptor.append("Time zone: \(timeZone.name)")
        descriptor.append("Locale: \(locale.localeIdentifier)")

        return descriptor.joinWithSeparator("\n")
    }
    
}


