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


