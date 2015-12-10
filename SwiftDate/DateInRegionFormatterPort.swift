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
        return formatter.stringFromDate(absoluteTime)
    }
}

//MARK: - From DateInRegion to String -

public extension DateInRegion {
    
    /**
     Return an ISO8601 string from current UTC Date of the region
     
     - returns: a new string or nil if DateInRegion does not contains any valid date
     */
    public func toISO8601String() -> String? {
        guard let _ = absoluteTime else {
            return nil
        }
        let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
        
        cachedFormatter.formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        cachedFormatter.formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        cachedFormatter.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let value = cachedFormatter.formatter.stringFromDate(absoluteTime).stringByAppendingString("Z")
        
        cachedFormatter.restoreState()
        return value
    }
    
    /**
     Convert a DateInRegion to a string using region's timezone, locale and calendar
     
     - parameter dateFormat: format of the string
     
     - returns: a new string or nil if DateInRegion does not contains any valid date
     */
    public func toString(dateFormat: DateFormat!) -> String? {
        guard let _ = absoluteTime else {
            return nil
        }
        let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
        
        let dateFormatString = dateFormat.formatString
        cachedFormatter.formatter.dateFormat = dateFormatString
        cachedFormatter.formatter.timeZone = region.timeZone
        cachedFormatter.formatter.calendar = region.calendar
        cachedFormatter.formatter.calendar.locale = region.calendar.locale
        let value = cachedFormatter.formatter.stringFromDate(self.absoluteTime!)
        
        cachedFormatter.restoreState()
        return value
    }
    
    /**
     Convert a DateInRegion date into a date with date & time style specific format style
     
     - parameter style: style to format both date and time (if you specify this you don't need to specify dateStyle,timeStyle)
     - parameter dateStyle: style to format the date
     - parameter timeStyle: style to format the time
     
     - returns: a new string which represent the date expressed into the current region or nil if region does not contain valid date
     */
    public func toString(style: NSDateFormatterStyle? = nil, dateStyle: NSDateFormatterStyle? = nil, timeStyle: NSDateFormatterStyle? = nil) -> String? {
        guard let _ = absoluteTime else {
            return nil
        }
        let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
        
        cachedFormatter.formatter.dateStyle = style ?? dateStyle ?? .NoStyle
        cachedFormatter.formatter.timeStyle = style ?? timeStyle ?? .NoStyle
        if cachedFormatter.formatter.dateStyle == .NoStyle && cachedFormatter.formatter.timeStyle == .NoStyle {
            cachedFormatter.formatter.dateStyle = .MediumStyle
            cachedFormatter.formatter.timeStyle = .MediumStyle
        }
        cachedFormatter.formatter.locale = region.locale
        cachedFormatter.formatter.calendar = region.calendar
        cachedFormatter.formatter.timeZone = region.timeZone
        let value = cachedFormatter.formatter.stringFromDate(absoluteTime)
        
        cachedFormatter.restoreState()
        return value
    }
    
    public func toShortString(date: Bool? = true, time: Bool? = true) -> String? {
        return toString(dateStyle: (date == true ? NSDateFormatterStyle.ShortStyle: NSDateFormatterStyle.NoStyle),
            timeStyle: (time == true ? NSDateFormatterStyle.ShortStyle: NSDateFormatterStyle.NoStyle))
    }
    
    public func toMediumString(date: Bool? = true, time: Bool? = true) -> String? {
        return toString(dateStyle: (date == true ? NSDateFormatterStyle.MediumStyle: NSDateFormatterStyle.NoStyle),
            timeStyle: (time == true ? NSDateFormatterStyle.MediumStyle: NSDateFormatterStyle.NoStyle))
    }
    
    public func toLongString(date: Bool? = true, time: Bool? = true) -> String? {
        return toString(dateStyle: (date == true ? NSDateFormatterStyle.LongStyle: NSDateFormatterStyle.NoStyle),
            timeStyle: (time == true ? NSDateFormatterStyle.LongStyle: NSDateFormatterStyle.NoStyle))
    }
    
