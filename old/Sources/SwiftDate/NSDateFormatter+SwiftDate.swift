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

/// Formatter options for ISO8601 according to [link](https://www.w3.org/TR/NOTE-datetime)
///
/// - `Year`: Year -
///     `YYYY` (eg 1997)
/// - `YearMonth`: Year and month -
///     `YYYY-MM` (eg 1997-07)
/// - `Date`: Complete date -
///     `YYYY-MM-DD` (eg 1997-07-16)
/// - `DateTime`: Complete date plus hours and minutes -
///     `YYYY-MM-DDThh:mmTZD` (eg 1997-07-16T19:20+01:00)
/// - `Full`: Complete date plus hours, minutes and seconds -
///     `YYYY-MM-DDThh:mm:ssTZD` (eg 1997-07-16T19:20:30+01:00)
/// - `Extended`: Complete date plus hours, minutes, seconds and a decimal fraction of a
/// second -
///     `YYYY-MM-DDThh:mm:ss.sTZD` (eg 1997-07-16T19:20:30.45+01:00)
///
/// where:
///
/// - `YYYY` = four-digit year
/// - `MM`   = two-digit month (01=January, etc.)
/// - `DD`   = two-digit day of month (01 through 31)
/// - `hh`   = two digits of hour (00 through 23) (am/pm NOT allowed)
/// - `mm`   = two digits of minute (00 through 59)
/// - `ss`   = two digits of second (00 through 59)
/// - `s`    = one or more digits representing a decimal fraction of a second
/// - `TZD`  = time zone designator (Z or +hh:mm or -hh:mm)
///
/// This profile does not specify how many digits may be used to represent the decimal
/// fraction of a second. An adopting standard that permits fractions of a second must
/// specify both the minimum number of digits (a number greater than or equal to one) and
/// the maximum number of digits (the maximum may be stated to be "unlimited").
///
/// This profile defines two ways of handling time zone offsets:
///
/// Times are expressed in UTC (Coordinated Universal Time), with a special UTC designator
/// ("Z").
/// Times are expressed in local time, together with a time zone offset in hours and
/// minutes. A time zone offset of "+hh:mm" indicates that the date/time uses a local time
/// zone which is "hh" hours and "mm" minutes ahead of UTC. A time zone offset of "-hh:mm"
/// indicates that the date/time uses a local time zone which is "hh" hours and "mm"
/// minutes behind UTC.
///
/// A standard referencing this profile should permit one or both of these ways of
/// handling time zone offsets.
///
public enum ISO8601Type: String {
	case Year					= "yyyy"
	case YearMonth				= "yyyy-MM"
	case Date					= "yyyy-MM-dd"
	case DateTime				= "yyyy-MM-dd'T'HH:mmZZZZZ"
	case Full					= "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
	case Extended				= "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
}

//MARK: - Structure: DateFormat -

// swiftlint:disable line_length

/**
*  @brief	DateFormat structure is used to parse and format an NSDate.
*			Custom formats are the same provided by iOS.
*			See: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1
*/

// enable line_length


public enum DateFormat {
    case Custom(String)					// Custom formatting method
	case ISO8601Format(ISO8601Type?)	// ISO8601 format with style.
                                        // You can omit type, .Full option is used.
	@available(*, deprecated=3.0.3, message="Use ISO8601Format(.Full)")
	case ISO8601						// ISO8601 format with style.
                                        // You can omit type, .Full option is used.
	@available(*, deprecated=3.0.3, message="Use ISO8601(.Date)")
	case ISO8601Date					// ISO8601 Date Only Format (same of ISO8601(.Date))
    case RSS							// RSS style formatter
    case AltRSS							// Alt RSS Formatter
    case Extended						// Extended date Formatter

    var formatString: String {
        switch self {
        case .Custom(let format):		return format
        case .ISO8601Date:				return (ISO8601Type.Date).rawValue
		case .ISO8601Format(let type):	return (type != nil ? type! : ISO8601Type.Full).rawValue
		case .ISO8601:					return (ISO8601Type.Full).rawValue
		case .RSS:						return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .AltRSS:					return "d MMM yyyy HH:mm:ss ZZZ"
        case .Extended:					return "eee dd-MMM-yyyy GG HH:mm:ss.SSS ZZZ"
        }
    }
}


// MARK: - Extension - ISO8601 Formatter

// This class extension provide a single method which attempt to handle all different ISO8601
// formatters to return
// best format string which can handle provided date

extension String {

    private enum IS08601Format: Int {
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
        // swiftlint:disable:previous type_name

        // YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+01:00)
        case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecond = 28
        // swiftlint:disable:previous type_name

        // YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45Z)
        case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondAndZ = 23
        // swiftlint:disable:previous type_name
    }

    /// Handle all different ISO8601 formatters and returns correct date format for string
    ///
    /// - parameters:
    ///     - fromString: string to be formatted
    ///
    /// - returns: formatted string
    ///
    static func ISO8601Formatter(fromString string: String) -> String {

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
