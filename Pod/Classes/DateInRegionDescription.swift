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
        return self.toString()!
    }

    /// Returns a full debug description of the class
    ///
    public var debugDescription: String {
        var descriptor: [String] = []

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
        dateFormatter.calendar = calendar
        dateFormatter.timeZone = timeZone
        descriptor.append("UTC\t\(self.date)")
        descriptor.append("Local\t\(dateFormatter.stringFromDate(self.date))")

        descriptor.append("Calendar: \(calendar.calendarIdentifier)")
        descriptor.append("Time zone: \(timeZone.name)")
        descriptor.append("Locale: \(locale.localeIdentifier)")

        return descriptor.joinWithSeparator("\n")
    }
    
}


