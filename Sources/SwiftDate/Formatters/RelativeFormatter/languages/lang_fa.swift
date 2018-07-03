//
//  lang_fa.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_fa: RelativeFormatterLang {

	/// Locales.persian
	public static let identifier: String = "fa"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value <= 1 ? .one : .other)
	}

	// module.exports=function(e){var i=String(e).split("."),n=Number(i{0})==e,r=n&&i{0}.slice(-1),s=n&&i{0}.slice(-2);return 1==r&&11!=s?"one":r>=2&&r<=4&&(s<12||s>14)?"few":n&&0==r||r>=5&&r<=9||s>=11&&s<=14?"many":"other"}
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
				"previous": "سال گذشته",
				"current": "امسال",
				"next": "سال آینده",
				"past": "{0} سال پیش",
				"future": "{0} سال بعد"
			],
			"quarter": [
				"previous": "سه‌ماههٔ گذشته",
				"current": "سه‌ماههٔ کنونی",
				"next": "سه‌ماههٔ آینده",
				"past": "{0} سه‌ماههٔ پیش",
				"future": "{0} سه‌ماههٔ بعد"
			],
			"month": [
				"previous": "ماه پیش",
				"current": "این ماه",
				"next": "ماه آینده",
				"past": "{0} ماه پیش",
				"future": "{0} ماه بعد"
			],
			"week": [
				"previous": "هفتهٔ گذشته",
				"current": "این هفته",
				"next": "هفتهٔ آینده",
				"past": "{0} هفته پیش",
				"future": "{0} هفته بعد"
			],
			"day": [
				"previous": "دیروز",
				"current": "امروز",
				"next": "فردا",
				"past": "{0} روز پیش",
				"future": "{0} روز بعد"
			],
			"hour": [
				"current": "همین ساعت",
				"past": "{0} ساعت پیش",
				"future": "{0} ساعت بعد"
			],
			"minute": [
				"current": "همین دقیقه",
				"past": "{0} دقیقه پیش",
				"future": "{0} دقیقه بعد"
			],
			"second": [
				"current": "اکنون",
				"past": "{0} ثانیه پیش",
				"future": "{0} ثانیه بعد"
			],
			"now": "اکنون"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "سال گذشته",
				"current": "امسال",
				"next": "سال آینده",
				"past": "{0} سال پیش",
				"future": "{0} سال بعد"
			],
			"quarter": [
				"previous": "سه‌ماههٔ گذشته",
				"current": "سه‌ماههٔ کنونی",
				"next": "سه‌ماههٔ آینده",
				"past": "{0} سه‌ماههٔ پیش",
				"future": "{0} سه‌ماههٔ بعد"
			],
			"month": [
				"previous": "ماه پیش",
				"current": "این ماه",
				"next": "ماه آینده",
				"past": "{0} ماه پیش",
				"future": "{0} ماه بعد"
			],
			"week": [
				"previous": "هفتهٔ گذشته",
				"current": "این هفته",
				"next": "هفتهٔ آینده",
				"past": "{0} هفته پیش",
				"future": "{0} هفته بعد"
			],
			"day": [
				"previous": "دیروز",
				"current": "امروز",
				"next": "فردا",
				"past": "{0} روز پیش",
				"future": "{0} روز بعد"
			],
			"hour": [
				"current": "همین ساعت",
				"past": "{0} ساعت پیش",
				"future": "{0} ساعت بعد"
			],
			"minute": [
				"current": "همین دقیقه",
				"past": "{0} دقیقه پیش",
				"future": "{0} دقیقه بعد"
			],
			"second": [
				"current": "اکنون",
				"past": "{0} ثانیه پیش",
				"future": "{0} ثانیه بعد"
			],
			"now": "اکنون"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "سال گذشته",
				"current": "امسال",
				"next": "سال آینده",
				"past": "{0} سال پیش",
				"future": "{0} سال بعد"
			],
			"quarter": [
				"previous": "سه‌ماههٔ گذشته",
				"current": "سه‌ماههٔ کنونی",
				"next": "سه‌ماههٔ آینده",
				"past": "{0} سه‌ماههٔ پیش",
				"future": "{0} سه‌ماههٔ بعد"
			],
			"month": [
				"previous": "ماه گذشته",
				"current": "این ماه",
				"next": "ماه آینده",
				"past": "{0} ماه پیش",
				"future": "{0} ماه بعد"
			],
			"week": [
				"previous": "هفتهٔ گذشته",
				"current": "این هفته",
				"next": "هفتهٔ آینده",
				"past": "{0} هفته پیش",
				"future": "{0} هفته بعد"
			],
			"day": [
				"previous": "دیروز",
				"current": "امروز",
				"next": "فردا",
				"past": "{0} روز پیش",
				"future": "{0} روز بعد"
			],
			"hour": [
				"current": "همین ساعت",
				"past": "{0} ساعت پیش",
				"future": "{0} ساعت بعد"
			],
			"minute": [
				"current": "همین دقیقه",
				"past": "{0} دقیقه پیش",
				"future": "{0} دقیقه بعد"
			],
			"second": [
				"current": "اکنون",
				"past": "{0} ثانیه پیش",
				"future": "{0} ثانیه بعد"
			],
			"now": "اکنون"
		]
	}
}
