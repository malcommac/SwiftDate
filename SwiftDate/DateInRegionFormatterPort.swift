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

/**
Date Formatting Style

- Short:   Shortest representation
- Default: Default representation
- Long:    Long colloquial representation
- Full:    Very long representation which include other detailed info
*/
public enum DateFormatterStyle {
	case Short
	case Default
	case Long
	case Full
}

//MARK: - From DateInRegion to String -

public extension String {

	/**
	Localize a string aganist SDLocalizable.strings file
	
	- parameter argList: variable arguments list
	
	- returns: localized version of the string
	*/
	internal func sd_loc(argList: CVarArgType...) -> String {
		let bundle = NSBundle(forClass: DateInRegion.self)
		let value = NSLocalizedString(self, tableName: "SDLocalizable", bundle: bundle, value: "", comment: "")
		return withVaList(argList) {
			NSString(format: value, locale: NSLocale.currentLocale(), arguments: $0)
		} as String
	}
}

public extension DateInRegion {
	
	/**
	Natural language representation of the difference between two dates (self and refDate)
	
	- parameter refDate: reference date (if not specified a new DateInRegion with current date will be used instead)
	- parameter style:   style of the formatter
	
	- returns: natural representation of the string
	*/
	public func toNaturalString(refDate :DateInRegion = DateInRegion(), style :DateFormatterStyle = .Default) -> String {
		let min = difference(refDate, unitFlags: .Minute)!.minute
		let hours = difference(refDate, unitFlags: .Hour)!.hour
		let days = difference(refDate, unitFlags: .Day)!.day
		let weeks = difference(refDate, unitFlags: .WeekdayOrdinal)!.weekdayOrdinal
		let months = difference(refDate, unitFlags: .Month)!.month
		
		if min < 1 { // Less than 1 minute ago
			let sec = difference(refDate, unitFlags: .Second)!.second
			let suffix = (sec == 1 ? "S" : "P")
			switch style {
			case .Short:		return "N_NOW_SHORT_\(suffix)".sd_loc()
			case .Default:		return "N_NOW_DEFAULT_\(suffix)".sd_loc()
			case .Long:			return "N_NOW_LONG_\(suffix)".sd_loc(sec)
			case .Full:			return "N_NOW_FULL_\(suffix)".sd_loc(sec)
			}
		}
		else if min < 60 { // Less than 1 hour ago
			let suffix = (min == 1 ? "S" : "P")
			switch style {
			case .Short:		return "N_1H_SHORT_\(suffix)".sd_loc(min)
			case .Default:		return "N_1H_DEFAULT_\(suffix)".sd_loc(min)
			case .Long:			return "N_1H_LONG_\(suffix)".sd_loc(min)
			case .Full:
				let sec = difference(refDate, unitFlags: .Second)!.second
				return "N_1H_FULL".sd_loc(	"N_1H_LONG_\(suffix)".sd_loc(min),"N_NOW_LONG_\(suffix)".sd_loc(sec))
			}
		}
		else if hours < 24 { // Less than 24 hours ago
			let suffix = (hours == 1 ? "S" : "P")
			switch style {
			case .Short:		return "N_24H_SHORT_\(suffix)".sd_loc(hours)
			case .Default:		return "N_24H_DEFAULT_\(suffix)".sd_loc(hours)
			case .Long:			return "N_24H_LONG_\(suffix)".sd_loc(hours)
			case .Full:
				let time = self.toString(DateFormat.Custom("TIMEFORMAT".sd_loc()))!
				return "N_24H_FULL_\(suffix)".sd_loc(hours,time)
			}
		}
		else if hours < 48 { // Less than 48 hours ago
			switch style {
			case .Short:		return "N_48H_SHORT".sd_loc()
			case .Default:		return "N_48H_DEFAULT".sd_loc()
			case .Long:
				let time = self.toString(DateFormat.Custom("TIMEFORMAT".sd_loc()))!
				return "N_48H_LONG".sd_loc(time)
			case .Full:
				let time = self.toString(DateFormat.Custom("TIMEFORMAT".sd_loc()))!
				return "N_48H_FULL".sd_loc(time)
			}
		}
		else if days < 7 { // Less than 7 days ago
			let suffix = (days == 1 ? "S" : "P")
			let time = self.toString(DateFormat.Custom("TIMEFORMAT".sd_loc()))!
			switch style {
			case .Short:		return "N_1W_SHORT_\(suffix)".sd_loc(days)
			case .Default:		return "N_1W_DEFAULT_\(suffix)".sd_loc(days)
			case .Long:			return "N_1W_LONG_\(suffix)".sd_loc("TIMEFORMAT".sd_loc(time))
			case .Full:			return "N_1W_FULL_\(suffix)".sd_loc("TIMEFORMAT".sd_loc(time))
			}
		}
		else if weeks < 4 { // Less than 1 month ago
			let suffix = (weeks == 1 ? "S" : "P")
			switch style {
			case .Short:		return "N_4W_SHORT_\(suffix)".sd_loc(weeks)
			case .Default:		return "N_4W_DEFAULT_\(suffix)".sd_loc(weeks)
			case .Long:			return "N_4W_LONG_\(suffix)".sd_loc(weeks)
			case .Full:
				let date = self.toString(DateFormat.Custom("DATEFORMAT_DAYNAME".sd_loc()))!
				return "N_4W_FULL_\(suffix)".sd_loc(weeks,date)
			}
		} else if months < 12 { // Less than 1 year ago
			let suffix = (months == 1 ? "S" : "P")
			switch style {
			case .Short:		return "N_1Y_SHORT_\(suffix)".sd_loc(months)
			case .Default:		return "N_1Y_DEFAULT_\(suffix)".sd_loc(months)
			case .Long:			return "N_1Y_LONG_\(suffix)".sd_loc(months)
			case .Full:
				let date = self.toString(DateFormat.Custom("DATEFORMAT_MONTHNAME_TIME".sd_loc()))!
				return "N_1Y_FULL_\(suffix)".sd_loc(months,date)
			}
		} else { // 1 year or over
			let years = difference(refDate, unitFlags: .Year)!.year
			let suffix = (years == 1 ? "S" : "P")
			switch style {
			case .Short:		return "N_MY_SHORT_\(suffix)".sd_loc(years)
			case .Default:		return "N_MY_DEFAULT_\(suffix)".sd_loc(years)
			case .Long:			return "N_MY_LONG_\(suffix)".sd_loc(years)
			case .Full:
				let date = self.toString(DateFormat.Custom("DATEFORMAT_MONTHNAME".sd_loc()))!
				return "N_MY_FULL_\(suffix)".sd_loc(self.year!,date)
			}
		}
	}
	
