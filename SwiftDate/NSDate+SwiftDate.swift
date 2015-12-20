//
//	SwiftDate, an handy tool to manage date and timezones in swift
//	Created by:				Daniele Margutti
//	Main contributors:		Jeroen Houtzager
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.


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
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region aRegion: DateRegion? = nil) {
            
            if let dateInRegion = DateInRegion(fromDate: fromDate?.inRegion(), era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, calendarID: calendarID, timeZoneID: timeZoneID, localeID: localeID, calendarType: calendarType, timeZoneRegion: timeZoneRegion, calendar: aCalendar, timeZone: aTimeZone, locale: aLocale, region: aRegion) {
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
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region aRegion: DateRegion? = nil) {
            
            if let dateInRegion = DateInRegion(fromDate: fromDate?.inRegion(), era: era, yearForWeekOfYear: yearForWeekOfYear, weekOfYear: weekOfYear, weekday: weekday, hour: hour, minute: minute, second: second, nanosecond: nanosecond, calendarID: calendarID, timeZoneID: timeZoneID, localeID: localeID, calendarType: calendarType, timeZoneRegion: timeZoneRegion, calendar: aCalendar, timeZone: aTimeZone, locale: aLocale, region: aRegion) {
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
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region aRegion: DateRegion? = nil) {
            
            if let dateInRegion = DateInRegion(fromDate: fromDate?.inRegion(), hour: hour, minute: minute, second: second, nanosecond: nanosecond, calendarID: calendarID, timeZoneID: timeZoneID, localeID: localeID, calendarType: calendarType, timeZoneRegion: timeZoneRegion, calendar: aCalendar, timeZone: aTimeZone, locale: aLocale, region: aRegion) {
                self.init(timeIntervalSinceReferenceDate: dateInRegion.timeIntervalSinceReferenceDate)
            } else {
                return nil
            }
    }
    
    public convenience init?(components: NSDateComponents) {
        if let dateInRegion = DateInRegion(components) {
            let absoluteTime = dateInRegion.absoluteTime
            guard absoluteTime != nil else { return nil }
            self.init(timeIntervalSinceReferenceDate: absoluteTime!.timeIntervalSinceReferenceDate)
        } else {
            return nil
        }
    }
    
    /**
     Initialize a new NSDate instance by passing components in a dictionary.
     Each key of the component must be an NSCalendarUnit type. All values are supported.
     
     - parameter params: paramters dictionary, each key must be an NSCalendarUnit
     - parameter locale: NSLocale instance to assign. If missing current locale will be used instead
     
     - returns: a new NSDate instance
     */
    public convenience init?(dateComponentDictionary: DateComponentDictionary) {
        
        let absoluteTime = dateComponentDictionary.absoluteTime()
        guard absoluteTime != nil else { return nil }
        self.init(timeIntervalSinceReferenceDate: absoluteTime!.timeIntervalSinceReferenceDate)
    }
    
    /**
     Initialize a new NSDate instance by taking initial components from date object and setting only specified components if != nil
     
     - parameter date:              reference date
     - parameter era:               era to set (nil to ignore)
     - parameter year:              year to set  (nil to ignore)
     - parameter month:             month to set  (nil to ignore)
     - parameter day:               day to set  (nil to ignore)
     - parameter yearForWeekOfYear: yearForWeekOfYear to set  (nil to ignore)
     - parameter weekOfYear:        weekOfYear to set  (nil to ignore)
     - parameter weekday:           weekday to set  (nil to ignore)
     - parameter hour:              hour to set  (nil to ignore)
     - parameter minute:            minute to set  (nil to ignore)
     - parameter second:            second to set  (nil to ignore)
     - parameter nanosecond:        nanosecond to set  (nil to ignore)
     - parameter region:            region to set (if not specified DateRegion() will be used instead - Gregorian/UTC/Current Locale)
     
     - returns: a new date instance with components created from refDate and only specified components set by passing input params
     */
    public convenience init(refDate date : NSDate,
        era						: Int? = nil,
        year					: Int? = nil,
        month					: Int? = nil,
        day						: Int? = nil,
        hour					: Int? = nil,
        minute					: Int? = nil,
        second					: Int? = nil,
        nanosecond				: Int? = nil,
        region					: DateRegion = DateRegion()) {
            
            
            let date = DateInRegion(fromDate: date.inRegion(), era: era, year: year ?? date.year, month: month ?? date.month, day: day ?? date.day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: region)!
            self.init(timeIntervalSinceReferenceDate: date.absoluteTime!.timeIntervalSinceReferenceDate)
    }
    
    public convenience init(refDate date : NSDate,
        era						: Int? = nil,
        yearForWeekOfYear       : Int? = nil,
        weekOfYear				: Int? = nil,
        weekday					: Int? = nil,
        hour					: Int? = nil,
        minute					: Int? = nil,
        second					: Int? = nil,
        nanosecond				: Int? = nil,
        region					: DateRegion = DateRegion()) {
            
            
            let date = DateInRegion(fromDate: date.inRegion(), era: era, yearForWeekOfYear: yearForWeekOfYear ?? date.yearForWeekOfYear, weekOfYear: weekOfYear ?? date.weekOfYear, weekday: weekday ?? date.weekday, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: region)!
            self.init(timeIntervalSinceReferenceDate: date.absoluteTime!.timeIntervalSinceReferenceDate)
    }
    
    /**
     Create a new DateInRegion object. It will represent an absolute time expressed in a particular world region.
     
     - parameter region: region to associate. If not specified defaultRegion() will be used instead. Use DateRegion.setDefaultRegion() to define a default region for your application.
     
     - returns: a new DateInRegion instance representing this date in specified region. You can query for each component and it will be returned taking care of the region components specified.
     */
    public func inRegion(region :DateRegion = DateRegion()) -> DateInRegion {
        let dateInRegion = DateInRegion(absoluteTime: self, region: region)
        return dateInRegion
    }
    
    /**
     This is a shortcut to express the date into the default region of the app.
     You can specify a default region by calling DateRegion.setDefaultRegion(). By default default region for you app is Gregorian Calendar/UTC TimeZone and current locale.
     
     - returns: a new DateInRegion instance representing this date in default region
     */
    public func inDefaultRegion() -> DateInRegion {
        return self.inRegion()
    }
    
    /**
     Create a new date from self by adding specified component values. All values are optional. Date still remain expressed in UTC.
     
     - parameter years:       years to add
     - parameter months:      months to add
     - parameter weekOfYear:  week of year to add
     - parameter days:        days to add
     - parameter hours:       hours to add
     - parameter minutes:     minutes to add
     - parameter seconds:     seconds to add
     - parameter nanoseconds: nanoseconds to add
     
     - returns: a new absolute time from self plus passed components
     */
    public func add(years years: Int? = nil, months: Int? = nil, weekOfYear: Int? = nil, days: Int? = nil,hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil, nanoseconds: Int? = nil) -> NSDate {
        
        let date = self.inRegion()
        let newDate = date.add(years: years, months: months, weekOfYear: weekOfYear, days: days, hours: hours, minutes: minutes, seconds: seconds, nanoseconds: nanoseconds)
        return newDate.absoluteTime
    }
    
    /**
     Add components to the current absolute time by passing an NSDateComponents intance
     
     - parameter components: components to add
     
     - returns: a new absolute time from self plus passed components
     */
    public func add(components :NSDateComponents) -> NSDate {
        let date = self.inRegion().add(components)
        return date.absoluteTime
    }
    
    /**
     Add components to the current absolute time by passing NSCalendarUnit dictionary
     
     - parameter params: dictionary of NSCalendarUnit components
     
     - returns: a new absolute time from self plus passed components dictionary
     */
    public func add(params :[NSCalendarUnit : AnyObject]) -> NSDate {
        let date = self.inRegion().add(components: params)
        return date.absoluteTime
    }
    
    /**
     Diffenence between the receiver and toDate for the units provided
     
     - parameters:
        - toDate: date to calculate the difference with
        - unitFlags: calendar component flags to express the difference in
     
     - returns: date components with the difference calculated, `nil` on error
     */
	public func difference(toDate: NSDate, unitFlags: NSCalendarUnit) -> NSDateComponents? {
        return self.inRegion().difference(toDate.inRegion(), unitFlags: unitFlags)
    }
    
    /**
     Get the NSDateComponents from passed absolute time by converting it into specified region timezone
     
     - parameter region: region of destination
     
     - returns: date components
     */
    public func components(inRegion region :DateRegion = DateRegion()) -> NSDateComponents {
        return self.inRegion().components
    }
    
    /// The same of calling components() without specify a region: current region is used instead
    public var components : NSDateComponents {
        get {
            return components()
        }
    }
    
    /**
     Takes a date unit and returns a date at the start of that unit.
     
     - parameter unit:   unit
     - parameter region: region of the date
     
     - returns: the date representing that start of that unit
     */
    public func startOf(unit :NSCalendarUnit, inRegion region :DateRegion) -> NSDate {
        return self.inRegion(region).startOf(unit).absoluteTime
    }
    
    /**
     Takes a date unit and returns a date at the end of that unit.
     
     - parameter unit:   unit
     - parameter region: region of the date
     
     - returns: the date representing that end of that unit
     */
    public func endOf(unit :NSCalendarUnit, inRegion region :DateRegion) -> NSDate {
        return self.inRegion(region).startOf(unit).absoluteTime
    }
    
    
    /**
     Return the string representation the date in specified region
     
     - parameter format: format of date
     - parameter region: region of destination (DateRegion() is used when argument is not specified)
     
     - returns: string representation of the date into the region
     */
    public func toString(format :DateFormat, inRegion region :DateRegion = DateRegion()) -> String? {
        return DateInRegion(absoluteTime: self, region: region).toString(format)
    }
    
    /**
     Convert a DateInRegion date into a date with date & time style specific format style
     
     - parameter style:     style to format both date and time (if you specify this you don't need to specify dateStyle,timeStyle)
     - parameter dateStyle: style to format the date
     - parameter timeStyle: style to format the time
     - parameter region:    region in which you want to represent self absolute time
     
     - returns: a new string which represent the date expressed into the current region or nil if region does not contain valid date
     */
    public func toString(
        style: NSDateFormatterStyle? = nil,
        dateStyle: NSDateFormatterStyle? = nil,
        timeStyle: NSDateFormatterStyle? = nil,
        inRegion region :DateRegion = DateRegion()) -> String? {
            
            let refDateInRegion = DateInRegion(absoluteTime: self, region: region)
            return refDateInRegion.toString(style, dateStyle: dateStyle, timeStyle: timeStyle)
    }
    
    /**
     Return relative representation of the date in a specified region
     
     - parameter region: region of destination (DateRegion() is used when argument is not specified)
     
     - returns: string representation in form of relative date (just now, 3 seconds...)
     */
    public func toRelativeCocoaString(inRegion region :DateRegion = DateRegion()) -> String? {
        return DateInRegion(absoluteTime: self, region: region).toRelativeCocoaString()
    }
    
    /**
     Return relative representation of the self absolute time (expressed in region region) compared to another UTC refDate (always expressed in the same region)
     
     - parameter refDate:     reference date
     - parameter region:      region assigned both for reference date and self date
     - parameter abbreviated: true to get abbreviated form of the representation
     - parameter maxUnits:    units details to include in representation (value is from 0 to 7: year = 0, month, weekOfYear, day, hour, minute, second, nanosecond = 7)
     
     - returns: relative string representation
     */
    public func toRelativeString(fromDate refDate: NSDate = NSDate(), inRegion region :DateRegion = DateRegion(), abbreviated :Bool = false, maxUnits: Int = 1) -> String? {
        let refDateInRegion = DateInRegion(absoluteTime: refDate, region: region)
        return DateInRegion(absoluteTime: self, region: region).toRelativeString(refDateInRegion, abbreviated: abbreviated, maxUnits: maxUnits)
    }
    
}

// MARK: - Adoption of Comparable protocol


extension NSDate : Comparable {}

/**
 Compare two dates and return true if the left date is earlier than the right date
 
 - parameter left:  left date
 - parameter right: right date
 
 - returns: true if left < right
 */
public func < (left: NSDate, right: NSDate) -> Bool {
    return (left.compare(right) == NSComparisonResult.OrderedAscending)
}

// MARK: - Date calculations with date components

/**
 Subtract from absolute seconds of UTC left date the number of absolute seconds of UTC right date
 
 - parameter lhs: left date
 - parameter rhs: right date
 
 - returns: a new date result of the difference between two dates
 */
public func - (lhs: NSDate, rhs: NSDateComponents) -> NSDate {
    return lhs + (-rhs)
}

/**
 Sum to absolute seconds of UTC left date the number of absolute seconds of UTC right date
 
 - parameter lhs: left date
 - parameter rhs: right date
 
 - returns: a new date result of the sum between two dates
 */
public func + (lhs: NSDate, rhs: NSDateComponents) -> NSDate {
    return lhs.add(rhs)
}


public extension NSTimeInterval {
    
    public var fromNow: NSDate? {
        return NSDate(timeIntervalSinceNow: self)
    }
    
    public var ago: NSDate? {
        return NSDate(timeIntervalSinceNow: -self)
    }
}


extension NSDate {
    
    /// Get the year component of the date in current region (use inRegion(...).year to get the year component in specified time zone)
    public var year :Int {
        return self.inRegion().year!
    }
    
    /// Get the month component of the date in current region (use inRegion(...).month to get the month component in specified time zone)
    public var month :Int {
        return self.inRegion().month!
    }
    
    /// Get the month name component of the date in current region (use inRegion(...).monthName to get the month's name component in specified time zone)
    public var monthName :String {
        return self.inRegion().monthName!
    }
    
    /// Get the week of month component of the date in current region (use inRegion(...).weekOfMonth to get the week of month component in specified time zone)
    public var weekOfMonth :Int {
        return self.inRegion().weekOfMonth!
    }
    
    /// Get the year for week of year component of the date in current region (use inRegion(...).yearForWeekOfYear to get the year week of year component in specified time zone)
    public var yearForWeekOfYear :Int {
        return self.inRegion().yearForWeekOfYear!
    }
    
    /// Get the week of year component of the date in current region (use inRegion(...).weekOfYear to get the week of year component in specified time zone)
    public var weekOfYear :Int	{
        return self.inRegion().weekOfYear!
    }
    
    /// Get the weekday component of the date in current region (use inRegion(...).weekday to get the weekday component in specified time zone)
    public var weekday :Int {
        return self.inRegion().weekday!
    }
    
    /// Get the weekday ordinal component of the date in current region (use inRegion(...).weekdayOrdinal to get the weekday ordinal component in specified time zone)
    public var weekdayOrdinal :Int	{
        return self.inRegion().weekdayOrdinal!
    }
    
    /// Get the day component of the date in current region (use inRegion(...).day to get the day component in specified time zone)
    public var day :Int {
        return self.inRegion().day!
    }
    
    /// Get the number of days of the current date's month in current region (use inRegion(...).monthDays to get it in specified time zone)
    public var monthDays :Int {
        return self.inRegion().monthDays!
    }
    
    /// Get the hour component of the current date's hour in current region (use inRegion(...).hour to get it in specified time zone)
    public var hour :Int {
        return self.inRegion().hour!
    }
    
    /// Get the nearest hour component of the current date's hour in current region (use inRegion(...).nearestHour to get it in specified time zone)
    public var nearestHour :Int {
        return self.inRegion().nearestHour
    }
    
    /// Get the minute component of the current date's minute in current region (use inRegion(...).minute to get it in specified time zone)
    public var minute :Int	{
        return self.inRegion().minute!
    }
    
    /// Get the second component of the current date's second in current region (use inRegion(...).second to get it in specified time zone)
    public var second :Int	{
        return self.inRegion().second!
    }
    
    /// Get the nanoscend component of the current date's nanosecond in current region (use inRegion(...).nanosecond to get it in specified time zone)
    public var nanosecond :Int	{
        return self.inRegion().nanosecond!
    }
    
    /// Get the era component of the current date's era in current region (use inRegion(...).era to get it in specified time zone)
    public var era :Int {
        return self.inRegion().era!
    }
    
    
    /**
     Get the first day of the week in current self absolute time in calendar
     
     - parameter cal: calendar to use. If not specified Gregorian is used instead
     
     - returns: first day of the week in calendar, nil if region is not valid
     */
    public func firstDayOfWeek(inRegion region: DateRegion = DateRegion()) -> Int? {
        return self.inRegion(region).startOf(.WeekOfYear).day
    }
    
    /**
     Get the last day of week according to region specified
     
     - parameter cal: calendar to use. If not specified Gregorian is used instead
     
     - returns: last day of the week in calendar, nil if region is not valid
     */
    public func lastDayOfWeek(inRegion region: DateRegion = DateRegion()) -> Int? {
        return self.inRegion(region).endOf(.WeekOfYear).day
    }
    
    public func isIn(unit: NSCalendarUnit, ofDate date: NSDate, inRegion region: DateRegion = DateRegion()) -> Bool {
        return self.inRegion(region).isIn(unit, ofDate: date.inRegion(region))
    }
    
    public func isBefore(unit: NSCalendarUnit, ofDate date: NSDate, inRegion region: DateRegion = DateRegion()) -> Bool {
        return self.inRegion(region).isBefore(unit, ofDate: date.inRegion(region))
    }
    
    public func isAfter(unit: NSCalendarUnit, ofDate date: NSDate, inRegion region: DateRegion = DateRegion()) -> Bool {
        return self.inRegion(region).isAfter(unit, ofDate: date.inRegion(region))
    }
    
    public func isToday(inRegion region: DateRegion = DateRegion()) -> Bool {
        return self.inRegion(region).isInToday()
    }
    
    public func isYesterday(inRegion region: DateRegion = DateRegion()) -> Bool {
        return self.inRegion(region).isInYesterday()
    }
    
    public func isTomorrow(inRegion region: DateRegion = DateRegion()) -> Bool {
        return self.inRegion(region).isInTomorrow()
    }
    
    public func inSameDayAsDate(date: NSDate, inRegion region: DateRegion = DateRegion()) -> Bool {
        return self.inRegion(region).inSameDayAsDate(date.inRegion(region))
    }

    
    /**
     Return true if date is a weekend day into specified region calendar
     
     - returns: true if date is tomorrow into specified region calendar
     */
    public func isWeekend(inRegion region: DateRegion = DateRegion()) -> Bool? {
        return self.inRegion(region).isInWeekend()
    }
    
    public func isLeapYear(inRegion region: DateRegion = DateRegion()) -> Bool? {
        return self.inRegion(region).leapYear
    }
    
    public func isLeapMonth(inRegion region: DateRegion = DateRegion()) -> Bool? {
        return self.inRegion(region).leapMonth
    }
    

}

extension NSDate {
    
    public class func today(inRegion region: DateRegion = DateRegion()) -> NSDate {
        return region.today().absoluteTime
    }
    
    public class func yesterday(inRegion region: DateRegion = DateRegion()) -> NSDate {
        return region.yesterday().absoluteTime
    }
    
    public class func tomorrow(inRegion region: DateRegion = DateRegion()) -> NSDate {
        return region.tomorrow().absoluteTime
    }
    
}