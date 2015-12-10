//
//  SwiftDateDictionary.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 07/12/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

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


