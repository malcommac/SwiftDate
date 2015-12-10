//
//  File.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 08/12/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Foundation

//MARK: - Structure: DateFormat -

/**
*  @brief	DateFormat structure is used to parse and format an NSDate.
*			Custom formats are the same provided by iOS.
*			See: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1
*/
public enum DateFormat {
    case Custom(String)		// Custom formatting method
    case ISO8601			// ISO8601 Format: "2015-01-22T15:20:00Z"
    case ISO8601Date		// ISO8601 Only Date: "2015-01-22"
    case RSS				// RSS style formatter
    case AltRSS				// Alt RSS Formatter
    case Extended			// Extended date Formatter
    
    var formatString: String {
        switch self {
        case .Custom(let format):	return format
        case .ISO8601:				return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .ISO8601Date:			return "yyyy-MM-dd"
        case .RSS:					return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .AltRSS:				return "d MMM yyyy HH:mm:ss ZZZ"
        case .Extended:				return "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
        }
    }
}


// MARK: - Extension - ISO8601 Formatter

// This class extension provide a single method which attempt to handle all different ISO8601 formatters to return
// best format string which can handle provided date

extension String {
    /**
     Attempts to handle all different ISO8601 formatters
     and returns correct date format for string
     http://www.w3.org/TR/NOTE-datetime
     */
    static func ISO8601Formatter(fromString string: String) -> String {
        
        enum IS08601Format: Int {
            // YYYY (eg 1997)
            case Year = 4
            
            // YYYY-MM (eg 1997-07)
            case YearAndMonth = 7
            
            // YYYY-MM-DD (eg 1997-07-16)
            case CompleteDate = 10
            
            // YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20+01:00)
            case CompleteDatePlusHoursAndMinutes = 22
            
            // YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20Z)
            case CompleteDatePlusHoursAndMinutesAndZ = 17
            
            // YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30+01:00)
            case CompleteDatePlusHoursMinutesAndSeconds = 25
            
            // YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30Z)
            case CompleteDatePlusHoursAndMinutesAndSecondsAndZ = 20
            
            // YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+01:00)
            case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecond = 28
            
            // YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45Z)
            case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondAndZ = 23
        }
        
        var dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let dateStringCount = IS08601Format(rawValue: string.characters.count) {
            switch dateStringCount {
            case .Year:
                dateFormatter = "yyyy"
            case .YearAndMonth:
                dateFormatter = "yyyy-MM"
            case .CompleteDate:
                dateFormatter = "yyyy-MM-dd"
            case .CompleteDatePlusHoursAndMinutes, .CompleteDatePlusHoursAndMinutesAndZ:
                dateFormatter = "yyyy-MM-dd'T'HH:mmZ"
            case .CompleteDatePlusHoursMinutesAndSeconds, .CompleteDatePlusHoursAndMinutesAndSecondsAndZ:
                dateFormatter = "yyyy-MM-dd'T'HH:mm:ssZ"
            case .CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecond, .CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondAndZ:
                dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            }
        }
        return dateFormatter
    }
}


// MARK: - Extension: NSDateFormatter

// This extension is used to provide a central NSDateFormatter instance. Because NSDateFormatter instances are exprensive to create
// we want to reuse the same NSDateFormatter instances in each thread. We have used saveState() and restoreState() to save
// formatter's properties (dateFormat,locale and timeZone) and restore them after the use of the formatter itself.

internal extension NSDateFormatter {
    
    class CachedDateFormatter {
        private(set) var formatter	:NSDateFormatter
        private var dateFormat		:String?
        private var locale			:NSLocale?
        private var timeZone		:NSTimeZone?
        
        init() {
            self.formatter = NSDateFormatter()
        }
        
        /**
         Save the current state of the formatter
         
         - returns: formatter itself to enable chaining
         */
        func saveState() -> CachedDateFormatter {
            dateFormat = formatter.dateFormat
            locale = formatter.locale
            timeZone = formatter.timeZone
            return self
        }
        
        /**
         Restore previously saved state of the formatter
         
         - returns: formatter itself to enable chaining
         */
        func restoreState() -> CachedDateFormatter {
            formatter.dateFormat = dateFormat
            formatter.locale = locale
            formatter.timeZone = timeZone
            return self
        }
    }
    
    /**
     This method return the same NSDateFormatter encapsulated instance for each thread
     
     - returns: a CachedDateFormatter object.
     */
    static func cachedFormatter() -> CachedDateFormatter {
        let CACHED_DATEFORMATTER_KEY = "CACHED_DATEFORMATTER_KEY"
        if let threadDictionary = NSThread.currentThread().threadDictionary as NSMutableDictionary? {
            if let cachedObject = threadDictionary[CACHED_DATEFORMATTER_KEY] as! CachedDateFormatter? {
                return cachedObject
            } else {
                let newObject = CachedDateFormatter()
                threadDictionary.setObject(newObject, forKey: CACHED_DATEFORMATTER_KEY)
                return newObject
            }
        } else {
            assert(false, "Current NSThread dictionary is nil. This should never happens, we will return a new instance of the object on each call")
            return CachedDateFormatter()
        }
    }
    
}