    public func toRelativeCocoaString() -> String? {
        let formatter = NSDateFormatter()
        formatter.locale = region.locale
        formatter.calendar = region.calendar
        formatter.timeZone = region.timeZone
        formatter.dateStyle = .MediumStyle
        formatter.doesRelativeDateFormatting = true
        return formatter.stringFromDate(absoluteTime)
    }
    
    public func toRelativeString(fromDate: DateInRegion!, abbreviated: Bool = false, maxUnits: Int = 1) -> String {
        let seconds = fromDate.absoluteTime.timeIntervalSinceDate(absoluteTime)
        if fabs(seconds) < 1 {
            return "just now"._sdLocalize
        }
        
        let significantFlags: NSCalendarUnit = DateInRegion.componentFlags
        let components = region.calendar.components(significantFlags, fromDate: fromDate.absoluteTime, toDate: absoluteTime, options: [])
        
        var string = String()
        var numberOfUnits:Int = 0
        let unitList: [String] = ["year", "month", "weekOfYear", "day", "hour", "minute", "second", "nanosecond"]
        for unitName in unitList {
            let unit: NSCalendarUnit = unitName._sdToCalendarUnit()
            if ((significantFlags.rawValue & unit.rawValue) != 0) &&
                (absoluteTime._sdCompareCalendarUnit(NSCalendarUnit.Nanosecond, other: unit) != .OrderedDescending) {
                    let number:NSNumber = NSNumber(float: fabsf(components.valueForKey(unitName)!.floatValue))
                    if Bool(number.integerValue) {
                        let singular = (number.unsignedIntegerValue == 1)
                        let suffix = String(format: "%@ %@", arguments: [number, absoluteTime._sdLocalizeStringForValue(singular, unit: unit, abbreviated: abbreviated)])
                        if string.isEmpty {
                            string = suffix
                        } else if numberOfUnits < maxUnits {
                            string += String(format: " %@", arguments: [suffix])
                        }
                        numberOfUnits += 1
                    }
            }
        }
        return string
    }
}

//MARK: - DateInRegion Formatters -

public extension String {
    
    /**
     Convert a string into NSDate by passing conversion format
     
     - parameter format: format used to parse the string
     
     - returns: a new NSDate instance or nil if something went wrong during parsing
     */
    public func toDate(format: DateFormat) -> NSDate? {
        return self.toDateInRegion(format)?.absoluteTime
    }
    
    /**
     Convert a string into NSDate by passing conversion format
     
     - parameter format: format used to parse the string
     
     - returns: a new NSDate instance or nil if something went wrong during parsing
     */
    public func toDateInRegion(format: DateFormat) -> DateInRegion? {
        return DateInRegion(fromString: self, format: format)
    }
    
    /**
     Convert a string which represent an ISO8601 date into NSDate
     
     - returns: NSDate instance or nil if string cannot be parsed
     */
    public func toDateFromISO8601() -> NSDate? {
        return toDate(DateFormat.ISO8601)
    }
    
    var _sdLocalize: String {
        return NSBundle.mainBundle().localizedStringForKey(self, value: nil, table: "SwiftDate")
    }
    
    func _sdToCalendarUnit() -> NSCalendarUnit {
        switch self {
        case "year":
            return NSCalendarUnit.Year
        case "month":
            return NSCalendarUnit.Month
        case "weekOfYear":
            return NSCalendarUnit.WeekOfYear
        case "day":
            return NSCalendarUnit.Day
        case "hour":
            return NSCalendarUnit.Hour
        case "minute":
            return NSCalendarUnit.Minute
        case "second":
            return NSCalendarUnit.Second
        case "nanosecond":
            return NSCalendarUnit.Nanosecond
        default:
            return []
        }
    }
}


