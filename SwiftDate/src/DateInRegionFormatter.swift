//
//  DateInRegionFormatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 11/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public struct DateZeroBehaviour: OptionSet {
	public let rawValue: Int
	
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
	
	static let none = DateZeroBehaviour(rawValue: 1)
	
	static let dropLeading = DateZeroBehaviour(rawValue: 3)

	static let dropMiddle = DateZeroBehaviour(rawValue: 4)
	
	static let dropTrailing = DateZeroBehaviour(rawValue: 3)

	static let dropAll: DateZeroBehaviour = [.dropLeading,.dropMiddle,.dropTrailing]

}

public class DateInRegionFormatter {
	
	public var allowedComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]

	public var zeroBehavior: DateZeroBehaviour = .dropAll

	public var maxComponentCount: Int?

	public var unitStyle: DateComponentsFormatter.UnitsStyle = .full
	
	public var unitSeparator: String = ","
	
	public var useImminentInterval: Bool = true

	public var includeRelevantTime: Bool = true
	
	public var locale: Locale?

	public init() {

	}
	
	private lazy var resourceBundle: Bundle? = {
		var framework = Bundle(identifier: "com.danielemargutti.SwiftDate")
		if framework == nil { framework = Bundle.main }
		guard let _ = framework else {
			return nil
		}
		let path = NSURL(fileURLWithPath:
			framework!.resourcePath!).appendingPathComponent("SwiftDate.bundle")
		let bundle = Bundle(url: path!)
		guard let _ = bundle else {
			return nil
		}
		return bundle!
	}()
	
	private func localizedResourceBundle() -> Bundle? {
		guard let locale = self.locale else {
			return self.resourceBundle
		}
		
		let localeID = locale.collatorIdentifier
		guard let innerLanguagePath = self.resourceBundle?.path(forResource: localeID, ofType: "lproj") else {
			return nil
		}
		return Bundle(path: innerLanguagePath)
	}
	
	public func timeComponents(interval: TimeInterval) throws  -> String {
		let UTCRegion = Region(tz: TimeZones.gmt, cal: Calendars.current, loc: Locales.current)
		let date = Date()
		let fromDate = DateInRegion(absoluteDate: date.addingTimeInterval(-interval), in: UTCRegion)
		let toDate = DateInRegion(absoluteDate: date, in: UTCRegion.copy())
		return try self.timeComponents(from: fromDate, to: toDate)
	}
	
	public func timeComponents(from: DateInRegion, to: DateInRegion) throws -> String {
		guard from.region.calendar == to.region.calendar else {
			throw DateError.DifferentCalendar
		}
		let cal = from.region.calendar
		
		let componentFlags: [Calendar.Component] = [.year, .month, .day, .hour, .minute, .second]
		var output: [String] = []
		var nonZeroUnitFound: Int = 0
		
		var intervalIsNegative = false

		let cmps = cal.dateComponents(allowedComponents, from: from.absoluteDate, to: to.absoluteDate)
		for component in componentFlags {
			let value = cmps.value(for: component)
			
			if value != nil && value != Int(NSDateComponentUndefined) && value! < 0 {
				intervalIsNegative = true
			}
				
			let isValueZero = (value != nil && value! == 0)
			let willDrop =	(isValueZero == true && self.zeroBehavior == .dropAll) ||
							(self.zeroBehavior == .dropLeading && nonZeroUnitFound == 0) ||
							(self.zeroBehavior == .dropMiddle)
			if willDrop == false {
				var cmp = DateComponents()
				cmp.setValue(value!, for: component)
				let localizedUnit = DateComponentsFormatter.localizedString(from: cmp, unitsStyle: unitStyle)!
				output.append(localizedUnit)
			}
			
			nonZeroUnitFound += (isValueZero ? 1 : 0)
			// limit the number of values to show
			if maxComponentCount != nil && nonZeroUnitFound == maxComponentCount! {
				break
			}
		}
		return (intervalIsNegative ? "-" : "") + output.joined(separator: self.unitSeparator)
	}
	
	public func colloquial(from fDate: DateInRegion, to tDate: DateInRegion) throws -> (date: String, time: String?) {
		guard fDate.region.calendar == tDate.region.calendar else {
			throw DateError.DifferentCalendar
		}
		let cal = fDate.region.calendar
		let cmp = cal.dateComponents(self.allowedComponents, from: fDate.absoluteDate, to: tDate.absoluteDate)
		let isFuture = (fDate > tDate)
		
		if cmp.year != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .year, withValue: cmp.year!, date: fDate)
			let colloquial_date = try self.localized(unit: .year, withValue: cmp.year!, asFuture: isFuture, args: fDate.year)
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.month != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .month, withValue: cmp.month!, date: fDate)
			let colloquial_date = try self.localized(unit: .month, withValue: cmp.month!, asFuture: isFuture, args: cmp.month!)
			return (colloquial_date,colloquial_time)
		}
		
		let daysInWeek = fDate.region.calendar.range(of: .day, in: .weekOfMonth, for: fDate.absoluteDate)!.count
		if cmp.day! >= daysInWeek {
			let colloquial_time = try self.colloquial_time(forUnit: .weekOfYear, withValue: cmp.weekOfYear!, date: fDate)
			let weeksNo = (abs(cmp.day!) / daysInWeek)
			let colloquial_date = try self.localized(unit: .weekOfYear, withValue: weeksNo, asFuture: isFuture, args: weeksNo)
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.day != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .day, withValue: cmp.day!, date: fDate)
			let colloquial_date = try self.localized(unit: .day, withValue: cmp.day!, asFuture: isFuture, args: cmp.day!)
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.hour != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .hour, withValue: cmp.hour!, date: fDate)
			let colloquial_date = try self.localized(unit: .hour, withValue: cmp.hour!, asFuture: isFuture, args: cmp.hour!)
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.minute != 0 {
			if self.useImminentInterval && cmp.minute! < 5 {
				let colloquial_date = try self.stringLocalized(identifier: "colloquial_now", arguments: [])
				return (colloquial_date,nil)
			} else {
				let colloquial_date = try self.localized(unit: .minute, withValue: cmp.minute!, asFuture: isFuture, args: cmp.minute!)
				return (colloquial_date,nil)
			}
		}
		
		if cmp.second != 0 { // Seconds difference
			let colloquial_date = try self.stringLocalized(identifier: "colloquial_now", arguments: [])
			return (colloquial_date,nil)
		}
		
		throw DateError.FailedToCalculate
	}
	
	private func colloquial_time(forUnit unit: Calendar.Component, withValue value: Int, date: DateInRegion) throws -> String? {
		guard self.includeRelevantTime == true else {
			return nil
		}
		guard let bundle = self.localizedResourceBundle() else {
			throw DateError.MissingRsrcBundle
		}
		
		let unitStr = self.localized(unit: unit, value: value)
		let id_relative = "relevanttime_\(unitStr)"
		let relative_localized = NSLocalizedString(id_relative,
		                                           tableName: "SwiftDate",
		                                           bundle: bundle, value: "", comment: "")
		if (relative_localized as NSString).length == 0 {
			return nil
		}
		let relevant_time = date.string(format: .custom(relative_localized))
		return relevant_time
	}
	
	private func stringLocalized(identifier: String, arguments: CVarArg...) throws -> String {
		guard let bundle = self.localizedResourceBundle() else {
			throw DateError.MissingRsrcBundle
		}
		var localized_str = NSLocalizedString(identifier, tableName: "SwiftDate", bundle: bundle, comment: "")
		localized_str = String(format: localized_str, arguments: arguments)
		return localized_str
	}
	
	private func localized(unit: Calendar.Component, withValue value: Int, asFuture: Bool, args: CVarArg...) throws -> String {
		guard let bundle = self.localizedResourceBundle() else {
			throw DateError.MissingRsrcBundle
		}

		let future_key = (asFuture ? "f" : "p")

		let unitStr = self.localized(unit: unit, value: value)
		let identifier = "colloquial_\(future_key)_\(unitStr)"
		let localized_date = withVaList(args) { (pointer: CVaListPointer) -> String in
			let localized = NSLocalizedString(identifier, tableName: "SwiftDate", bundle: bundle, value: "", comment: "")
			return NSString(format: localized, arguments: pointer) as String
		}
		return localized_date
	}
	
	private func localized(unit: Calendar.Component, value: Int) -> String {
		let absValue = abs(value)
		switch unit {
		case .year:			return (absValue == 1 ? "y" : "yy")
		case .month:		return (absValue == 1 ? "m" : "mm")
		case .weekOfYear:	return (absValue == 1 ? "w" : "ww")
		case .day:			return (absValue == 1 ? "d" : "dd")
		case .hour:			return (absValue == 1 ? "h" : "hh")
		case .minute:		return (absValue == 1 ? "M" : "MM")
		case .second:		return (absValue == 1 ? "s" : "ss")
		default:			return ""
		}
	}
}
