//
//  ColloquialDateTimeFormatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 07/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public struct ColloquialFormatter: DateToStringTrasformable {
	
	/// Options used to format the colloqual string
	public struct Options {
		
		/// Define the list of allowed components used to format a date diff.
		/// If you want exclude one or more time unit (ie. you are not interested in printing the weeks
		/// but you want to get only the days) you can set a different set of components (ie. [.day]).
		/// By default all components are allowed (`[.year, .month, .weekOfYear, .day, .hour, .minute, .second]`).
		public var allowedComponents: Set<Calendar.Component> = [.year, .month, .weekOfYear, .day, .hour, .minute, .second]
		
		/// Define the maximum amount of time used to fallback a dates difference to "just now" fallback.
		/// You need to express it in `DateComponents`, so if you want a "just now" result when difference
		/// is less than one hour and 5 minutes you need to set it to `1.hour + 5.minutes`.
		/// By default this value is set to `5.minutes`, so when difference is below five minutes the colloquial
		/// result return `just now` in set locale.
		public var imminentRange: DateComponents? = 5.minutes
		
		/// Define the minimum amount of time used to fallback a colloquial string to an absolute version of the data;
		/// for example if you set it to `2.months` when date diff is longer than 2 months you will get an absolute value
		/// (ie. `dd/MM` instead of `in 3 months`).
		/// By default this value is set to `nil` so fallback never occurs.
		/// The following table defines the absolute representation of date diff for each unit (in locale's format):
		/// * `seconds`: not applicable
		/// * `minute`: not applicable
		/// * `hour`: 'HH:mm'
		/// * `day`: 'dd/MM'
		/// * `month`: `MM/yyyy'
		/// * `year`: 'yyyy`
		public var distantRange: DateComponents? = nil
		
		/// Define the locale used to produce colloquial string representation.
		/// If not set (`nil`) locale is taken from the `Region`'s `locale` of the first date but if you prefer
		/// you can force it to your own settings.
		public var locale: Locale = Locale.current
		
		public init() {}
	}
	
	private let options: ColloquialFormatter.Options
	
	public init(options: ColloquialFormatter.Options? = nil) {
		self.options = options ?? ColloquialFormatter.Options()
	}
	
	public static func format(_ date: DateRepresentable, options: Any?) -> String {
		let refDate = ((date as? DateInRegion) ?? DateInRegion(date.date, region: date.region))
		return (ColloquialFormatter.string(from: refDate, to: date.region.nowInThisRegion(), options: (options as? ColloquialFormatter.Options)) ?? "")
	}
	
	/// Helper function
	private static let DAYS_IN_WEEK = 7
	
	/// This function return colloquial string representing the difference between two dates
	///
	/// - Parameters:
	///   - fDate: from date
	///   - tDate: to date
	///   - fOpt: formatting options. If `nil` it uses standard options with the fDate locale.
	/// - Returns: colloquial string, `nil` if formatter fails
	public static func string(from fDate: DateInRegion, to tDate: DateInRegion, options fOpt: ColloquialFormatter.Options? = nil) -> String? {
		let options = fOpt ?? ColloquialFormatter.Options()
		
		// set the locale
		i18n.shared.locale = options.locale
		
		func value(for component: Calendar.Component, in cmps: DateComponents) -> Int? {
			guard options.allowedComponents.contains(component) else { return nil } // time unit is not allowed by options
			guard let value = cmps.value(for: component), value != 0 else { return nil } // time unit has not a value
			return value // time unit has a valid difference value
		}
		
		func imminentString() -> String? {
			return i18n.shared.localize("colloquial_now", arguments: [])
		}
		
		func isImminentValue(for component: Calendar.Component, value: Int) -> Bool {
			guard let imminent = options.imminentRange?.in(.second) else { return false } // imminent range is not set
			switch component { // imminent range is valid for minute and hour units, otherwise it return false
			case .minute:   return (TimeInterval(abs(value) * 60) < TimeInterval(imminent))
			case .hour:     return (TimeInterval(abs(value) * 60 * 60) < TimeInterval(imminent))
			default:        return false
			}
		}
		
		func colloquialString(for component: Calendar.Component, value: Int, future: Bool, args: CVarArg...) -> String {
			let component_key = component.localizedKey(forValue: value)
			let identifier = "colloquial_\(future ? "f" : "p")_\(component_key)"
			let localized_date = withVaList(args) { (pointer: CVaListPointer) -> String in
				let localized = (i18n.shared.localize(identifier, arguments: []) ?? "")
				return NSString(format: localized, arguments: pointer) as String
			}
			return localized_date
		}
		
		func distant(for component: Calendar.Component, in date: DateInRegion) -> String? {
			let key = "distant_\(component.localizedKey)"
			guard let format = i18n.shared.localize(key, arguments: []) else { return nil }
			let localeDate = DateInRegion(date.date,
										  region: Region(calendar: date.region.calendar,
													 timezone: date.region.timezone,
													 locale: options.locale))
			let relevant_time = localeDate.toString(format: format)
			return relevant_time
		}
		
		// Differences between two dates is zero
		guard fDate.date.timeIntervalSince1970 != tDate.date.timeIntervalSince1970 else {
			return imminentString()
		}
		// Check if both objects are represented in the same calendar
		guard fDate.region.calendar == tDate.region.calendar else {
			debugPrint("[SwiftDate] Dates must use the same calendar")
			return nil
		}
		
		var allowedComponents = options.allowedComponents
		allowedComponents.remove(.weekOfYear)
		let cal = fDate.region.calendar
		let cmps = cal.dateComponents(allowedComponents, from: fDate.date, to: tDate.date)
		let isFuture = (fDate.date > tDate.date)
		
		var isDistant = false
		if let dRange = options.distantRange?.in(.second) {
			let diff = abs(fDate.date.timeIntervalSince1970 - tDate.date.timeIntervalSince1970)
			isDistant = Int(diff) >= dRange
		}
		
		// Years difference
		if let years = value(for: .year, in: cmps) {
			let value = (years == 1 ? years : fDate.year)
			return colloquialString(for: .year, value: value, future: isFuture, args: abs(value))
		}
		
		// Months difference
		if let months = value(for: .month, in: cmps) {
			if isDistant { return distant(for: .month, in: tDate) }
			return colloquialString(for: .month, value: months, future: isFuture, args: abs(months))
		}
		
		// Days difference
		if let days = value(for: .day, in: cmps) {
			if isDistant { return distant(for: .day, in: tDate) }
			let isWeekAllowed = options.allowedComponents.contains(.weekOfYear)
			if days < ColloquialFormatter.DAYS_IN_WEEK || !isWeekAllowed { // Less than a week or week representation is not accepted
				return colloquialString(for: .day, value: days, future: isFuture, args: abs(days))
			} else { // More than a week
				if isWeekAllowed == true { // Weeks representation is allowed
					let weeks = Int(floor(Double(days) / Double(ColloquialFormatter.DAYS_IN_WEEK)))
					return colloquialString(for: .weekOfYear, value: weeks, future: isFuture, args: abs(weeks))
				}
			}
		}
		
		// Hours difference
		if let hours = value(for: .hour, in: cmps) {
			if isDistant { return distant(for: .hour, in: tDate) }
			let isDifferentDay = (cal.isDate(fDate.date, inSameDayAs: tDate.date) == false)
			if isDifferentDay == true { // cross day comparison, return yesterday or tomorrow
				return i18n.shared.localize((isFuture ? "colloquial_f_d" : "colloquial_p_d"), arguments: [])
			} else {
				if isImminentValue(for: .hour, value: hours) { // is imminent
					return imminentString()
				}
				// standard hours difference
				return colloquialString(for: .hour, value: hours, future: isFuture, args: abs(hours))
			}
		}
		
		// Minutes difference
		if let minutes = value(for: .minute, in: cmps) {
			if isImminentValue(for: .minute, value: minutes) { // is imminent
				return imminentString()
			}
			// standard minutes difference
			return colloquialString(for: .minute, value: minutes, future: isFuture, args: abs(minutes))
		}
		
		// Seconds difference fall to imminent
		if let _ = value(for: .second, in: cmps) {
			return imminentString()
		}
		
		// Failed to parse
		return nil
	
	}
}
