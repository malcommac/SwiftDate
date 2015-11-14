//
//  BNSDate+DateRegion.swift
//  Pods
//
//  Created by Jeroen Houtzager on 10/11/15.
//
//


/// Extension for initialisation
extension NSDate {

    public convenience init?(components: NSDateComponents) {
        if let dateInRegion = DateInRegion(components: components) {
            self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
        } else {
            return nil
        }
    }

    public convenience init?(refDate: NSDate,
        era: Int? = nil,
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil,
        yearForWeekOfYear: Int? = nil,
        weekOfYear: Int? = nil,
        weekday: Int? = nil,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil) {
            let refDateInRegion = refDate.dateInRegion
            if let dateInRegion = DateInRegion(refDate: refDateInRegion, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond) {
                self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

    public convenience init?(
        era: Int? = nil,
        year: Int? = nil,
        month: Int? = nil,
        day: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil) {
            if let thisDate = DateInRegion(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond) {
                self.init(timeIntervalSinceReferenceDate: thisDate.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

    public convenience init?(
        era: Int? = nil,
        yearForWeekOfYear: Int? = nil,
        weekOfYear: Int? = nil,
        weekday: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil) {
            if let dateInRegion = DateInRegion(era: era, yearForWeekOfYear: yearForWeekOfYear, weekOfYear: weekOfYear, weekday: weekday, hour: hour, minute: minute, second: second, nanosecond: nanosecond) {
                self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

}

/// Extension to match DateInRegion
extension NSDate {
    func inRegion(aRegion: DateRegion? = nil) -> DateInRegion {
        return DateInRegion(date: self, region: aRegion)
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

    internal var dateRegion: DateRegion {
        return DateRegion()
    }

    internal var dateInRegion: DateInRegion {
        return self.inRegion(DateRegion())
    }

    public var components : NSDateComponents {
        return dateInRegion.components
    }

    public func withValue(value: Int, forUnit unit: NSCalendarUnit) -> NSDate? {
        return dateInRegion.withValue(value, forUnit: unit)?.date
    }

    public func withValues(valueUnits: [(Int, NSCalendarUnit)]) -> NSDate? {
        return dateInRegion.withValues(valueUnits)?.date
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


