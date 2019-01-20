//
//  lang_be.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_be: RelativeFormatterLang {

	/// Locales.belarusian
	public static let identifier: String = "be"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		let mod100 = Int(value) % 100

		switch mod10 {
		case 1:
			switch mod100 {
			case 11:
				break
			default:
				return .one
			}
		case 2, 3, 4:
			switch mod100 {
			case 12, 13, 14:
				break
			default:
				return .few
			}
		default:
			break
		}
		return .many
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
				"previous": "у мінулым годзе",
				"current": "у гэтым годзе",
				"next": "у наступным годзе",
				"past": "{0} г. таму",
				"future": "праз {0} г."
			],
			"quarter": [
				"previous": "у мінулым квартале",
				"current": "у гэтым квартале",
				"next": "у наступным квартале",
				"past": "{0} кв. таму",
				"future": "праз {0} кв."
			],
			"month": [
				"previous": "у мінулым месяцы",
				"current": "у гэтым месяцы",
				"next": "у наступным месяцы",
				"past": "{0} мес. таму",
				"future": "праз {0} мес."
			],
			"week": [
				"previous": "на мінулым тыдні",
				"current": "на гэтым тыдні",
				"next": "на наступным тыдні",
				"past": "{0} тыд таму",
				"future": "праз {0} тыд"
			],
			"day": [
				"previous": "учора",
				"current": "сёння",
				"next": "заўтра",
				"past": [
					"one": "{0} дзень таму",
					"few": "{0} дні таму",
					"many": "{0} дзён таму",
					"other": "{0} дня таму"
				],
				"future": [
					"one": "праз {0} дзень",
					"few": "праз {0} дні",
					"many": "праз {0} дзён",
					"other": "праз {0} дня"
				]
			],
			"hour": [
				"current": "у гэту гадзіну",
				"past": "{0} гадз таму",
				"future": "праз {0} гадз"
			],
			"minute": [
				"current": "у гэту хвіліну",
				"past": "{0} хв таму",
				"future": "праз {0} хв"
			],
			"second": [
				"current": "цяпер",
				"past": "{0} с таму",
				"future": "праз {0} с"
			],
			"now": "цяпер"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "у мінулым годзе",
				"current": "у гэтым годзе",
				"next": "у наступным годзе",
				"past": "{0} г. таму",
				"future": "праз {0} г."
			],
			"quarter": [
				"previous": "у мінулым квартале",
				"current": "у гэтым квартале",
				"next": "у наступным квартале",
				"past": "{0} кв. таму",
				"future": "праз {0} кв."
			],
			"month": [
				"previous": "у мінулым месяцы",
				"current": "у гэтым месяцы",
				"next": "у наступным месяцы",
				"past": "{0} мес. таму",
				"future": "праз {0} мес."
			],
			"week": [
				"previous": "на мінулым тыдні",
				"current": "на гэтым тыдні",
				"next": "на наступным тыдні",
				"past": "{0} тыд таму",
				"future": "праз {0} тыд"
			],
			"day": [
				"previous": "учора",
				"current": "сёння",
				"next": "заўтра",
				"past": [
					"one": "{0} дзень таму",
					"few": "{0} дні таму",
					"many": "{0} дзён таму",
					"other": "{0} дня таму"
				],
				"future": [
					"one": "праз {0} дзень",
					"few": "праз {0} дні",
					"many": "праз {0} дзён",
					"other": "праз {0} дня"
				]
			],
			"hour": [
				"current": "у гэту гадзіну",
				"past": "{0} гадз таму",
				"future": "праз {0} гадз"
			],
			"minute": [
				"current": "у гэту хвіліну",
				"past": "{0} хв таму",
				"future": "праз {0} хв"
			],
			"second": [
				"current": "цяпер",
				"past": "{0} с таму",
				"future": "праз {0} с"
			],
			"now": "цяпер"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "у мінулым годзе",
				"current": "у гэтым годзе",
				"next": "у наступным годзе",
				"past": [
					"one": "{0} год таму",
					"few": "{0} гады таму",
					"many": "{0} гадоў таму",
					"other": "{0} года таму"
				],
				"future": [
					"one": "праз {0} год",
					"few": "праз {0} гады",
					"many": "праз {0} гадоў",
					"other": "праз {0} года"
				]
			],
			"quarter": [
				"previous": "у мінулым квартале",
				"current": "у гэтым квартале",
				"next": "у наступным квартале",
				"past": [
					"one": "{0} квартал таму",
					"few": "{0} кварталы таму",
					"many": "{0} кварталаў таму",
					"other": "{0} квартала таму"
				],
				"future": [
					"one": "праз {0} квартал",
					"few": "праз {0} кварталы",
					"many": "праз {0} кварталаў",
					"other": "праз {0} квартала"
				]
			],
			"month": [
				"previous": "у мінулым месяцы",
				"current": "у гэтым месяцы",
				"next": "у наступным месяцы",
				"past": [
					"one": "{0} месяц таму",
					"few": "{0} месяцы таму",
					"many": "{0} месяцаў таму",
					"other": "{0} месяца таму"
				],
				"future": [
					"one": "праз {0} месяц",
					"few": "праз {0} месяцы",
					"many": "праз {0} месяцаў",
					"other": "праз {0} месяца"
				]
			],
			"week": [
				"previous": "на мінулым тыдні",
				"current": "на гэтым тыдні",
				"next": "на наступным тыдні",
				"past": [
					"one": "{0} тыдзень таму",
					"few": "{0} тыдні таму",
					"many": "{0} тыдняў таму",
					"other": "{0} тыдня таму"
				],
				"future": [
					"one": "праз {0} тыдзень",
					"few": "праз {0} тыдні",
					"many": "праз {0} тыдняў",
					"other": "праз {0} тыдня"
				]
			],
			"day": [
				"previous": "учора",
				"current": "сёння",
				"next": "заўтра",
				"past": [
					"one": "{0} дзень таму",
					"few": "{0} дні таму",
					"many": "{0} дзён таму",
					"other": "{0} дня таму"
				],
				"future": [
					"one": "праз {0} дзень",
					"few": "праз {0} дні",
					"many": "праз {0} дзён",
					"other": "праз {0} дня"
				]
			],
			"hour": [
				"current": "у гэту гадзіну",
				"past": [
					"one": "{0} гадзіну таму",
					"many": "{0} гадзін таму",
					"other": "{0} гадзіны таму"
				],
				"future": [
					"one": "праз {0} гадзіну",
					"many": "праз {0} гадзін",
					"other": "праз {0} гадзіны"
				]
			],
			"minute": [
				"current": "у гэту хвіліну",
				"past": [
					"one": "{0} хвіліну таму",
					"many": "{0} хвілін таму",
					"other": "{0} хвіліны таму"
				],
				"future": [
					"one": "праз {0} хвіліну",
					"many": "праз {0} хвілін",
					"other": "праз {0} хвіліны"
				]
			],
			"second": [
				"current": "цяпер",
				"past": [
					"one": "{0} секунду таму",
					"many": "{0} секунд таму",
					"other": "{0} секунды таму"
				],
				"future": [
					"one": "праз {0} секунду",
					"many": "праз {0} секунд",
					"other": "праз {0} секунды"
				]
			],
			"now": "цяпер"
		]
	}
}
