//
//  SwiftDate
//  Toolkit to parse, validate, manipulate, compare and display dates, time & timezones in Swift.
//
//  Created by Daniele Margutti
//  Email: hello@danielemargutti.com
//  Web: http://www.danielemargutti.com
//
//  Copyright ©2022 Daniele Margutti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation

/// The date format type used to string conversion.
/// - `isoYear`: The ISO8601 formatted year `yyyy`
///              (i.e. `1997`)
/// - `isoYearMonth`: The ISO8601 formatted year and month `yyyy-MM`
///                   (i.e. `1997-07`)
/// - `isoDate`: The ISO8601 formatted date, time and sec `yyyy-MM-dd'T'HH:mm:ssZ`
///              (i.e. `1997-07-16T19:20:30+01:00`)
/// - `isoDate`: The ISO8601 formatted date, time and sec `yyyy-MM-dd'T'HH:mm:ssZ`
///              (i.e. `1997-07-16T19:20:30+01:00`)
/// - `isoDateTimeFull`: The ISO8601 formatted date, time and millisec `yyyy-MM-dd'T'HH:mm:ss.SSSZ`
///                  (i.e. `1997-07-16T19:20:30.45+01:00`)
/// - `dotNet`: The .NET formatted date `/Date(%d%d)/`
///             (i.e. `/Date(1268123281843)/`)
/// - `rss`: The RSS formatted date `EEE, d MMM yyyy HH:mm:ss ZZZ`
///          (i.e. `Fri, 09 Sep 2011 15:26:08 +0200`)
/// - `altRSS`: The Alternative RSS formatted date `d MMM yyyy HH:mm:ss ZZZ`
///             (i.e. `09 Sep 2011 15:26:08 +0200`)
/// - `httpHeader`: The http header formatted date `EEE, dd MM yyyy HH:mm:ss ZZZ`
///                 (i.e. `Tue, 15 Nov 1994 12:45:26 GMT`)
/// - `standard`: A generic standard format date i.e. `EEE MMM dd HH:mm:ss Z yyyy`
/// - `custom`: Custom format
public enum DateFormats {
    case isoYear
    case isoYearMonth
    case isoDate
    case isoDateTime
    case isoDateTimeFull
    case dotNet
    case rss
    case altRSS
    case httpHeader
    case standard
    case custom(String)
    
    internal var dateFormat: String {
        switch self {
        case .isoYear: return "yyyy"
        case .isoYearMonth: return "yyyy-MM"
        case .isoDate: return "yyyy-MM-dd"
        case .isoDateTime: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeFull: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .dotNet: return "/Date(%d%f)/"
        case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
        case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
        case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
        case .custom(let format): return format
        }
    }
    
}
