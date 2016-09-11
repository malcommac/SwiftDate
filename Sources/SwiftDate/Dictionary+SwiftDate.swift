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

// MARK: - Generate a Date from a Dictionary of NSCalendarUnit:Value

@available(*, deprecated: 3.0.5, message: "Use NSDateComponents instead")
public typealias DateComponentDictionary = [ Calendar.Component: Any ]

// MARK: - Extension: NSCalendarUnit -

protocol CalendarAsDictionaryKey: Hashable {}

extension Calendar.Component: CalendarAsDictionaryKey {
    public var hashValue: Int {
        get {
            return Int(self.rawValue)
        }
    }
}

extension Dictionary where Key: CalendarAsDictionaryKey {

    func components() -> DateComponents {
        var components = DateComponents()
        for (key, value) in self {
            if let value = value as? Int {
                if let key = key as? Calendar.Component {
                    components.setValue(value, for: key)
                }
            } else if let value = value as? Calendar {
                components.calendar = value
            } else if let value = value as? TimeZone {
                components.timeZone = value
            }
        }
        return components
    }

    /**
     Convert a dictionary of <NSCalendarUnit,Value> in a DateInRegion. Both timeZone and calendar
     must be specified into the dictionary. You can also specify a locale; if nil UTCRegion()'s
     locale will be used instead.

     - returns: DateInRegion if date components are complete, nil if cannot be used to generate a
        valid date
     */
    func dateInRegion() -> DateInRegion? {
        return DateInRegion(self.components())
    }

    func dateRegion() -> Region? {
        let components = self.components()

        let calendar = components.calendar ?? Calendar.current
        let timeZone = components.timeZone ?? TimeZone.current
        let locale = calendar.locale ?? Locale.current

        return Region(calendar: calendar, timeZone: timeZone, locale: locale)
    }

    /**
     Convert a dictionary of <NSCalendarUnit,Value> in absolute time NSDate instance. Both timeZone
     and calendar must be specified into the dictionary. You can also specify a locale; if nil
     default locale will be used instead.

     - returns: absolute time NSDate object, nil if dictionary values cannot be used to generate a
     valid date
     */
    func absoluteTime() -> Date? {
        let date = self.dateInRegion()
        return date?.absoluteTime
    }

}