internal extension NSDate {
    func _sdCompareCalendarUnit(unit:NSCalendarUnit, other:NSCalendarUnit) -> NSComparisonResult {
        let nUnit = _sdNormalizedCalendarUnit(unit)
        let nOther = _sdNormalizedCalendarUnit(other)
        
        if (nUnit == NSCalendarUnit.WeekOfYear) != (nOther == NSCalendarUnit.WeekOfYear) {
            if nUnit == NSCalendarUnit.WeekOfYear {
                switch nUnit {
                case NSCalendarUnit.Year, NSCalendarUnit.Month:
                    return .OrderedAscending
                default:
                    return .OrderedDescending
                }
            } else {
                switch nOther {
                case NSCalendarUnit.Year, NSCalendarUnit.Month:
                    return .OrderedDescending
                default:
                    return .OrderedAscending
                }
            }
        } else {
            if nUnit.rawValue > nOther.rawValue {
                return .OrderedAscending
            } else if (nUnit.rawValue < nOther.rawValue) {
                return .OrderedDescending
            } else {
                return .OrderedSame
            }
        }
    }
    
    private func _sdNormalizedCalendarUnit(unit:NSCalendarUnit) -> NSCalendarUnit {
        switch unit {
        case NSCalendarUnit.WeekOfMonth, NSCalendarUnit.WeekOfYear:
            return NSCalendarUnit.WeekOfYear
        case NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal:
            return NSCalendarUnit.Day
        default:
            return unit;
        }
    }
    
    
    func _sdLocalizeStringForValue(singular: Bool, unit: NSCalendarUnit, abbreviated: Bool = false) -> String {
        var toTranslate: String = ""
        switch unit {
            
        case NSCalendarUnit.Year where singular:		toTranslate = (abbreviated ? "yr": "year")
        case NSCalendarUnit.Year where !singular:		toTranslate = (abbreviated ? "yrs": "years")
            
        case NSCalendarUnit.Month where singular:		toTranslate = (abbreviated ? "mo": "month")
        case NSCalendarUnit.Month where !singular:		toTranslate = (abbreviated ? "mos": "months")
            
        case NSCalendarUnit.WeekOfYear where singular:	toTranslate = (abbreviated ? "wk": "week")
        case NSCalendarUnit.WeekOfYear where !singular: toTranslate = (abbreviated ? "wks": "weeks")
            
        case NSCalendarUnit.Day where singular:			toTranslate = "day"
        case NSCalendarUnit.Day where !singular:		toTranslate = "days"
            
        case NSCalendarUnit.Hour where singular:		toTranslate = (abbreviated ? "hr": "hour")
        case NSCalendarUnit.Hour where !singular:		toTranslate = (abbreviated ? "hrs": "hours")
            
        case NSCalendarUnit.Minute where singular:		toTranslate = (abbreviated ? "min": "minute")
        case NSCalendarUnit.Minute where !singular:		toTranslate = (abbreviated ? "mins": "minutes")
            
        case NSCalendarUnit.Second where singular:		toTranslate = (abbreviated ? "s": "second")
        case NSCalendarUnit.Second where !singular:		toTranslate = (abbreviated ? "s": "seconds")
            
        case NSCalendarUnit.Nanosecond where singular:		toTranslate = (abbreviated ? "ns": "nanosecond")
        case NSCalendarUnit.Nanosecond where !singular:		toTranslate = (abbreviated ? "ns": "nanoseconds")
            
        default:													toTranslate = ""
        }
        return toTranslate._sdLocalize
    }
    
    func localizedSimpleStringForComponents(components:NSDateComponents) -> String {
        if (components.year == -1) {
            return "last year"._sdLocalize
        } else if (components.month == -1 && components.year == 0) {
            return "last month"._sdLocalize
        } else if (components.weekOfYear == -1 && components.year == 0 && components.month == 0) {
            return "last week"._sdLocalize
        } else if (components.day == -1 && components.year == 0 && components.month == 0 && components.weekOfYear == 0) {
            return "yesterday"._sdLocalize
        } else if (components == 1) {
            return "next year"._sdLocalize
        } else if (components.month == 1 && components.year == 0) {
            return "next month"._sdLocalize
        } else if (components.weekOfYear == 1 && components.year == 0 && components.month == 0) {
            return "next week"._sdLocalize
        } else if (components.day == 1 && components.year == 0 && components.month == 0 && components.weekOfYear == 0) {
            return "tomorrow"._sdLocalize
        }
        return ""
    }
}


