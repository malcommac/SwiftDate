//
//  RelativeFormatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 08/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

extension Double {
	var sign: Int {
		return (self < 0 ? -1 : 1)
	}
}

public class RelativeFormatter: DateToStringTrasformable {
	
	private static let shared: RelativeFormatter = RelativeFormatter()
	private var loadedLocales: [String: LocaleTableProtocol] = [:]

	private var localeMapping: [String : LocaleTableProtocol.Type] = [
		"en" : locale_it.self
	]
	
	private func tableForLocale(_ locale: Locale) -> LocaleTableProtocol {
		let localeId = (locale.languageCode ?? "en")
		guard let table = self.loadedLocales[localeId] else {
			guard let tableType = self.localeMapping[localeId] else {
				return tableForLocale(Locales.english.toLocale())
			}
			let instanceOfTable = tableType.init()
			self.loadedLocales[localeId] = instanceOfTable
			return instanceOfTable
		}
		return table
	}
	
	private init() {}

	public struct Options {
		public var locale: Locale
		public var flavours: [RelativeFormatter.Flavour]
		public var gradation: Gradation = .convenient()
		public var units: [Unit]? = [.now, .minute, .hour, .day, .week, .month, .year]
		
		public init(locale: Locale? = nil, flavours: [Flavour] = [.longConvenient,.long], gradation: Gradation = .convenient()) {
			self.locale = (locale ?? SwiftDate.defaultRegion.locale)
			self.flavours = flavours
			self.gradation = gradation
		}
	}
	
	public static func format(_ date: DateRepresentable, options: Any?) -> String {
		let dateToFormat = (date as? DateInRegion ?? DateInRegion(date.date, region: SwiftDate.defaultRegion))
		return RelativeFormatter.format(date: dateToFormat, options: (options as? Options))
	}
	
	public static func format(date: DateInRegion, ref: DateInRegion? = nil, options opts: Options?) -> String {
		let refDate = (ref ?? date.region.nowInThisRegion())
		let options = (opts ?? Options())
		
		// how much time elapsed (in seconds)
		let elapsed = (refDate.date.timeIntervalSince1970 - date.date.timeIntervalSince1970)
		
		let (flavour,localeData) = getDataForFlavoursIn(options.flavours, inLocale: options.locale)
		let units = getTimeIntervalMeasurementUnits(localeData, styleUnits: options.units)
		guard units.count > 0 else {
			debugPrint("Required units in style were not found in locale spec. Returning empty string")
			return ""
		}
		
		guard let gradeValue = grade(elapsed: abs(elapsed), ref: refDate.date.timeIntervalSince1970, units: units, gradation: options.gradation) else {
			// If no time unit is suitable, just output an empty string.
			// E.g. when "now" unit is not available
			// and "second" has a threshold of `0.5`
			// (e.g. the "canonical" grading scale).
			return ""
		}
		
		if let customFormat = gradeValue.format {
			return customFormat(date)
		}
		
		var amount = (abs(elapsed) / gradeValue.factor)

		// Apply granularity to the time amount
		// (and fallback to the previous step
		//  if the first level of granularity
		//  isn't met by this amount)
		if let granularity = gradeValue.granularity {
			// Recalculate the elapsed time amount based on granularity
			amount = round(amount / granularity) * granularity
		}
		
		let value: Double = -1.0 * Double(elapsed.sign) * round(amount)
		let formatString = relativeFormat(locale: options.locale, flavour: flavour, value: value, unit: gradeValue.unit)
		return formatString.replacingOccurrences(of: "{0}", with: String(Int(abs(value))))
	}
	