	/**
	Return a list components which express the difference in term of each
	
	- parameter refDate: reference date. if missing default new DateInRegion() is used instead
	- parameter units:   units to get. Units are enumerated in order so resulting array has the same order of the specified unit. If missing [Nanosecond,Second,Minute,Hour,Day,WeekOfMonth,Month,Year] is used as default configuration. Only units with a value different from 0 are included into the final array.
	- parameter maxUnits: if specified only the first maxUnits with a non null value will be part of the final array (units are enumerated in order as specified by units param)
	- parameter style:	style used to print unit of measurement
	
	- returns: an array of translated measurement units or nil if all specified components are null
	*/
	public func toComponentsStrings(refDate :DateInRegion = DateInRegion(), units :[NSCalendarUnit]? = nil, maxUnits cUnits :Int = 0, style :DateFormatterStyle = .Default) -> [String]? {
		
		var cmps :[String] = []
		let unitsToCompare = (units != nil ? units! : [.Nanosecond, .Second, .Minute, .Hour, .Day, .WeekOfMonth, .Month, .Year])
		let diff = difference(refDate, unitFlags: NSCalendarUnit(unitsToCompare))
		let translate_style = translateStyle(style)
		
		var cIdx = 0
		for unit in unitsToCompare {
			let value = diff?.valueForComponent(unit)
			let translate_symbol = translateCalendarUnit(unit)
			if value > 0 && translate_symbol != nil {
				let translate_qt = (value == 1 ? "S" : "P")
				let translated_value = "U_\(translate_symbol!)_\(translate_style)_\(translate_qt)".sd_loc(value!)
				cmps.append(translated_value)
				cIdx++
			}
			if cUnits != 0 && cIdx == cUnits { break }
		}
		
		
		return (cmps.count > 0 ? cmps : nil)
	}
	
	private func translateStyle(style :DateFormatterStyle) -> String {
		switch style {
		case DateFormatterStyle.Short:		return "SHORT"
		case DateFormatterStyle.Default:	return "DEFAULT"
		case DateFormatterStyle.Long:		return "LONG"
		case DateFormatterStyle.Full:		return "FULL"
		}
	}
	
	private func translateCalendarUnit(unit :NSCalendarUnit) -> String? {
		switch unit {
		case NSCalendarUnit.Nanosecond: return "NANOSECOND"
		case NSCalendarUnit.Second:		return "SECOND"
		case NSCalendarUnit.Minute:		return "MINUTE"
		case NSCalendarUnit.Hour:		return "HOUR"
		case NSCalendarUnit.Day:		return "DAY"
		case NSCalendarUnit.Month:		return "MONTH"
		case NSCalendarUnit.Year:		return "YEAR"
		default:						return nil // other values are ignored
		}
	}
	
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
     Convert a string into DateInRegion by passing conversion format
     
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


