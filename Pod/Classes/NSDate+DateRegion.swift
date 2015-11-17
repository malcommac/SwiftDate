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
        fromDate: NSDate? = nil,
        era: Int? = nil,
        year: Int,
        month: Int,
        day: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        inRegion: DateRegion? = nil) {
            let date: DateInRegion? = fromDate != nil ? DateInRegion(date: fromDate!) : nil
            if let dateInRegion = DateInRegion(fromDate: date, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: inRegion) {
                self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

    public convenience init?(
        fromDate: NSDate? = nil,
        era: Int? = nil,
        yearForWeekOfYear: Int,
        weekOfYear: Int,
        weekday: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        inRegion: DateRegion? = nil) {
            let date: DateInRegion? = fromDate != nil ? DateInRegion(date: fromDate!) : nil
            if let dateInRegion = DateInRegion(fromDate: date, era: era, yearForWeekOfYear: yearForWeekOfYear, weekOfYear: weekOfYear, weekday: weekday, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: inRegion) {
                self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }

    public convenience init?(
        fromDate: NSDate? = nil,
        hour: Int,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0,
        inRegion: DateRegion? = nil) {
            let date: DateInRegion? = fromDate != nil ? DateInRegion(date: fromDate!) : nil
            if let dateInRegion = DateInRegion(fromDate: date, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: inRegion) {
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

/// Extension for region
extension NSDate {

    public func inRegion(region: DateRegion = DateRegion()) -> DateInRegion {
        return DateInRegion(date: self, region: region)
    }
}