	private static func relativeFormat(locale: Locale, flavour: Flavour, value: Double, unit: Unit) -> String {
		let table = RelativeFormatter.shared.tableForLocale(locale)
		guard	let styleTable = table.table[flavour.rawValue] as? [String:Any],
				let unitRules = styleTable[unit.rawValue] as? [String:Any] else {
			return ""
		}
		
		// Choose either "past" or "future" based on time `value` sign.
		// If "past" is same as "future" then they're stored as "other".
		// If there's only "other" then it's being collapsed.
		let quantifierKey = (value <= 0 ? "past" : "future")
		if let fixedValue = unitRules[quantifierKey] as? String {
			return fixedValue
		} else if let quantifierRules = unitRules[quantifierKey] as? [String: Any] {
			// plurar/translations forms
			// "other" rule is supposed to always be present.
			// If only "other" rule is present then "rules" is not an object and is a string.
			let quantifier = (table.quantifyKey(value) ?? "other")
			return (quantifierRules[quantifier] as? String ?? "")
		} else {
			return ""
		}
	}
	
	private static func getDataForFlavoursIn(_ flavours: [Flavour], inLocale locale: Locale) -> (flavour: Flavour, locale: [String : Any]) {
		let localeData = RelativeFormatter.shared.tableForLocale(locale) // get the locale table
		for flavour in flavours {
			if let flavourData = localeData.table[flavour.rawValue] as? [String:Any] {
				return (flavour,flavourData) // found our required flavor in passed locale
			}
		}
		return (.long,localeData.table[Flavour.long.rawValue] as! [String:Any]) // long must be always present
	}
	
	private static func getTimeIntervalMeasurementUnits(_ localeData: [String:Any], styleUnits: [Unit]?) -> [Unit] {
		let localeUnits: [Unit] = localeData.keys.compactMap { Unit(rawValue: $0) }
		guard let restrictedStyleUnits = styleUnits else { return localeUnits } // no restrictions
		return localeUnits.filter({ restrictedStyleUnits.contains($0) })
	}
	
	private static func grade(elapsed: TimeInterval, ref: TimeInterval, units: [Unit], gradation: Gradation) -> Gradation.Entry? {
		// Leave only allowed time measurement units.
		// E.g. omit "quarter" unit.
		let filteredGradation = Gradation(gradation.data.filter { units.contains($0.unit) })
		// If no steps of gradation fit the conditions
		// then return nothing.
		guard gradation.count > 0 else {
			return nil
		}
		
		// Find the most appropriate gradation step
		let i = findGradationStep(elapsed: elapsed, now: ref, gradation: filteredGradation)
		let step = filteredGradation[i]!
		
		// Apply granularity to the time amount
		// (and fall back to the previous step
		//  if the first level of granularity
		//  isn't met by this amount)
		if let granurality = step.granularity {
			// Recalculate the elapsed time amount based on granularity
			let amount = round( (elapsed / step.factor) / granurality) * granurality
			
			// If the granularity for this step
			// is too high, then fallback
			// to the previous step of gradation.
			// (if there is any previous step of gradation)
			if (amount == 0 && i > 0) {
				return filteredGradation[i - 1]
			}
		}
		return step
	}
	
	private static func findGradationStep(elapsed: TimeInterval, now: TimeInterval, gradation: Gradation, step: Int = 0) -> Int {
		// If the threshold for moving from previous step
		// to this step is too high then return the previous step.
		let threshold = getThreshold(fromStep: gradation[step - 1], toStep: gradation[step]!, now: now)
		if let t = threshold, Double(elapsed) < t {
			return step - 1
		}
		
		// If it's the last step of gradation then return it.
		if step == (gradation.count - 1) {
			return step
		}
		// Move to the next step.
		return findGradationStep(elapsed: elapsed, now: now, gradation: gradation, step: step + 1)
	}
	
	private static func getThreshold(fromStep: Gradation.Entry?, toStep: Gradation.Entry, now: TimeInterval) -> Double? {
		var threshold: Double? = nil
		
		// Allows custom thresholds when moving
		// from a specific step to a specific step.
		if let fromStepUnit = fromStep?.unit {
			threshold = toStep.thresholdPrevious?[fromStepUnit]
		}
		
		// If no custom threshold is set for this transition
		// then use the usual threshold for the next step.
		if threshold == nil {
			threshold = toStep.evaluateThreshold(now)
		}
		
		return threshold
	}

}
