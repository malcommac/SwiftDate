//
//  lang_bn.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_bn: RelativeFormatterLang {

	/// Locales.bengali
	public static let identifier: String = "bn"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (Int(value) >= 0 && Int(value) <= 1 ? .one : .other)
	}

	public var flavours: [String: Any] {
		return [
			RelativeFormatter.Flavour.long.rawValue: self._long,
			RelativeFormatter.Flavour.narrow.rawValue: self._narrow,
			RelativeFormatter.Flavour.short.rawValue: self._short
		]
	}

	private var _short: [String: Any] {
		return [
			"year": [
				"previous": "গত বছর",
				"current": "এই বছর",
				"next": "পরের বছর",
				"past": "[0] বছর পূর্বে",
				"future": "[0] বছরে"
			],
			"quarter": [
				"previous": "গত ত্রৈমাসিক",
				"current": "এই ত্রৈমাসিক",
				"next": "পরের ত্রৈমাসিক",
				"past": "[0] ত্রৈমাসিক আগে",
				"future": "[0] ত্রৈমাসিকে"
			],
			"month": [
				"previous": "গত মাস",
				"current": "এই মাস",
				"next": "পরের মাস",
				"past": "[0] মাস আগে",
				"future": "[0] মাসে"
			],
			"week": [
				"previous": "গত সপ্তাহ",
				"current": "এই সপ্তাহ",
				"next": "পরের সপ্তাহ",
				"past": "[0] সপ্তাহ আগে",
				"future": "[0] সপ্তাহে"
			],
			"day": [
				"previous": "গতকাল",
				"current": "আজ",
				"next": "আগামীকাল",
				"past": "[0] দিন আগে",
				"future": "[0] দিনের মধ্যে"
			],
			"hour": [
				"current": "এই ঘণ্টায়",
				"past": "[0] ঘন্টা আগে",
				"future": "[0] ঘন্টায়"
			],
			"minute": [
				"current": "এই মিনিট",
				"past": "[0] মিনিট আগে",
				"future": "[0] মিনিটে"
			],
			"second": [
				"current": "এখন",
				"past": "[0] সেকেন্ড পূর্বে",
				"future": "[0] সেকেন্ডে"
			],
			"now": "এখন"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "গত বছর",
				"current": "এই বছর",
				"next": "পরের বছর",
				"past": "[0] বছর পূর্বে",
				"future": "[0] বছরে"
			],
			"quarter": [
				"previous": "গত ত্রৈমাসিক",
				"current": "এই ত্রৈমাসিক",
				"next": "পরের ত্রৈমাসিক",
				"past": "[0] ত্রৈমাসিক আগে",
				"future": "[0] ত্রৈমাসিকে"
			],
			"month": [
				"previous": "গত মাস",
				"current": "এই মাস",
				"next": "পরের মাস",
				"past": "[0] মাস আগে",
				"future": "[0] মাসে"
			],
			"week": [
				"previous": "গত সপ্তাহ",
				"current": "এই সপ্তাহ",
				"next": "পরের সপ্তাহ",
				"past": "[0] সপ্তাহ আগে",
				"future": "[0] সপ্তাহে"
			],
			"day": [
				"previous": "গতকাল",
				"current": "আজ",
				"next": "আগামীকাল",
				"past": "[0] দিন আগে",
				"future": "[0] দিনের মধ্যে"
			],
			"hour": [
				"current": "এই ঘণ্টায়",
				"past": "[0] ঘন্টা আগে",
				"future": "[0] ঘন্টায়"
			],
			"minute": [
				"current": "এই মিনিট",
				"past": "[0] মিনিট আগে",
				"future": "[0] মিনিটে"
			],
			"second": [
				"current": "এখন",
				"past": "[0] সেকেন্ড আগে",
				"future": "[0] সেকেন্ডে"
			],
			"now": "এখন"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "গত বছর",
				"current": "এই বছর",
				"next": "পরের বছর",
				"past": "[0] বছর পূর্বে",
				"future": "[0] বছরে"
			],
			"quarter": [
				"previous": "গত ত্রৈমাসিক",
				"current": "এই ত্রৈমাসিক",
				"next": "পরের ত্রৈমাসিক",
				"past": "[0] ত্রৈমাসিক আগে",
				"future": "[0] ত্রৈমাসিকে"
			],
			"month": [
				"previous": "গত মাস",
				"current": "এই মাস",
				"next": "পরের মাস",
				"past": "[0] মাস আগে",
				"future": "[0] মাসে"
			],
			"week": [
				"previous": "গত সপ্তাহ",
				"current": "এই সপ্তাহ",
				"next": "পরের সপ্তাহ",
				"past": "[0] সপ্তাহ আগে",
				"future": "[0] সপ্তাহে"
			],
			"day": [
				"previous": "গতকাল",
				"current": "আজ",
				"next": "আগামীকাল",
				"past": "[0] দিন আগে",
				"future": "[0] দিনের মধ্যে"
			],
			"hour": [
				"current": "এই ঘণ্টায়",
				"past": "[0] ঘন্টা আগে",
				"future": "[0] ঘন্টায়"
			],
			"minute": [
				"current": "এই মিনিট",
				"past": "[0] মিনিট আগে",
				"future": "[0] মিনিটে"
			],
			"second": [
				"current": "এখন",
				"past": "[0] সেকেন্ড পূর্বে",
				"future": "[0] সেকেন্ডে"
			],
			"now": "এখন"
		]
	}
}
