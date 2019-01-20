//
//  lang_as.swift
//  SwiftDate-iOS
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_as: RelativeFormatterLang {

	/// Locales.assamese
	public static let identifier: String = "as"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value <= 1 ? .one : .other)
	}

	public var flavours: [String: Any] {
		return [
			RelativeFormatter.Flavour.long.rawValue: _long,
			RelativeFormatter.Flavour.narrow.rawValue: _narrow,
			RelativeFormatter.Flavour.short.rawValue: _short
		]
	}

	private var _short: [String: Any] {
		return [
			"year": [
				"previous": "যোৱা বছৰ",
				"current": "এই বছৰ",
				"next": "অহা বছৰ",
				"past": "{0} বছৰৰ পূৰ্বে",
				"future": "{0} বছৰত"
			],
			"quarter": [
				"previous": "যোৱা তিনি মাহ",
				"current": "এই তিনি মাহ",
				"next": "অহা তিনি মাহ",
				"past": "{0} তিনি মাহ পূৰ্বে",
				"future": "{0} তিনি মাহত"
			],
			"month": [
				"previous": "যোৱা মাহ",
				"current": "এই মাহ",
				"next": "অহা মাহ",
				"past": "{0} মাহ পূৰ্বে",
				"future": "{0} মাহত"
			],
			"week": [
				"previous": "যোৱা সপ্তাহ",
				"current": "এই সপ্তাহ",
				"next": "অহা সপ্তাহ",
				"past": "{0} সপ্তাহ পূৰ্বে",
				"future": "{0} সপ্তাহত"
			],
			"day": [
				"previous": "কালি",
				"current": "আজি",
				"next": "কাইলৈ",
				"past": "{0} দিন পূৰ্বে",
				"future": "{0} দিনত"
			],
			"hour": [
				"current": "এইটো ঘণ্টাত",
				"past": "{0} ঘণ্টা পূৰ্বে",
				"future": "{0} ঘণ্টাত"
			],
			"minute": [
				"current": "এইটো মিনিটত",
				"past": "{0} মিনিট পূৰ্বে",
				"future": "{0} মিনিটত"
			],
			"second": [
				"current": "এতিয়া",
				"past": "{0} ছেকেণ্ড পূৰ্বে",
				"future": "{0} ছেকেণ্ডত"
			],
			"now": "এতিয়া"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "যোৱা বছৰ",
				"current": "এই বছৰ",
				"next": "অহা বছৰ",
				"past": "{0} বছৰৰ পূৰ্বে",
				"future": "{0} বছৰত"
			],
			"quarter": [
				"previous": "যোৱা তিনি মাহ",
				"current": "এই তিনি মাহ",
				"next": "অহা তিনি মাহ",
				"past": "{0} তিনি মাহ পূৰ্বে",
				"future": "{0} তিনি মাহত"
			],
			"month": [
				"previous": "যোৱা মাহ",
				"current": "এই মাহ",
				"next": "অহা মাহ",
				"past": "{0} মাহ পূৰ্বে",
				"future": "{0} মাহত"
			],
			"week": [
				"previous": "যোৱা সপ্তাহ",
				"current": "এই সপ্তাহ",
				"next": "অহা সপ্তাহ",
				"past": "{0} সপ্তাহ পূৰ্বে",
				"future": "{0} সপ্তাহত"
			],
			"day": [
				"previous": "কালি",
				"current": "আজি",
				"next": "কাইলৈ",
				"past": "{0} দিন পূৰ্বে",
				"future": "{0} দিনত"
			],
			"hour": [
				"current": "এইটো ঘণ্টাত",
				"past": "{0} ঘণ্টা পূৰ্বে",
				"future": "{0} ঘণ্টাত"
			],
			"minute": [
				"current": "এইটো মিনিটত",
				"past": "{0} মিনিট পূৰ্বে",
				"future": "{0} মিনিটত"
			],
			"second": [
				"current": "এতিয়া",
				"past": "{0} ছেকেণ্ড পূৰ্বে",
				"future": "{0} ছেকেণ্ডত"
			],
			"now": "এতিয়া"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "যোৱা বছৰ",
				"current": "এই বছৰ",
				"next": "অহা বছৰ",
				"past": "{0} বছৰৰ পূৰ্বে",
				"future": "{0} বছৰত"
			],
			"quarter": [
				"previous": "যোৱা তিনি মাহ",
				"current": "এই তিনি মাহ",
				"next": "অহা তিনি মাহ",
				"past": "{0} তিনি মাহ পূৰ্বে",
				"future": "{0} তিনি মাহত"
			],
			"month": [
				"previous": "যোৱা মাহ",
				"current": "এই মাহ",
				"next": "অহা মাহ",
				"past": "{0} মাহ পূৰ্বে",
				"future": "{0} মাহত"
			],
			"week": [
				"previous": "যোৱা সপ্তাহ",
				"current": "এই সপ্তাহ",
				"next": "অহা সপ্তাহ",
				"past": "{0} সপ্তাহ পূৰ্বে",
				"future": "{0} সপ্তাহত"
			],
			"day": [
				"previous": "কালি",
				"current": "আজি",
				"next": "কাইলৈ",
				"past": "{0} দিন পূৰ্বে",
				"future": "{0} দিনত"
			],
			"hour": [
				"current": "এইটো ঘণ্টাত",
				"past": "{0} ঘণ্টা পূৰ্বে",
				"future": "{0} ঘণ্টাত"
			],
			"minute": [
				"current": "এইটো মিনিটত",
				"past": "{0} মিনিট পূৰ্বে",
				"future": "{0} মিনিটত"
			],
			"second": [
				"current": "এতিয়া",
				"past": "{0} ছেকেণ্ড পূৰ্বে",
				"future": "{0} ছেকেণ্ডত"
			],
			"now": "এতিয়া"
		]
	}
}
