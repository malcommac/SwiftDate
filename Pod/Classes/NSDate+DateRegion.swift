//
//  BNSDate+DateRegion.swift
//  Pods
//
//  Created by Jeroen Houtzager on 10/11/15.
//
//


/// Extension for initialisation
extension NSDate {
    public convenience init?(
        era: Int? = nil,
        year: Int,
        month: Int,
        day: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        inRegion: DateRegion? = nil) {
            if let dateInRegion = DateInRegion(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: inRegion) {
                self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

    public convenience init?(
        era: Int? = nil,
        yearForWeekOfYear: Int,
        weekOfYear: Int,
        weekday: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        inRegion: DateRegion? = nil) {
            if let thisDate = DateInRegion(era: era, yearForWeekOfYear: yearForWeekOfYear, weekOfYear: weekOfYear, weekday: weekday, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: inRegion) {
                self.init(timeIntervalSinceReferenceDate: thisDate.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

    public convenience init?(
        hour: Int,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0,
        referenceDate: NSDate = NSDate(),
        inRegion: DateRegion? = nil) {
            if let dateInRegion = DateInRegion(hour: hour, minute: minute, second: second, nanosecond: nanosecond, referenceDate: referenceDate, region: inRegion) {
                self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

    public convenience init?(components parComponents: NSDateComponents) {
        if let dateInRegion = DateInRegion(components: parComponents) {
            self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
        } else {
            return nil
        }
    }

}

/// Extension to match DateInRegion
extension NSDate {
    func inRegion(aRegion: DateRegion? = nil) -> DateInRegion {
        return DateInRegion(date: self, region: aRegion!)
    }
}

/// Extension for comparisons
extension NSDate {
    public func isInToday() -> Bool {
        return dateInRegion.isInToday()
    }

    public func isInYesterday() -> Bool {
        return dateInRegion.isInYesterday()
    }

    public func isInTomorrow() -> Bool {
        return dateInRegion.isInTomorrow()
    }

    public func isInWeekend() -> Bool {
        return dateInRegion.isInWeekend()
    }
}

/// Extension for comparable functions
extension NSDate : Comparable {}

public func <(ldate: NSDate, rdate: NSDate) -> Bool {
    return ldate.dateInRegion < rdate.dateInRegion
}

public func >(ldate: NSDate, rdate: NSDate) -> Bool {
    return ldate.dateInRegion > rdate.dateInRegion
}

public func ==(ldate: NSDate, rdate: NSDate) -> Bool {
    return ldate.dateInRegion == rdate.dateInRegion
}


/// Extension for components
extension NSDate {

    internal var region: DateRegion {
        return DateRegion()
    }

    internal var dateInRegion: DateInRegion {
        let region = DateRegion()
        return self.inRegion(region)
    }

    public var components : NSDateComponents {
        return dateInRegion.components
    }

    public var era: Int? {
        return dateInRegion.era
    }
    
    public var year: Int? {
        return dateInRegion.year
    }
    
    public var month: Int? {
        return dateInRegion.month
    }
    
    public var day: Int? {
        return dateInRegion.day
    }
    
    public var hour: Int? {
        return dateInRegion.hour
    }
    
    public var minute: Int? {
        return dateInRegion.minute
    }
    
    public var second: Int? {
        return dateInRegion.second
    }
    
    public var nanosecond: Int? {
        return dateInRegion.nanosecond
    }
    
    public var yearForWeekOfYear: Int? {
        return dateInRegion.yearForWeekOfYear
    }
    
    public var weekOfYear: Int? {
        return dateInRegion.weekOfYear
    }
    
    public var weekday: Int? {
        return dateInRegion.weekday
    }

    public var weekdayOrdinal: Int? {
        return dateInRegion.weekdayOrdinal
    }

    public var weekOfMonth: Int? {
        return dateInRegion.weekOfMonth
    }

    public var leapMonth: Bool {
        return dateInRegion.leapMonth
    }

    public var leapYear: Bool {
        return dateInRegion.leapYear
    }

    public func previousWeekend() -> (startDate: NSDate, endDate: NSDate)? {
        if let (startDate, endDate) = dateInRegion.previousWeekend() {
            return (startDate.date, endDate.date)
        }
        return nil
    }

    public func nextWeekend() -> (startDate: NSDate, endDate: NSDate)? {
        if let (startDate, endDate) = dateInRegion.nextWeekend() {
            return (startDate.date, endDate.date)
        }
        return nil
    }

}

/// Extension for equations
extension NSDate {
    public func inSameDayAsDate(date: NSDate) -> Bool {
        return dateInRegion.inSameDayAsDate(date)
    }
}


/// Extension for operations
extension NSDate {
    public func difference(toDate: NSDate, unitFlags: NSCalendarUnit) -> NSDateComponents? {
        return dateInRegion.difference(toDate.dateInRegion, unitFlags: unitFlags)
    }

    internal func addComponents(components: NSDateComponents) -> NSDate? {
        return dateInRegion.addComponents(components)?.date
    }

}


public func - (lhs: NSDate, rhs: NSDateComponents) -> NSDate? {
    return lhs + (-rhs)
}

public func + (lhs: NSDate, rhs: NSDateComponents) -> NSDate? {
    return lhs.addComponents(rhs)
}

/// Extension for operations
extension NSDate {
    public func startOf(unit: NSCalendarUnit) -> NSDate? {
        return dateInRegion.startOf(unit)?.date
    }

    public func endOf(unit: NSCalendarUnit) -> NSDate? {
        return dateInRegion.endOf(unit)?.date
    }
}


