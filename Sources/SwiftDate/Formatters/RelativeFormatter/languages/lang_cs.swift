//
//  lang_ccp.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_cs: RelativeFormatterLang {

	/// Locales.czech
	public static let identifier: String = "cs"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1:
			return .one
		case 2, 3, 4:
			return .few
		default:
			return .other
		}
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
				"previous": "minulý rok",
				"current": "tento rok",
				"next": "příští rok",
				"past": [
					"one": "před {0} r.",
					"few": "před {0} r.",
					"many": "před {0} r.",
					"other": "před {0} l."
				],
				"future": [
					"one": "za {0} r.",
					"few": "za {0} r.",
					"many": "za {0} r.",
					"other": "za {0} l."
				]
			],
			"quarter": [
				"previous": "minulé čtvrtletí",
				"current": "toto čtvrtletí",
				"next": "příští čtvrtletí",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "minulý měs.",
				"current": "tento měs.",
				"next": "příští měs.",
				"past": "před {0} měs.",
				"future": "za {0} měs."
			],
			"week": [
				"previous": "minulý týd.",
				"current": "tento týd.",
				"next": "příští týd.",
				"past": "před {0} týd.",
				"future": "za {0} týd."
			],
			"day": [
				"previous": "včera",
				"current": "dnes",
				"next": "zítra",
				"past": [
					"one": "před {0} dnem",
					"many": "před {0} dne",
					"other": "před {0} dny"
				],
				"future": [
					"one": "za {0} den",
					"few": "za {0} dny",
					"many": "za {0} dne",
					"other": "za {0} dní"
				]
			],
			"hour": [
				"current": "tuto hodinu",
				"past": "před {0} h",
				"future": "za {0} h"
			],
			"minute": [
				"current": "tuto minutu",
				"past": "před {0} min",
				"future": "za {0} min"
			],
			"second": [
				"current": "nyní",
				"past": "před {0} s",
				"future": "za {0} s"
			],
			"now": "nyní"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "minulý rok",
				"current": "tento rok",
				"next": "příští rok",
				"past": [
					"one": "před {0} r.",
					"few": "před {0} r.",
					"many": "před {0} r.",
					"other": "před {0} l."
				],
				"future": [
					"one": "za {0} r.",
					"few": "za {0} r.",
					"many": "za {0} r.",
					"other": "za {0} l."
				]
			],
			"quarter": [
				"previous": "minulé čtvrtletí",
				"current": "toto čtvrtletí",
				"next": "příští čtvrtletí",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "minuý měs.",
				"current": "tento měs.",
				"next": "příští měs.",
				"past": "před {0} měs.",
				"future": "za {0} měs."
			],
			"week": [
				"previous": "minulý týd.",
				"current": "tento týd.",
				"next": "příští týd.",
				"past": "před {0} týd.",
				"future": "za {0} týd."
			],
			"day": [
				"previous": "včera",
				"current": "dnes",
				"next": "zítra",
				"past": [
					"one": "před {0} dnem",
					"many": "před {0} dne",
					"other": "před {0} dny"
				],
				"future": [
					"one": "za {0} den",
					"few": "za {0} dny",
					"many": "za {0} dne",
					"other": "za {0} dní"
				]
			],
			"hour": [
				"current": "tuto hodinu",
				"past": "před {0} h",
				"future": "za {0} h"
			],
			"minute": [
				"current": "tuto minutu",
				"past": "před {0} min",
				"future": "za {0} min"
			],
			"second": [
				"current": "nyní",
				"past": "před {0} s",
				"future": "za {0} s"
			],
			"now": "nyní"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "minulý rok",
				"current": "tento rok",
				"next": "příští rok",
				"past": [
					"one": "před {0} rokem",
					"many": "před {0} roku",
					"other": "před {0} lety"
				],
				"future": [
					"one": "za {0} rok",
					"few": "za {0} roky",
					"many": "za {0} roku",
					"other": "za {0} let"
				]
			],
			"quarter": [
				"previous": "minulé čtvrtletí",
				"current": "toto čtvrtletí",
				"next": "příští čtvrtletí",
				"past": [
					"one": "před {0} čtvrtletím",
					"many": "před {0} čtvrtletí",
					"other": "před {0} čtvrtletími"
				],
				"future": "za {0} čtvrtletí"
			],
			"month": [
				"previous": "minulý měsíc",
				"current": "tento měsíc",
				"next": "příští měsíc",
				"past": [
					"one": "před {0} měsícem",
					"many": "před {0} měsíce",
					"other": "před {0} měsíci"
				],
				"future": [
					"one": "za {0} měsíc",
					"few": "za {0} měsíce",
					"many": "za {0} měsíce",
					"other": "za {0} měsíců"
				]
			],
			"week": [
				"previous": "minulý týden",
				"current": "tento týden",
				"next": "příští týden",
				"past": [
					"one": "před {0} týdnem",
					"many": "před {0} týdne",
					"other": "před {0} týdny"
				],
				"future": [
					"one": "za {0} týden",
					"few": "za {0} týdny",
					"many": "za {0} týdne",
					"other": "za {0} týdnů"
				]
			],
			"day": [
				"previous": "včera",
				"current": "dnes",
				"next": "zítra",
				"past": [
					"one": "před {0} dnem",
					"many": "před {0} dne",
					"other": "před {0} dny"
				],
				"future": [
					"one": "za {0} den",
					"few": "za {0} dny",
					"many": "za {0} dne",
					"other": "za {0} dní"
				]
			],
			"hour": [
				"current": "tuto hodinu",
				"past": [
					"one": "před {0} hodinou",
					"many": "před {0} hodiny",
					"other": "před {0} hodinami"
				],
				"future": [
					"one": "za {0} hodinu",
					"few": "za {0} hodiny",
					"many": "za {0} hodiny",
					"other": "za {0} hodin"
				]
			],
			"minute": [
				"current": "tuto minutu",
				"past": [
					"one": "před {0} minutou",
					"many": "před {0} minuty",
					"other": "před {0} minutami"
				],
				"future": [
					"one": "za {0} minutu",
					"few": "za {0} minuty",
					"many": "za {0} minuty",
					"other": "za {0} minut"
				]
			],
			"second": [
				"current": "nyní",
				"past": [
					"one": "před {0} sekundou",
					"many": "před {0} sekundy",
					"other": "před {0} sekundami"
				],
				"future": [
					"one": "za {0} sekundu",
					"few": "za {0} sekundy",
					"many": "za {0} sekundy",
					"other": "za {0} sekund"
				]
			],
			"now": "nyní"
		]
	}
}
