//
//  lang_br.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_br: RelativeFormatterLang {

	/// Locales.breton
	public static let identifier: String = "br"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let n = Int(value)
		return n % 10 == 1 && n % 100 != 11 && n % 100 != 71 && n % 100 != 91 ? .zero : n % 10 == 2 && n % 100 != 12 && n % 100 != 72 && n % 100 != 92 ? .one : (n % 10 == 3 || n % 10 == 4 || n % 10 == 9) && n % 100 != 13 && n % 100 != 14 && n % 100 != 19 && n % 100 != 73 && n % 100 != 74 && n % 100 != 79 && n % 100 != 93 && n % 100 != 94 && n % 100 != 99 ? .two : n % 1_000_000 == 0 && n != 0 ? .many : .other
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
				"previous": "warlene",
				"current": "hevlene",
				"next": "ar bl. a zeu",
				"past": "{0} bl. zo",
				"future": "a-benn {0} bl."
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "{0} trim. zo",
				"future": "a-benn {0} trim."
			],
			"month": [
				"previous": "ar miz diaraok",
				"current": "ar miz-mañ",
				"next": "ar miz a zeu",
				"past": [
					"two": "{0} viz zo",
					"many": "{0} a vizioù zo",
					"other": "{0} miz zo"
				],
				"future": [
					"two": "a-benn {0} viz",
					"many": "a-benn {0} a vizioù",
					"other": "a-benn {0} miz"
				]
			],
			"week": [
				"previous": "ar sizhun diaraok",
				"current": "ar sizhun-mañ",
				"next": "ar sizhun a zeu",
				"past": [
					"many": "{0} a sizhunioù zo",
					"other": "{0} sizhun zo"
				],
				"future": [
					"many": "a-benn {0} a sizhunioù",
					"other": "a-benn {0} sizhun"
				]
			],
			"day": [
				"previous": "decʼh",
				"current": "hiziv",
				"next": "warcʼhoazh",
				"past": "{0} d zo",
				"future": "a-benn {0} d"
			],
			"hour": [
				"current": "this hour",
				"past": "{0} e zo",
				"future": "a-benn {0} e"
			],
			"minute": [
				"current": "this minute",
				"past": "{0} min zo",
				"future": "a-benn {0} min"
			],
			"second": [
				"current": "brem.",
				"past": "{0} s zo",
				"future": "a-benn {0} s"
			],
			"now": "brem."
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "warlene",
				"current": "hevlene",
				"next": "ar bl. a zeu",
				"past": "-{0} bl.",
				"future": "+{0} bl."
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "-{0} trim.",
				"future": "+{0} trim."
			],
			"month": [
				"previous": "ar miz diaraok",
				"current": "ar miz-mañ",
				"next": "ar miz a zeu",
				"past": "-{0} miz",
				"future": "+{0} miz"
			],
			"week": [
				"previous": "ar sizhun diaraok",
				"current": "ar sizhun-mañ",
				"next": "ar sizhun a zeu",
				"past": [
					"many": "{0} a sizhunioù zo",
					"other": "{0} sizhun zo"
				],
				"future": [
					"many": "a-benn {0} a sizhunioù",
					"other": "a-benn {0} sizhun"
				]
			],
			"day": [
				"previous": "decʼh",
				"current": "hiziv",
				"next": "warcʼhoazh",
				"past": "-{0} d",
				"future": "+{0} d"
			],
			"hour": [
				"current": "this hour",
				"past": "-{0} h",
				"future": "+{0} h"
			],
			"minute": [
				"current": "this minute",
				"past": "-{0} min",
				"future": "+{0} min"
			],
			"second": [
				"current": "brem.",
				"past": "-{0} s",
				"future": "+{0} s"
			],
			"now": "brem."
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "warlene",
				"current": "hevlene",
				"next": "ar bloaz a zeu",
				"past": [
					"one": "{0} bloaz zo",
					"few": "{0} bloaz zo",
					"many": "{0} a vloazioù zo",
					"other": "{0} vloaz zo"
				],
				"future": [
					"one": "a-benn {0} bloaz",
					"few": "a-benn {0} bloaz",
					"many": "a-benn {0} a vloazioù",
					"other": "a-benn {0} vloaz"
				]
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": [
					"two": "{0} drimiziad zo",
					"few": "{0} zrimiziad zo",
					"many": "{0} a zrimiziadoù zo",
					"other": "{0} trimiziad zo"
				],
				"future": [
					"two": "a-benn {0} drimiziad",
					"few": "a-benn {0} zrimiziad",
					"many": "a-benn {0} a drimiziadoù",
					"other": "a-benn {0} trimiziad"
				]
			],
			"month": [
				"previous": "ar miz diaraok",
				"current": "ar miz-mañ",
				"next": "ar miz a zeu",
				"past": [
					"two": "{0} viz zo",
					"many": "{0} a vizioù zo",
					"other": "{0} miz zo"
				],
				"future": [
					"two": "a-benn {0} viz",
					"many": "a-benn {0} a vizioù",
					"other": "a-benn {0} miz"
				]
			],
			"week": [
				"previous": "ar sizhun diaraok",
				"current": "ar sizhun-mañ",
				"next": "ar sizhun a zeu",
				"past": [
					"many": "{0} a sizhunioù zo",
					"other": "{0} sizhun zo"
				],
				"future": [
					"many": "a-benn {0} a sizhunioù",
					"other": "a-benn {0} sizhun"
				]
			],
			"day": [
				"previous": "decʼh",
				"current": "hiziv",
				"next": "warcʼhoazh",
				"past": [
					"two": "{0} zeiz zo",
					"many": "{0} a zeizioù zo",
					"other": "{0} deiz zo"
				],
				"future": [
					"two": "a-benn {0} zeiz",
					"many": "a-benn {0} a zeizioù",
					"other": "a-benn {0} deiz"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"many": "{0} a eurioù zo",
					"other": "{0} eur zo"
				],
				"future": [
					"many": "a-benn {0} a eurioù",
					"other": "a-benn {0} eur"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"two": "{0} vunut zo",
					"many": "{0} a vunutoù zo",
					"other": "{0} munut zo"
				],
				"future": [
					"two": "a-benn {0} vunut",
					"many": "a-benn {0} a vunutoù",
					"other": "a-benn {0} munut"
				]
			],
			"second": [
				"current": "bremañ",
				"past": "{0} eilenn zo",
				"future": [
					"many": "a-benn {0} a eilennoù",
					"other": "a-benn {0} eilenn"
				]
			],
			"now": "bremañ"
		]
	}
}
