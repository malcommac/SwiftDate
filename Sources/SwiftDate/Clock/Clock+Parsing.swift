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

extension Clock {
    
    /// Initialize a new date by parsing given string with specified format and assign it to a region.
    ///
    /// Parameters:
    /// - `dateString`: source date to parse.
    /// - `format`: format in which the string is written.
    /// - `region`: region to associate. By default is `.local`
    /// - `isLenient`: the parsing of strings into date will be fuzzy.
    ///                The formatter will use heuristics to guess at the date which
    ///                is intended by the string. As with any guessing,
    ///                it may get the result date wrong
    ///                (that is, a date other than that which was intended).
    ///                By default is `false`.
    public init?(_ dateString: String?, format: DateFormats, region: Region = .local,
                 isLenient: Bool = false) {
        guard let dateString = dateString, !dateString.isEmpty else {
            return nil
        }

        var string = dateString
        switch format {
        case .rss, .altRSS:
            if string.hasSuffix("Z") {
                string = string[..<string.index(string.endIndex, offsetBy: -1)].appending("GMT")
            }
            
        case .isoDateTimeFull, .isoDateTime, .isoYear, . isoDate, .isoYearMonth:
            let formatter = FormattersCache.shared.isoFormatter(format, region: region)
            if let date = formatter?.date(from: string) {
                self.init(date, region: region)
                return
            }
            
        case .dotNet:
            let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: string.utf16.count)
            if let match = regex?.firstMatch(in: string, range: range) {
                let dateString = (string as NSString).substring(with: match.range(at: 1))
                if let dateNumber = Double(dateString) {
                    let interval = dateNumber / 1000.0
                    let date = Date(timeIntervalSince1970: interval)
                    self.init(date, region: region)
                    return
                }
            }
            return nil
            
        default:
            break
        }
        
        guard let formatter = FormattersCache.shared.formatter(format.dateFormat, region: region, isLenient: isLenient),
              let date = formatter.date(from: string) else {
                  return nil
        }
        
        self.init(date, region: region)
    }
    
}
