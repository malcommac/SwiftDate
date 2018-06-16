//
//  lang_am.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name// swiftlint:disable type_name
public class lang_am: RelativeFormatterLang {

	/// Locales.amharic
	public static let identifier: String = "am"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value <= 1 ? .one : .other)
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
				"previous": "ያለፈው ዓመት",
				"current": "በዚህ ዓመት",
				"next": "የሚቀጥለው ዓመት",
				"past": "ከ{0} ዓመታት በፊት",
				"future": "በ{0} ዓመታት ውስጥ"
			],
			"quarter": [
				"previous": "የመጨረሻው ሩብ",
				"current": "ይህ ሩብ",
				"next": "የሚቀጥለው ሩብ",
				"past": "{0} ሩብ በፊት",
				"future": "+{0} ሩብ"
			],
			"month": [
				"previous": "ያለፈው ወር",
				"current": "በዚህ ወር",
				"next": "የሚቀጥለው ወር",
				"past": "ከ{0} ወራት በፊት",
				"future": "በ{0} ወራት ውስጥ"
			],
			"week": [
				"previous": "ባለፈው ሳምንት",
				"current": "በዚህ ሣምንት",
				"next": "የሚቀጥለው ሳምንት",
				"past": "ከ{0} ሳምንታት በፊት",
				"future": "በ{0} ሳምንታት ውስጥ"
			],
			"day": [
				"previous": "ትላንትና",
				"current": "ዛሬ",
				"next": "ነገ",
				"past": [
					"one": "ከ {0} ቀን በፊት",
					"other": "ከ{0} ቀኖች በፊት"
				],
				"future": [
					"one": "በ{0} ቀን ውስጥ",
					"other": "በ{0} ቀኖች ውስጥ"
				]
			],
			"hour": [
				"current": "ይህ ሰዓት",
				"past": [
					"one": "ከ{0} ሰዓት በፊት",
					"other": "ከ{0} ሰዓቶች በፊት"
				],
				"future": [
					"one": "በ{0} ሰዓት ውስጥ",
					"other": "በ{0} ሰዓቶች ውስጥ"
				]
			],
			"minute": [
				"current": "ይህ ደቂቃ",
				"past": [
					"one": "ከ{0} ደቂቃ በፊት",
					"other": "ከ{0} ደቂቃዎች በፊት"
				],
				"future": [
					"one": "በ{0} ደቂቃ ውስጥ",
					"other": "በ{0} ደቂቃዎች ውስጥ"
				]
			],
			"second": [
				"current": "አሁን",
				"past": [
					"one": "ከ{0} ሰከንድ በፊት",
					"other": "ከ{0} ሰከንዶች በፊት"
				],
				"future": [
					"one": "በ{0} ሰከንድ ውስጥ",
					"other": "በ{0} ሰከንዶች ውስጥ"
				]
			],
			"now": "አሁን"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "ያለፈው ዓመት",
				"current": "በዚህ ዓመት",
				"next": "የሚቀጥለው ዓመት",
				"past": "ከ{0} ዓመታት በፊት",
				"future": "በ{0} ዓመታት ውስጥ"
			],
			"quarter": [
				"previous": "የመጨረሻው ሩብ",
				"current": "ይህ ሩብ",
				"next": "የሚቀጥለው ሩብ",
				"past": "{0} ሩብ በፊት",
				"future": "+{0} ሩብ"
			],
			"month": [
				"previous": "ያለፈው ወር",
				"current": "በዚህ ወር",
				"next": "የሚቀጥለው ወር",
				"past": "ከ{0} ወራት በፊት",
				"future": "በ{0} ወራት ውስጥ"
			],
			"week": [
				"previous": "ባለፈው ሳምንት",
				"current": "በዚህ ሣምንት",
				"next": "የሚቀጥለው ሳምንት",
				"past": "ከ{0} ሳምንታት በፊት",
				"future": "በ{0} ሳምንታት ውስጥ"
			],
			"day": [
				"previous": "ትላንትና",
				"current": "ዛሬ",
				"next": "ነገ",
				"past": [
					"one": "ከ {0} ቀን በፊት",
					"other": "ከ{0} ቀኖች በፊት"
				],
				"future": [
					"one": "በ{0} ቀን ውስጥ",
					"other": "በ{0} ቀኖች ውስጥ"
				]
			],
			"hour": [
				"current": "ይህ ሰዓት",
				"past": [
					"one": "ከ{0} ሰዓት በፊት",
					"other": "ከ{0} ሰዓቶች በፊት"
				],
				"future": [
					"one": "በ{0} ሰዓት ውስጥ",
					"other": "በ{0} ሰዓቶች ውስጥ"
				]
			],
			"minute": [
				"current": "ይህ ደቂቃ",
				"past": [
					"one": "ከ{0} ደቂቃ በፊት",
					"other": "ከ{0} ደቂቃዎች በፊት"
				],
				"future": [
					"one": "በ{0} ደቂቃ ውስጥ",
					"other": "በ{0} ደቂቃዎች ውስጥ"
				]
			],
			"second": [
				"current": "አሁን",
				"past": [
					"one": "ከ{0} ሰከንድ በፊት",
					"other": "ከ{0} ሰከንዶች በፊት"
				],
				"future": [
					"one": "በ{0} ሰከንድ ውስጥ",
					"other": "በ{0} ሰከንዶች ውስጥ"
				]
			],
			"now": "አሁን"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "ያለፈው ዓመት",
				"current": "በዚህ ዓመት",
				"next": "የሚቀጥለው ዓመት",
				"past": [
					"one": "ከ{0} ዓመት በፊት",
					"other": "ከ{0} ዓመታት በፊት"
				],
				"future": "በ{0} ዓመታት ውስጥ"
			],
			"quarter": [
				"previous": "የመጨረሻው ሩብ",
				"current": "ይህ ሩብ",
				"next": "የሚቀጥለው ሩብ",
				"past": "{0} ሩብ በፊት",
				"future": "+{0} ሩብ"
			],
			"month": [
				"previous": "ያለፈው ወር",
				"current": "በዚህ ወር",
				"next": "የሚቀጥለው ወር",
				"past": [
					"one": "ከ{0} ወር በፊት",
					"other": "ከ{0} ወራት በፊት"
				],
				"future": [
					"one": "በ{0} ወር ውስጥ",
					"other": "በ{0} ወራት ውስጥ"
				]
			],
			"week": [
				"previous": "ያለፈው ሳምንት",
				"current": "በዚህ ሳምንት",
				"next": "የሚቀጥለው ሳምንት",
				"past": [
					"one": "ከ{0} ሳምንት በፊት",
					"other": "ከ{0} ሳምንታት በፊት"
				],
				"future": [
					"one": "በ{0} ሳምንት ውስጥ",
					"other": "በ{0} ሳምንታት ውስጥ"
				]
			],
			"day": [
				"previous": "ትናንት",
				"current": "ዛሬ",
				"next": "ነገ",
				"past": [
					"one": "ከ{0} ቀን በፊት",
					"other": "ከ{0} ቀናት በፊት"
				],
				"future": [
					"one": "በ{0} ቀን ውስጥ",
					"other": "በ{0} ቀናት ውስጥ"
				]
			],
			"hour": [
				"current": "ይህ ሰዓት",
				"past": [
					"one": "ከ{0} ሰዓት በፊት",
					"other": "ከ{0} ሰዓቶች በፊት"
				],
				"future": [
					"one": "በ{0} ሰዓት ውስጥ",
					"other": "በ{0} ሰዓቶች ውስጥ"
				]
			],
			"minute": [
				"current": "ይህ ደቂቃ",
				"past": [
					"one": "ከ{0} ደቂቃ በፊት",
					"other": "ከ{0} ደቂቃዎች በፊት"
				],
				"future": [
					"one": "በ{0} ደቂቃ ውስጥ",
					"other": "በ{0} ደቂቃዎች ውስጥ"
				]
			],
			"second": [
				"current": "አሁን",
				"past": [
					"one": "ከ{0} ሰከንድ በፊት",
					"other": "ከ{0} ሰከንዶች በፊት"
				],
				"future": [
					"one": "በ{0} ሰከንድ ውስጥ",
					"other": "በ{0} ሰከንዶች ውስጥ"
				]
			],
			"now": "አሁን"
		]
	}
}
