//
//  File.swift
//  
//
//  Created by Daniele Margutti on 13/02/22.
//

import Foundation

extension DateComponents {
    
    /// Shortcut for 'all calendar components'.
    internal static var allCases: Set<Calendar.Component> {
        [.era, .year, .month, .day,
         .hour, .minute, .second,
         .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear,
         .yearForWeekOfYear,
         .nanosecond, .calendar, .timeZone
        ]
    }

}
