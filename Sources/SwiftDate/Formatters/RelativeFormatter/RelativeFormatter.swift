//
//  RelativeFormatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 08/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public class RelativeFormatter: DateToStringTrasformable {
	
	/// Private singleton for relative formatter
	private static let shared: RelativeFormatter = RelativeFormatter()
	
	/// A cache with all loaded languagues
	private var languagesCache: [String: RelativeFormatterLang] = [:]

	/// Mapping for languages file to be loaded. Languages table are
	/// loaded only upon request.
	private var languagesMap: [String : RelativeFormatterLang.Type] = [
		lang_af.identifier : lang_af.self,
		lang_en.identifier : lang_en.self,
		lang_it.identifier : lang_it.self,
		lang_am.identifier : lang_am.self,
		lang_ar.identifier : lang_ar.self,
		lang_arAE.identifier : lang_arAE.self,
		lang_as.identifier : lang_as.self,
		lang_be.identifier: lang_be.self,
		lang_bg.identifier: lang_bg.self,
		lang_bn.identifier: lang_bn.self,
		lang_br.identifier: lang_br.self,
		lang_bs.identifier: lang_bs.self,
		lang_bsCyrl.identifier : lang_bsCyrl.self,
		lang_ca.identifier : lang_ca.self,
		lang_cs.identifier : lang_cs.self,
		lang_cy.identifier : lang_cy.self,
		lang_da.identifier : lang_da.self,
		lang_de.identifier : lang_de.self,
		lang_dsb.identifier : lang_dsb.self,
		lang_dz.identifier : lang_dz.self,
		lang_ee.identifier : lang_ee.self,
		lang_el.identifier : lang_el.self,
		lang_es.identifier : lang_es.self,
		lang_esAR.identifier : lang_esAR.self,
		lang_esMX.identifier : lang_esMX.self,
		lang_esPY.identifier : lang_esPY.self,
		lang_esUS.identifier : lang_esUS.self
	]
	
	private init() {}
	
	/// Add/replace a new language table.
	///
	/// - Parameter lang: language file type
	public static func addLanguage(_ lang: RelativeFormatterLang.Type) {
		self.shared.languagesMap[lang.identifier] = lang // replace or add
		self.shared.languagesCache.removeValue(forKey: lang.identifier) // cleanup cache
	}
	
	
	/// Return the language table for a specified locale.
	/// If not loaded yet a new instance of the table is loaded and cached.
	///
	/// - Parameter locale: locale to load
	/// - Returns: language table
	private func language(forLocale locale: Locale) -> RelativeFormatterLang {
		let localeId = (locale.collatorIdentifier ?? Locales.english.toLocale().collatorIdentifier!)
		guard let table = self.languagesCache[localeId] else {
			guard let tableType = self.languagesMap[localeId] else {
				return language(forLocale: Locales.english.toLocale())
			}
			let instanceOfTable = tableType.init()
			self.languagesCache[localeId] = instanceOfTable
			return instanceOfTable
		}
		return table
	}
	
	/// Implementation of the protocol for DateToStringTransformable.
	public static func format(_ date: DateRepresentable, options: Any?) -> String {
		let dateToFormat = (date as? DateInRegion ?? DateInRegion(date.date, region: SwiftDate.defaultRegion))
		return RelativeFormatter.format(date: dateToFormat, style: (options as? Style), locale: date.region.locale)
	}
	
	/// Return relative formatted string result of comparison of two passed dates.
	///
	/// - Parameters:
	///   - date: date to compare
	///   - toDate: date to compare against for (if `nil` current date in the same region of `date` is used)
	///   - style: style of the relative formatter.
	///   - locale: locale to use; if not passed the `date`'s region locale is used.
	/// - Returns: formatted string, empty string if formatting fails
	public static func format(date: DateRepresentable, to toDate: DateInRegion? = nil,
							  style: Style?, locale fixedLocale: Locale? = nil) -> String {
		
		let refDate = (toDate ?? date.region.nowInThisRegion()) // a now() date is created if no reference is passed
		let options = (style ?? RelativeFormatter.defaultStyle()) // default style if not used
		let locale = (fixedLocale ?? date.region.locale) // date's locale is used if no value is forced
		
		// how much time elapsed (in seconds)
		let elapsed = (refDate.date.timeIntervalSince1970 - date.date.timeIntervalSince1970)
		
		// get first suitable flavour for a given locale
		let (flavour,localeData) = suitableFlavour(inList: options.flavours, forLocale: locale)
		// get all units which can be represented by the locale data for required style
		let allUnits = suitableUnits(inLocaleData: localeData, requiredUnits: options.allowedUnits)
		guard allUnits.count > 0 else {
			debugPrint("Required units in style were not found in locale spec. Returning empty string")
			return ""
		}
		
		guard let suitableRule = ruleToRepresent(timeInterval: abs(elapsed),
											   referenceInterval: refDate.date.timeIntervalSince1970,
											   units: allUnits,
											   gradation: options.gradation) else {
			// If no time unit is suitable, just output an empty string.
			// E.g. when "now" unit is not available
			// and "second" has a threshold of `0.5`
			// (e.g. the "canonical" grading scale).
			return ""
		}
		
		if let customFormat = suitableRule.customFormatter {
			return customFormat(date)
		}
		
		var amount = (abs(elapsed) / suitableRule.unit.factor)

		// Apply granularity to the time amount
		// (and fallback to the previous step
		//  if the first level of granularity
		//  isn't met by this amount)
		if let granularity = suitableRule.granularity {
			// Recalculate the elapsed time amount based on granularity
			amount = round(amount / granularity) * granularity
		}
		
		let value: Double = -1.0 * Double(elapsed.sign) * round(amount)
		let formatString = relativeFormat(locale: locale, flavour: flavour, value: value, unit: suitableRule.unit)
		return formatString.replacingOccurrences(of: "{0}", with: String(Int(abs(value))))
	}
	
	private static func relativeFormat(locale: Locale, flavour: Flavour, value: Double, unit: Unit) -> String {
		let table = RelativeFormatter.shared.language(forLocale: locale)
		guard let styleTable = table.flavours[flavour.rawValue] as? [String:Any] else {
			return ""
		}
		
		if let fixedValue = styleTable[unit.rawValue] as? String {
			return fixedValue
		}
		
		guard let unitRules = styleTable[unit.rawValue] as? [String:Any] else {
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
			let quantifier = (table.quantifyKey(forValue: abs(value)) ?? .other).rawValue
			return (quantifierRules[quantifier] as? String ?? "")
		} else {
			return ""
		}
	}
	
	/// Return the first suitable flavour into the list which is available for a given locale.
	///
	/// - Parameters:
	///   - flavours: ordered flavours.
	///   - locale: locale to use.
	/// - Returns: a pair of found flavor and locale table
	private static func suitableFlavour(inList flavours: [Flavour], forLocale locale: Locale) -> (flavour: Flavour, locale: [String : Any]) {
		let localeData = RelativeFormatter.shared.language(forLocale: locale) // get the locale table
		for flavour in flavours {
			if let flavourData = localeData.flavours[flavour.rawValue] as? [String:Any] {
				return (flavour,flavourData) // found our required flavor in passed locale
			}
		}
		return (.long,localeData.flavours[Flavour.long.rawValue] as! [String:Any]) // long must be always present
	}
	
	/// Return a list of available time units in locale filtered by required units of style.
	/// If resulting array if empty there is not any time unit which can be rapresented with given locale
	/// so formatting fails.
	///
	/// - Parameters:
	///   - localeData: local table.
	///   - styleUnits: required time units.
	/// - Returns: available units.
	private static func suitableUnits(inLocaleData localeData: [String:Any], requiredUnits styleUnits: [Unit]?) -> [Unit] {
		let localeUnits: [Unit] = localeData.keys.compactMap { Unit(rawValue: $0) }
		guard let restrictedStyleUnits = styleUnits else { return localeUnits } // no restrictions
		return localeUnits.filter({ restrictedStyleUnits.contains($0) })
	}
	
	/// Return the best rule in gradation to represent given time interval.
	///
	/// - Parameters:
	///   - elapsed: elapsed interval to represent
	///   - referenceInterval: reference interval
	///   - units: units
	///   - gradation: gradation
	/// - Returns: best rule to represent
	private static func ruleToRepresent(timeInterval elapsed: TimeInterval, referenceInterval: TimeInterval, units: [Unit], gradation: Gradation) -> Gradation.Rule? {
		// Leave only allowed time measurement units.
		// E.g. omit "quarter" unit.
		let filteredGradation = gradation.filtered(byUnits: units)
		// If no steps of gradation fit the conditions
		// then return nothing.
		guard gradation.count > 0 else {
			return nil
		}
		
		// Find the most appropriate gradation step
		let i = findGradationStep(elapsed: elapsed, now: referenceInterval, gradation: filteredGradation)
		let step = filteredGradation[i]!
		
		// Apply granularity to the time amount
		// (and fall back to the previous step
		//  if the first level of granularity
		//  isn't met by this amount)
		if let granurality = step.granularity {
			// Recalculate the elapsed time amount based on granularity
			let amount = round( (elapsed / step.unit.factor) / granurality) * granurality
			
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
		let fromGradation = gradation[step - 1]
		let currentGradation = gradation[step]!
		let thresholdValue = threshold(from: fromGradation, to: currentGradation, now: now)
		
		if let t = thresholdValue, elapsed < t {
			return step - 1
		}
		
		// If it's the last step of gradation then return it.
		if step == (gradation.count - 1) {
			return step
		}
		// Move to the next step.
		return findGradationStep(elapsed: elapsed, now: now, gradation: gradation, step: step + 1)
	}
	
	/// Evaluate threshold.
	private static func threshold(from fromRule: Gradation.Rule?, to toRule: Gradation.Rule, now: TimeInterval) -> Double? {
		var threshold: Double? = nil
		
		// Allows custom thresholds when moving
		// from a specific step to a specific step.
		if let fromStepUnit = fromRule?.unit {
			threshold = toRule.thresholdPrevious?[fromStepUnit]
		}
		
		// If no custom threshold is set for this transition
		// then use the usual threshold for the next step.
		if threshold == nil {
			threshold = toRule.threshold?.evaluateForTimeInterval(now)
		}
		
		return threshold
	}

}
