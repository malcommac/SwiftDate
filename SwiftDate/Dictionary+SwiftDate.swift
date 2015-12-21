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

public typealias DateComponentDictionary = [ NSCalendarUnit: AnyObject ]

//MARK: - Extension: NSCalendarUnit -

protocol CalendarAsDictionaryKey: Hashable {}

extension NSCalendarUnit: CalendarAsDictionaryKey {
    public var hashValue: Int {
        get {
            return Int(self.rawValue)
        }
    }
}

extension Dictionary where Value: AnyObject, Key: CalendarAsDictionaryKey {
    
    func components() -> NSDateComponents {
        let components = NSDateComponents()
        for (key, value) in self {
            if let value = value as? Int {
                components.setValue(value, forComponent: key as! NSCalendarUnit)
            } else if let value = value as? NSCalendar {
                components.calendar = value
            } else if let value = value as? NSTimeZone {
                components.timeZone = value
            }
        }
        return components
    }
    
    /**
     Convert a dictionary of <NSCalendarUnit,Value> in a DateInRegion. Both timeZone and calendar must be specified into the dictionary. You can also specify a locale; if nil UTCRegion()'s locale will be used instead.
     
     - parameter locale: optional locale (Region().locale if nil)
     
     - returns: DateInRegion if date components are complete, nil if cannot be used to generate a valid date
     */
    func dateInRegion() -> DateInRegion? {
        return DateInRegion(self.components())
    }
    
    func dateRegion() -> DateRegion? {
        let components = self.components()
        
        return DateRegion(components)
    }
    
    /**
     Convert a dictionary of <NSCalendarUnit,Value> in absolute time NSDate instance. Both timeZone and calendar must be specified into the dictionary. You can also specify a locale; if nil UTCRegion()'s locale will be used instead.
     
     - returns: absolute time NSDate object, nil if dictionary values cannot be used to generate a valid date
     */
    func absoluteTime() -> NSDate? {
        let date = self.dateInRegion()
        return date?.absoluteTime
    }

}


