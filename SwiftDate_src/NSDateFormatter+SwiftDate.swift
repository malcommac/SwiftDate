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

public enum ISO8601Style: String {
	case Year							= "yyyy"
	case YearAndMonth					= "yyyy-MM"
	case CompleteDate					= "yyyy-MM-dd"
	case CompleteDateTime				= "yyyy-MM-dd'T'HH:mmZ"
	case CompleteDateTimeSeconds		= "yyyy-MM-dd'T'HH:mm:ssZ"
	case CompleteDateTimeFractional		= "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

//MARK: - Structure: DateFormat -

/**
*  @brief	DateFormat structure is used to parse and format an NSDate.
*			Custom formats are the same provided by iOS.
*			See: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1
*/
public enum DateFormat {
    case Custom(String)					// Custom formatting method
	case ISO8601Format(ISO8601Style?)	// ISO8601 format with style
	
	@available(*, deprecated=3.0.3, message="Use ISO8601Format(.CompleteDateTimeSeconds)")
	case ISO8601						// ISO8601 Format: "2015-01-22T15:20:00Z"

	@available(*, deprecated=3.0.3, message="Use ISO8601Format(.CompleteDate)")
	case ISO8601Date					// ISO8601 Only Date: "2015-01-22"
    case RSS							// RSS style formatter
    case AltRSS							// Alt RSS Formatter
    case Extended						// Extended date Formatter
	
    var formatString: String {
        switch self {
        case .Custom(let format):		return format
        case .ISO8601:					return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .ISO8601Date:				return "yyyy-MM-dd"
		case .ISO8601Format(let style): return (style != nil ? style! : ISO8601Style.CompleteDateTimeSeconds).rawValue
		case .RSS:						return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .AltRSS:					return "d MMM yyyy HH:mm:ss ZZZ"
        case .Extended:					return "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
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

