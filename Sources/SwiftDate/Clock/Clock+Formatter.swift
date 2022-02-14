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

public extension Clock {

    /// Convert the data object to a string based upon the date and region encapsulated inside the clock.
    /// - Parameter format: output format.
    /// - Returns: `String`
    func toString(_ format: DateFormats) -> String? {
        switch format {
        case .dotNet:
            let offset = Foundation.NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * absoluteDate.timeIntervalSince1970
            return String(format: format.dateFormat, nowMillis, offset)
        case .isoDateTimeFull, .isoDateTime, .isoYear, .isoDate, .isoYearMonth:
            let formatter = FormattersCache.shared.isoFormatter(format, region: region)
            return formatter?.string(from: absoluteDate)
        default:
            break
        }
        
        guard let formatter = FormattersCache.shared.formatter(format.dateFormat, region: region) else {
            return nil
        }
        
        return formatter.string(from: absoluteDate)
    }
    
}
