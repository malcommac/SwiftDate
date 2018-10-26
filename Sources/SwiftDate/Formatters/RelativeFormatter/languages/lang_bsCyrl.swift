//
//  lang_bsCyrl.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_bsCyrl: RelativeFormatterLang {

	/// Locales.belarusian
	public static let identifier: String = "bs-Cyrl"

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
				"previous": "Прошле године",
				"current": "Ове године",
				"next": "Следеће године",
				"past": [
					"one": "пре {0} годину",
					"few": "пре {0} године",
					"other": "пре {0} година"
				],
				"future": [
					"one": "за {0} годину",
					"few": "за {0} године",
					"other": "за {0} година"
				]
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "Прошлог месеца",
				"current": "Овог месеца",
				"next": "Следећег месеца",
				"past": [
					"one": "пре {0} месец",
					"few": "пре {0} месеца",
					"other": "пре {0} месеци"
				],
				"future": [
					"one": "за {0} месец",
					"few": "за {0} месеца",
					"other": "за {0} месеци"
				]
			],
			"week": [
				"previous": "Прошле недеље",
				"current": "Ове недеље",
				"next": "Следеће недеље",
				"past": [
					"one": "пре {0} недељу",
					"few": "пре {0} недеље",
					"other": "пре {0} недеља"
				],
				"future": [
					"one": "за {0} недељу",
					"few": "за {0} недеље",
					"other": "за {0} недеља"
				]
			],
			"day": [
				"previous": "јуче",
				"current": "данас",
				"next": "сутра",
				"past": [
					"one": "пре {0} дан",
					"other": "пре {0} дана"
				],
				"future": [
					"one": "за {0} дан",
					"other": "за {0} дана"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "пре {0} сат",
					"few": "пре {0} сата",
					"other": "пре {0} сати"
				],
				"future": [
					"one": "за {0} сат",
					"few": "за {0} сата",
					"other": "за {0} сати"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "пре {0} минут",
					"other": "пре {0} минута"
				],
				"future": [
					"one": "за {0} минут",
					"other": "за {0} минута"
				]
			],
			"second": [
				"current": "now",
				"past": [
					"one": "пре {0} секунд",
					"few": "пре {0} секунде",
					"other": "пре {0} секунди"
				],
				"future": [
					"one": "за {0} секунд",
					"few": "за {0} секунде",
					"other": "за {0} секунди"
				]
			],
			"now": "now"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "Прошле године",
				"current": "Ове године",
				"next": "Следеће године",
				"past": [
					"one": "пре {0} годину",
					"few": "пре {0} године",
					"other": "пре {0} година"
				],
				"future": [
					"one": "за {0} годину",
					"few": "за {0} године",
					"other": "за {0} година"
				]
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "Прошлог месеца",
				"current": "Овог месеца",
				"next": "Следећег месеца",
				"past": [
					"one": "пре {0} месец",
					"few": "пре {0} месеца",
					"other": "пре {0} месеци"
				],
				"future": [
					"one": "за {0} месец",
					"few": "за {0} месеца",
					"other": "за {0} месеци"
				]
			],
			"week": [
				"previous": "Прошле недеље",
				"current": "Ове недеље",
				"next": "Следеће недеље",
				"past": [
					"one": "пре {0} недељу",
					"few": "пре {0} недеље",
					"other": "пре {0} недеља"
				],
				"future": [
					"one": "за {0} недељу",
					"few": "за {0} недеље",
					"other": "за {0} недеља"
				]
			],
			"day": [
				"previous": "јуче",
				"current": "данас",
				"next": "сутра",
				"past": [
					"one": "пре {0} дан",
					"other": "пре {0} дана"
				],
				"future": [
					"one": "за {0} дан",
					"other": "за {0} дана"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "пре {0} сат",
					"few": "пре {0} сата",
					"other": "пре {0} сати"
				],
				"future": [
					"one": "за {0} сат",
					"few": "за {0} сата",
					"other": "за {0} сати"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "пре {0} минут",
					"other": "пре {0} минута"
				],
				"future": [
					"one": "за {0} минут",
					"other": "за {0} минута"
				]
			],
			"second": [
				"current": "now",
				"past": [
					"one": "пре {0} секунд",
					"few": "пре {0} секунде",
					"other": "пре {0} секунди"
				],
				"future": [
					"one": "за {0} секунд",
					"few": "за {0} секунде",
					"other": "за {0} секунди"
				]
			],
			"now": "now"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "Прошле године",
				"current": "Ове године",
				"next": "Следеће године",
				"past": [
					"one": "пре {0} годину",
					"few": "пре {0} године",
					"other": "пре {0} година"
				],
				"future": [
					"one": "за {0} годину",
					"few": "за {0} године",
					"other": "за {0} година"
				]
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "Прошлог месеца",
				"current": "Овог месеца",
				"next": "Следећег месеца",
				"past": [
					"one": "пре {0} месец",
					"few": "пре {0} месеца",
					"other": "пре {0} месеци"
				],
				"future": [
					"one": "за {0} месец",
					"few": "за {0} месеца",
					"other": "за {0} месеци"
				]
			],
			"week": [
				"previous": "Прошле недеље",
				"current": "Ове недеље",
				"next": "Следеће недеље",
				"past": [
					"one": "пре {0} недељу",
					"few": "пре {0} недеље",
					"other": "пре {0} недеља"
				],
				"future": [
					"one": "за {0} недељу",
					"few": "за {0} недеље",
					"other": "за {0} недеља"
				]
			],
			"day": [
				"previous": "јуче",
				"current": "данас",
				"next": "сутра",
				"past": [
					"one": "пре {0} дан",
					"other": "пре {0} дана"
				],
				"future": [
					"one": "за {0} дан",
					"other": "за {0} дана"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "пре {0} сат",
					"few": "пре {0} сата",
					"other": "пре {0} сати"
				],
				"future": [
					"one": "за {0} сат",
					"few": "за {0} сата",
					"other": "за {0} сати"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "пре {0} минут",
					"other": "пре {0} минута"
				],
				"future": [
					"one": "за {0} минут",
					"other": "за {0} минута"
				]
			],
			"second": [
				"current": "now",
				"past": [
					"one": "пре {0} секунд",
					"few": "пре {0} секунде",
					"other": "пре {0} секунди"
				],
				"future": [
					"one": "за {0} секунд",
					"few": "за {0} секунде",
					"other": "за {0} секунди"
				]
			],
			"now": "now"
		]
	}
}
