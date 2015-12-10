//
//  NSCalendar+SwiftDate.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 08/12/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Foundation

//MARK: - Extension: NSCalendar -

public extension NSCalendar {
    /**
     Create a new NSCalendar instance from CalendarType structure. You can also use <CalendarType>.toCalendar() to get
     a new instance of NSCalendar with picked type.
     
     - parameter type: type of the calendar
     
     - returns: instance of the new NSCalendar
     */
    public static func fromType(type :CalendarType) -> NSCalendar! {
        return type.toCalendar()
    }
    
    /**
     Create a new NSCalendar with current with settings for the current user’s chosen system locale overlaid with any custom settings the user has specified in System Preferences. Use autoUpdate = false to avoid auto-changes on Settings changes during runtime.
     
     - parameter autoUpdate: true to get auto-updating calendar
     
     - returns: a new NSCalendar instance from system settings
     */
    @available(*, deprecated=2.0.3, message="locale was deprecated, use currentCalendar() or autoupdatingCurrentCalendar() ")
    static func locale(autoUpdate :Bool) -> NSCalendar! {
        return NSCalendar.fromType(CalendarType.Local(autoUpdate))
    }
}


//MARK: - Structure: CalendarType -

/**
*  @brief  This structure represent a shortcut from NSCalendar init function.
*/
public enum CalendarType {
    @available(*, deprecated=2.0.3, message="Local was deprecated, use Current or AutoUpdatingCurrent")
    case Local(_: Bool)
    case Current
    case AutoUpdatingCurrent
    case Gregorian, Buddhist, Chinese, Coptic, EthiopicAmeteMihret, EthiopicAmeteAlem, Hebrew, ISO8601, Indian, Islamic, IslamicCivil, Japanese, Persian, RepubliOfChina, IslamicTabluar, IslamicUmmAlQura
    
    public func toCalendar() -> NSCalendar {
        var identifier : String
        switch self {
        case .Current:				return NSCalendar.currentCalendar()
        case .AutoUpdatingCurrent:	return NSCalendar.autoupdatingCurrentCalendar()
        case .Gregorian:			identifier = NSCalendarIdentifierGregorian
        case .Buddhist:				identifier = NSCalendarIdentifierBuddhist
        case .Chinese:				identifier = NSCalendarIdentifierChinese
        case .Coptic:				identifier = NSCalendarIdentifierCoptic
        case .EthiopicAmeteMihret:	identifier = NSCalendarIdentifierEthiopicAmeteMihret
        case .EthiopicAmeteAlem:	identifier = NSCalendarIdentifierEthiopicAmeteAlem
        case .Hebrew:				identifier = NSCalendarIdentifierHebrew
        case .ISO8601:				identifier = NSCalendarIdentifierISO8601
        case .Indian:				identifier = NSCalendarIdentifierIndian
        case .Islamic:				identifier = NSCalendarIdentifierIslamic
        case .IslamicCivil:			identifier = NSCalendarIdentifierIslamicCivil
        case .Japanese:				identifier = NSCalendarIdentifierJapanese
        case .Persian:				identifier = NSCalendarIdentifierPersian
        case .RepubliOfChina:		identifier = NSCalendarIdentifierRepublicOfChina
        case .IslamicTabluar:		identifier = NSCalendarIdentifierIslamicTabular
        case .IslamicUmmAlQura:		identifier = NSCalendarIdentifierIslamicUmmAlQura
        case .Local(let autoUpdate):
            if autoUpdate {
                return NSCalendar.autoupdatingCurrentCalendar()
            } else {
                return NSCalendar.currentCalendar()
            }
        }
        return NSCalendar(identifier: identifier)!
    }
}

