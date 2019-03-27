//
//  CalendarConvertible.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public typealias Calendars = Calendar.Identifier

public protocol CalendarConvertible {
	func toCalendar() -> Calendar
}

extension Calendar: CalendarConvertible {

	public func toCalendar() -> Calendar {
		return self
	}

	internal static func newCalendar(_ calendar: CalendarConvertible, configure: ((inout Calendar) -> Void)? = nil) -> Calendar {
		var cal = calendar.toCalendar()
		configure?(&cal)
		return cal
	}

}

extension Calendar.Identifier: CalendarConvertible {

	public func toCalendar() -> Calendar {
		return Calendar(identifier: self)
	}

}

// MARK: - Support for Calendar.Identifier encoding with Codable

extension Calendar.Identifier: CustomStringConvertible {

	public var description: String {
		switch self {
		case .gregorian:			return "gregorian"
		case .buddhist:				return "buddhist"
		case .chinese:				return "chinese"
		case .coptic:				return "coptic"
		case .ethiopicAmeteMihret:	return "ethiopicAmeteMihret"
		case .ethiopicAmeteAlem:	return "ethiopicAmeteAlem"
		case .hebrew:				return "hebrew"
		case .iso8601:				return "iso8601"
		case .indian:				return "indian"
		case .islamic:				return "islamic"
		case .islamicCivil:			return "islamicCivil"
		case .japanese:				return "japanese"
		case .persian:				return "persian"
		case .republicOfChina:		return "republicOfChina"
		case .islamicTabular:		return "islamicTabular"
		case .islamicUmmAlQura:		return "islamicUmmAlQura"
		@unknown default:
			fatalError("Unsupported calendar \(self)")
		}
	}

	public init(_ rawValue: String) {
		switch rawValue {
		case Calendar.Identifier.gregorian.description:				self = .gregorian
		case Calendar.Identifier.buddhist.description:				self = .buddhist
		case Calendar.Identifier.chinese.description:				self = .chinese
		case Calendar.Identifier.coptic.description:				self = .coptic
		case Calendar.Identifier.ethiopicAmeteMihret.description:	self = .ethiopicAmeteMihret
		case Calendar.Identifier.ethiopicAmeteAlem.description:		self = .ethiopicAmeteAlem
		case Calendar.Identifier.hebrew.description:				self = .hebrew
		case Calendar.Identifier.iso8601.description:				self = .iso8601
		case Calendar.Identifier.indian.description:				self = .indian
		case Calendar.Identifier.islamic.description:				self = .islamic
		case Calendar.Identifier.islamicCivil.description:			self = .islamicCivil
		case Calendar.Identifier.japanese.description:				self = .japanese
		case Calendar.Identifier.persian.description:				self = .persian
		case Calendar.Identifier.republicOfChina.description:		self = .republicOfChina
		case Calendar.Identifier.islamicTabular.description:		self = .islamicTabular
		case Calendar.Identifier.islamicTabular.description:		self = .islamicTabular
		case Calendar.Identifier.islamicUmmAlQura.description:		self = .islamicUmmAlQura
		default:
			let defaultCalendar = SwiftDate.defaultRegion.calendar.identifier
			debugPrint("Calendar Identifier '\(rawValue)' not recognized. Using default (\(defaultCalendar))")
			self = defaultCalendar
		}
	}

}
