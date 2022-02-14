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

@available(*, deprecated, message: "Use Clock instead")
public typealias DateInRegion = Clock

/// A `Clock` represent a `Date` instance with associated timezone, locale and calendar.
/// All the operations made using this object includes these data, including the
/// formatter functions.
public struct Clock: Codable, Equatable, Hashable, CustomStringConvertible  {
    
    // MARK: - Public Properties
    
    /// Associated region which define where the
    /// date is represented into the world.
    public let region: Region
    
    /// Absolute date represented.
    ///
    /// NOTE:
    /// This date is not associated with any timezone or calendar
    /// but represent the absolute number of seconds
    /// since Jan 1, 2001 at 00:00:00 UTC.
    public let absoluteDate: Date
    
    /// Return an absolute date object where the datetime is adjusted
    /// according to the timezone set for this clock.
    public var representedDate: Date {
        let secs = TimeInterval(region.timeZone.timeZone.secondsFromGMT())
        return absoluteDate.addingTimeInterval(secs)
    }
    
    /// Extract date components by taking care of the region in which the date is expressed.
    public var dateComponents: DateComponents {
        region.calendar.dateComponents(DateComponents.allCases, from: absoluteDate)
    }

    
    // MARK: - Initialization
    
    /// Return a `Clock` in distant past using as region the `Region.default`.
    public static var past: Clock {
        Clock(.distantPast, region: .default)
    }
    
    /// Return a `Clock` in distant future using as region the `Region.default`.
    public static var future: Clock {
        Clock(.distantFuture, region: .default)
    }
        
    /// Initialize a new absolute date in a given world region.
    /// Date is passed in its absolute format which is the UTC representation
    /// (with no timezone or locale associated).
    /// Passed region is used to represent the geographical/cultural attributes
    /// to the date.
    ///
    /// - Parameters:
    ///   - absoluteDate: absolute date.
    ///   - region: region in which the date is represented.
    public init(_ absoluteDate: Date = .now, region: Region) {
        self.absoluteDate = absoluteDate
        self.region = region
    }
    
    // MARK: - Conversion
    
    /// Express the current clock in another region.
    ///
    /// - Parameter region: destination region.
    /// - Returns: `Clock`
    public func to(region: Region) -> Clock {
        Clock(absoluteDate, region: region)
    }
    
    /// Move the date to another timezone keeping values
    /// `calendar`, `locale` settings to the original sender.
    ///
    /// - Parameter timezone: destination timezone.
    /// - Returns: `Clock`
    public func to(timezone: Region.TimeZoneOptions) -> Clock {
        Clock(absoluteDate, region: .init(calendar: region.calendar, {
            $0.timeZone = timezone
            $0.locale = region.locale
        }))
    }
    
    // MARK: - Public Properties
    
    /// Description of the instance.
    public var description: String {
        """
        Clock {
            date: \(representedDate)
            abs-date: \(absoluteDate)
            region: \(region)
        }
        """
    }
    
}
