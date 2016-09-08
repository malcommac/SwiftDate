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

import Foundation


internal extension NSCalendar.Unit {
    private var cfValue: CFCalendarUnit {
        #if os(OSX) || os(iOS)
            return CFCalendarUnit(rawValue: self.rawValue)
        #else
            return CFCalendarUnit(rawValue: self.rawValue)
        #endif
    }
}

//MARK: - Extension: NSCalendar -

public extension NSCalendar {

    // The code below is part of the Swift.org code. It is included as rangeOfUnit is a very useful
    // function for the startOf and endOf functions.
    // As always we would prefer using Foundation code rather than inventing code ourselves.
    typealias CFType = CFCalendar

    private var cfObject: CFType {
        return unsafeBitCast(self, to: CFCalendar.self)
    }


    /// Revised API for avoiding usage of AutoreleasingUnsafeMutablePointer.
    /// The current exposed API in Foundation on Darwin platforms is:
    /// `public func rangeOfUnit(unit: NSCalendarUnit, startDate datep:
    /// AutoreleasingUnsafeMutablePointer<NSDate?>, interval tip:
    /// UnsafeMutablePointer<NSTimeInterval>, forDate date: NSDate) -> Bool`
    /// which is not implementable on Linux due to the lack of being able to properly implement
    /// AutoreleasingUnsafeMutablePointer.
    ///
    /// - parameters:
    ///     - unit: the unit to determine the range for
    ///     - forDate: the date to wrap the unit around
    /// - returns: the range (date interval) of the unit around the date
    ///
    /// - Experiment: This is a draft API currently under consideration for official import into
    ///     Foundation as a suitable alternative
    /// - Note: Since this API is under consideration it may be either removed or revised in the
    ///     near future
    ///
    public func rangeOfUnit(unit: NSCalendar.Unit, forDate date: NSDate) -> NSDateInterval? {
        var start: CFAbsoluteTime = 0.0
        var ti: CFTimeInterval = 0.0
        let res: Bool = withUnsafeMutablePointers(&start, &ti) {
            (startp: UnsafeMutablePointer<CFAbsoluteTime>,
                tip: UnsafeMutablePointer<CFTimeInterval>) -> Bool in

            let startPtr: UnsafeMutablePointer<CFAbsoluteTime> =
                unsafeBitCast(startp, to: UnsafeMutablePointer<CFAbsoluteTime>.self)
            let tiPtr: UnsafeMutablePointer<CFTimeInterval> =
                unsafeBitCast(tip, to: UnsafeMutablePointer<CFTimeInterval>.self)
            return CFCalendarGetTimeRangeOfUnit(cfObject, unit.cfValue,
                date.timeIntervalSinceReferenceDate, startPtr, tiPtr)
        }

        if res {
            return NSDateInterval(start: NSDate(timeIntervalSinceReferenceDate: start),
                interval: ti)
        }
        return nil
    }

    /**
     Create a new NSCalendar instance from CalendarName structure. You can also use
     <CalendarName>.calendar to get
     a new instance of NSCalendar with picked type.

     - parameter type: type of the calendar

     - returns: instance of the new NSCalendar
     */
    public static func fromType(type: CalendarName) -> NSCalendar! {
        return type.calendar
    }

    /**
     Create a new NSCalendar with current with settings for the current user’s chosen system locale
     overlaid with any custom settings the user has specified in System Preferences. Use autoUpdate
     = false to avoid auto-changes on Settings changes during runtime.

     - parameter autoUpdate: true to get auto-updating calendar

     - returns: a new NSCalendar instance from system settings
     */
    @available(*, deprecated: 2.0.3,
    message: "locale was deprecated, use currentCalendar() or autoupdatingCurrentCalendar() ")
    static func locale(autoUpdate: Bool) -> NSCalendar! {
        return NSCalendar.fromType(type: CalendarName.Local(autoUpdate))
    }
}


//MARK: - Structure: CalendarName -

/**
*  @brief  This structure represent a shortcut from NSCalendar init function.
*/
public enum CalendarName {

    @available(*, deprecated: 2.0.3,
    message: "Local was deprecated, use Current or AutoUpdatingCurrent")
    case Local(_: Bool)
    case Current
    case AutoUpdatingCurrent
    case Gregorian, Buddhist, Chinese, Coptic, EthiopicAmeteMihret, EthiopicAmeteAlem, Hebrew,
    ISO8601, Indian, Islamic, IslamicCivil, Japanese, Persian, RepublicOfChina, IslamicTabular,
    IslamicUmmAlQura

    public var calendar: NSCalendar {
        var identifier: String
        switch self {
        case .Current:				return NSCalendar.current as NSCalendar
        case .AutoUpdatingCurrent:	return NSCalendar.autoupdatingCurrent as NSCalendar
        case .Gregorian:			identifier = NSCalendar.Identifier.gregorian.rawValue
        case .Buddhist:				identifier = NSCalendar.Identifier.buddhist.rawValue
        case .Chinese:				identifier = NSCalendar.Identifier.chinese.rawValue
        case .Coptic:				identifier = NSCalendar.Identifier.coptic.rawValue
        case .EthiopicAmeteMihret:	identifier = NSCalendar.Identifier.ethiopicAmeteMihret.rawValue
        case .EthiopicAmeteAlem:	identifier = NSCalendar.Identifier.ethiopicAmeteAlem.rawValue
        case .Hebrew:				identifier = NSCalendar.Identifier.hebrew.rawValue
        case .ISO8601:				identifier = NSCalendar.Identifier.ISO8601.rawValue
        case .Indian:				identifier = NSCalendar.Identifier.indian.rawValue
        case .Islamic:				identifier = NSCalendar.Identifier.islamic.rawValue
        case .IslamicCivil:			identifier = NSCalendar.Identifier.islamicCivil.rawValue
        case .Japanese:				identifier = NSCalendar.Identifier.japanese.rawValue
        case .Persian:				identifier = NSCalendar.Identifier.persian.rawValue
        case .RepublicOfChina:		identifier = NSCalendar.Identifier.republicOfChina.rawValue
        case .IslamicTabular:		identifier = NSCalendar.Identifier.islamicTabular.rawValue
        case .IslamicUmmAlQura:		identifier = NSCalendar.Identifier.islamicUmmAlQura.rawValue
        case .Local(let autoUpdate):
            if autoUpdate {
                return NSCalendar.autoupdatingCurrent as NSCalendar
            } else {
                return NSCalendar.current as NSCalendar
            }
        }
        return NSCalendar(identifier: NSCalendar.Identifier(rawValue: identifier))!
    }
}
