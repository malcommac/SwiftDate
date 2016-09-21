//
//	SwiftDate, Full featured Swift date library for parsing, validating, manipulating, and formatting dates and timezones.
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

/// This is the list of all possible errors you can get from the library
///
/// - FailedToParse:        Failed to parse a specific date using provided format
/// - FailedToCalculate:    Failed to calculate new date from passed parameters
/// - MissingCalTzOrLoc:    Provided components does not include a valid TimeZone or Locale
/// - DifferentCalendar:    Provided dates are expressed in different calendars and cannot be compared
/// - MissingRsrcBundle:    Missing SwiftDate resource bundle
/// - FailedToSetComponent: Failed to set a calendar com
public enum DateError: Error {
	case FailedToParse
	case FailedToCalculate
	case MissingCalTzOrLoc
	case DifferentCalendar
	case MissingRsrcBundle
	case FailedToSetComponent(Calendar.Component)
}


/// Available date formats used to parse strings and format date into string
///
/// - custom:   custom format expressed in Unicode tr35-31 (see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns and Apple's Date Formatting Guide)
/// - iso8601:  iso8601 date format (see https://en.wikipedia.org/wiki/ISO_8601)
/// - extended: extended date format ("eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz")
/// - rss:      RSS and AltRSS date format
/// - dotNET:   .NET date format
public enum DateFormat {
	case custom(String)
	case iso8601(options: ISO8601DateFormatter.Options)
	case extended
	case rss(alt: Bool)
	case dotNET
}
