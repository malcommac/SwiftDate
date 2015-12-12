//
//  NSDateInterval.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 12/12/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Foundation

/// Alternative API from swift.org for avoiding AutoreleasingUnsafeMutablePointer usage in NSCalendar and NSFormatter
/// - Experiment: This is a draft API currently under consideration for official import into Foundation as a suitable alternative to the AutoreleasingUnsafeMutablePointer usage case of returning a NSDate + NSTimeInterval or using a pair of dates representing a range
/// - Note: Since this API is under consideration it may be either removed or revised in the near future
public class NSDateInterval : NSObject {
    public internal(set) var start: NSDate
    public internal(set) var end: NSDate
    
    public var interval: NSTimeInterval {
        return end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
    }
    
    public required init(start: NSDate, end: NSDate) {
        self.start = start
        self.end = end
    }
    
    public convenience init(start: NSDate, interval: NSTimeInterval) {
        self.init(start: start, end: NSDate(timeInterval: interval, sinceDate: start))
    }
}