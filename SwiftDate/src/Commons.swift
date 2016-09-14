//
//  Commons.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

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
