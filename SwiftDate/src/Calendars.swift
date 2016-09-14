//
//  Calendars.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public enum Calendars {
	case current, currentAutoUpdating
	case gregorian, buddhist, chinese, coptic, ethiopicAmeteMihret, ethiopicAmeteAlem, hebrew,
	iso8601, indian, islamic, islamicCivil, japanese, persian, republicOfChina, islamicTabular,
	islamicUmmAlQura
	
	public var calendar: Calendar {
		var identifier: Calendar.Identifier
		switch self {
		case .current:				return Calendar.current
		case .currentAutoUpdating:	return Calendar.autoupdatingCurrent
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
		}
		return Calendar(identifier: identifier)
	}
}


extension Calendar.Component {
	fileprivate var cfValue: CFCalendarUnit {
		return CFCalendarUnit(rawValue: self.rawValue)
	}
}

extension Calendar.Component {
	/// https://github.com/apple/swift-corelibs-foundation/blob/swift-DEVELOPMENT-SNAPSHOT-2016-09-10-a/CoreFoundation/Locale.subproj/CFCalendar.h#L68-L83
	internal var rawValue: UInt {
		switch self {
		case .era:               return 1 << 1
		case .year:              return 1 << 2
		case .month:             return 1 << 3
		case .day:               return 1 << 4
		case .hour:              return 1 << 5
		case .minute:            return 1 << 6
		case .second:            return 1 << 7
		case .weekday:           return 1 << 9
		case .weekdayOrdinal:    return 1 << 10
		case .quarter:           return 1 << 11
		case .weekOfMonth:       return 1 << 12
		case .weekOfYear:        return 1 << 13
		case .yearForWeekOfYear: return 1 << 14
		case .nanosecond:        return 1 << 15
		case .calendar:          return 1 << 16
		case .timeZone:          return 1 << 17
		}
	}
	
	internal init?(rawValue: UInt) {
		switch rawValue {
		case Calendar.Component.era.rawValue:               self = .era
		case Calendar.Component.year.rawValue:              self = .year
		case Calendar.Component.month.rawValue:             self = .month
		case Calendar.Component.day.rawValue:               self = .day
		case Calendar.Component.hour.rawValue:              self = .hour
		case Calendar.Component.minute.rawValue:            self = .minute
		case Calendar.Component.second.rawValue:            self = .second
		case Calendar.Component.weekday.rawValue:           self = .weekday
		case Calendar.Component.weekdayOrdinal.rawValue:    self = .weekdayOrdinal
		case Calendar.Component.quarter.rawValue:           self = .quarter
		case Calendar.Component.weekOfMonth.rawValue:       self = .weekOfMonth
		case Calendar.Component.weekOfYear.rawValue:        self = .weekOfYear
		case Calendar.Component.yearForWeekOfYear.rawValue: self = .yearForWeekOfYear
		case Calendar.Component.nanosecond.rawValue:        self = .nanosecond
		case Calendar.Component.calendar.rawValue:          self = .calendar
		case Calendar.Component.timeZone.rawValue:          self = .timeZone
		default: return nil
		}
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
			let startDate = Date(timeIntervalSinceReferenceDate: start)
			return DateInterval(start: startDate, duration: ti)
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
	public static func fromType(_ type: Calendars) -> Calendar {
		return type.calendar
	}
	
}
