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


extension Calendar.Component {
    fileprivate var cfValue: CFCalendarUnit {
        return CFCalendarUnit(rawValue: self.rawValue)
    }
}

//MARK: - Extension: Calendar -

extension Calendar {

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
    ///     - component: the unit to determine the range for
    ///     - date: the date to wrap the unit around
    /// - returns: the range (date interval) of the unit around the date
    ///
    /// - Experiment: This is a draft API currently under consideration for official import into
    ///     Foundation as a suitable alternative
    /// - Note: Since this API is under consideration it may be either removed or revised in the
    ///     near future
    ///
    public func range(of component: Calendar.Component, for date: Date) -> DateInterval? {
        var start: CFAbsoluteTime = 0.0
        var ti: CFTimeInterval = 0.0
        let res: Bool = withUnsafeMutablePointer(to: &start) { startp -> Bool in
            return withUnsafeMutablePointer(to: &ti) { tip -> Bool in
                let startPtr: UnsafeMutablePointer<CFAbsoluteTime> =
                    unsafeBitCast(startp, to: UnsafeMutablePointer<CFAbsoluteTime>.self)
                let tiPtr: UnsafeMutablePointer<CFTimeInterval> =
                    unsafeBitCast(tip, to: UnsafeMutablePointer<CFTimeInterval>.self)
                return CFCalendarGetTimeRangeOfUnit(cfObject, component.cfValue,
                                                    date.timeIntervalSinceReferenceDate, startPtr, tiPtr)
            }
        }

        if res {
            return DateInterval(start: Date(timeIntervalSinceReferenceDate: start),
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
    public static func fromType(_ type: CalendarName) -> Calendar {
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
    static func locale(autoUpdate: Bool) -> Calendar! {
        return Calendar.fromType(CalendarName.local(autoUpdate))
    }
}


//MARK: - Structure: CalendarName -

/**
*  @brief  This structure represent a shortcut from NSCalendar init function.
*/
public enum CalendarName {

    @available(*, deprecated: 2.0.3,
    message: "Local was deprecated, use Current or AutoUpdatingCurrent")
    case local(_: Bool)
    case current
    case autoUpdatingCurrent
    case gregorian, buddhist, chinese, coptic, ethiopicAmeteMihret, ethiopicAmeteAlem, hebrew,
    iso8601, indian, islamic, islamicCivil, japanese, persian, republicOfChina, islamicTabular,
    islamicUmmAlQura

    public var calendar: Calendar {
        var identifier: Calendar.Identifier
        switch self {
        case .current:				return Calendar.current as Calendar
        case .autoUpdatingCurrent:	return NSCalendar.autoupdatingCurrent as Calendar
        case .gregorian:			identifier = Calendar.Identifier.gregorian
        case .buddhist:				identifier = Calendar.Identifier.buddhist
        case .chinese:				identifier = Calendar.Identifier.chinese
        case .coptic:				identifier = Calendar.Identifier.coptic
        case .ethiopicAmeteMihret:	identifier = Calendar.Identifier.ethiopicAmeteMihret
        case .ethiopicAmeteAlem:	identifier = Calendar.Identifier.ethiopicAmeteAlem
        case .hebrew:				identifier = Calendar.Identifier.hebrew
        case .iso8601:				identifier = Calendar.Identifier.iso8601
        case .indian:				identifier = Calendar.Identifier.indian
        case .islamic:				identifier = Calendar.Identifier.islamic
        case .islamicCivil:			identifier = Calendar.Identifier.islamicCivil
        case .japanese:				identifier = Calendar.Identifier.japanese
        case .persian:				identifier = Calendar.Identifier.persian
        case .republicOfChina:		identifier = Calendar.Identifier.republicOfChina
        case .islamicTabular:		identifier = Calendar.Identifier.islamicTabular
        case .islamicUmmAlQura:		identifier = Calendar.Identifier.islamicUmmAlQura
        case .local(let autoUpdate):
            if autoUpdate {
                return Calendar.autoupdatingCurrent
            } else {
                return Calendar.current
            }
        }
        return Calendar(identifier: identifier)
    }
}
