//
//  lang_it.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_it: RelativeFormatterLang {

	/// Locales.italian
	public static let identifier: String = "it"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
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
				"previous": "anno scorso",
				"current": "quest’anno",
				"next": "anno prossimo",
				"past": [
					"one": "{0} anno fa",
					"other": "{0} anni fa"
				],
				"future": [
					"one": "tra {0} anno",
					"other": "tra {0} anni"
				]
			],
			"quarter": [
				"previous": "trimestre scorso",
				"current": "questo trimestre",
				"next": "trimestre prossimo",
				"past": "{0} trim. fa",
				"future": "tra {0} trim."
			],
			"month": [
				"previous": "mese scorso",
				"current": "questo mese",
				"next": "mese prossimo",
				"past": [
					"one": "{0} mese fa",
					"other": "{0} mesi fa"
				],
				"future": [
					"one": "tra {0} mese",
					"other": "tra {0} mesi"
				]
			],
			"week": [
				"previous": "settimana scorsa",
				"current": "questa settimana",
				"next": "settimana prossima",
				"past": "{0} sett. fa",
				"future": "tra {0} sett."
			],
			"day": [
				"previous": "ieri",
				"current": "oggi",
				"next": "domani",
				"past": [
					"one": "{0}g fa",
					"other": "{0}gg fa"
				],
				"future": [
					"one": "tra {0} g",
					"other": "tra {0} gg"
				]
			],
			"hour": [
				"current": "quest’ora",
				"past": "{0}h fa",
				"future": "tra {0}h"
			],
			"minute": [
				"current": "questo minuto",
				"past": "{0} min fa",
				"future": "tra {0} min"
			],
			"second": [
				"current": "ora",
				"past": [
					"one": "{0}s fa",
					"other": "{0} sec. fa"
				],
				"future": [
					"one": "tra {0}s",
					"other": "tra {0} sec."
				]
			],
			"now": "ora"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "anno scorso",
				"current": "quest’anno",
				"next": "anno prossimo",
				"past": [
					"one": "{0} anno fa",
					"other": "{0} anni fa"
				],
				"future": [
					"one": "tra {0} anno",
					"other": "tra {0} anni"
				]
			],
			"quarter": [
				"previous": "trimestre scorso",
				"current": "questo trimestre",
				"next": "trimestre prossimo",
				"past": "{0} trim. fa",
				"future": "tra {0} trim."
			],
			"month": [
				"previous": "mese scorso",
				"current": "questo mese",
				"next": "mese prossimo",
				"past": [
					"one": "{0} mese fa",
					"other": "{0} mesi fa"
				],
				"future": [
					"one": "tra {0} mese",
					"other": "tra {0} mesi"
				]
			],
			"week": [
				"previous": "settimana scorsa",
				"current": "questa settimana",
				"next": "settimana prossima",
				"past": "{0} sett. fa",
				"future": "tra {0} sett."
			],
			"day": [
				"previous": "ieri",
				"current": "oggi",
				"next": "domani",
				"past": [
					"one": "{0}g fa",
					"other": "{0} gg fa"
				],
				"future": [
					"one": "tra {0}g",
					"other": "tra {0} gg"
				]
			],
			"hour": [
				"current": "quest’ora",
				"past": "{0}h fa",
				"future": "tra {0} h"
			],
			"minute": [
				"current": "questo minuto",
				"past": "{0} min fa",
				"future": "tra {0} min"
			],
			"second": [
				"current": "ora",
				"past": "{0}s fa",
				"future": "tra {0} s"
			],
			"now": "ora"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "anno scorso",
				"current": "quest’anno",
				"next": "anno prossimo",
				"past": [
					"one": "{0} anno fa",
					"other": "{0} anni fa"
				],
				"future": [
					"one": "tra {0} anno",
					"other": "tra {0} anni"
				]
			],
			"quarter": [
				"previous": "trimestre scorso",
				"current": "questo trimestre",
				"next": "trimestre prossimo",
				"past": [
					"one": "{0} trimestre fa",
					"other": "{0} trimestri fa"
				],
				"future": [
					"one": "tra {0} trimestre",
					"other": "tra {0} trimestri"
				]
			],
			"month": [
				"previous": "mese scorso",
				"current": "questo mese",
				"next": "mese prossimo",
				"past": [
					"one": "{0} mese fa",
					"other": "{0} mesi fa"
				],
				"future": [
					"one": "tra {0} mese",
					"other": "tra {0} mesi"
				]
			],
			"week": [
				"previous": "settimana scorsa",
				"current": "questa settimana",
				"next": "settimana prossima",
				"past": [
					"one": "{0} settimana fa",
					"other": "{0} settimane fa"
				],
				"future": [
					"one": "tra {0} settimana",
					"other": "tra {0} settimane"
				]
			],
			"day": [
				"previous": "ieri",
				"current": "oggi",
				"next": "domani",
				"past": [
					"one": "{0} giorno fa",
					"other": "{0} giorni fa"
				],
				"future": [
					"one": "tra {0} giorno",
					"other": "tra {0} giorni"
				]
			],
			"hour": [
				"current": "quest’ora",
				"past": [
					"one": "{0} ora fa",
					"other": "{0} ore fa"
				],
				"future": [
					"one": "tra {0} ora",
					"other": "tra {0} ore"
				]
			],
			"minute": [
				"current": "questo minuto",
				"past": [
					"one": "{0} minuto fa",
					"other": "{0} minuti fa"
				],
				"future": [
					"one": "tra {0} minuto",
					"other": "tra {0} minuti"
				]
			],
			"second": [
				"current": "ora",
				"past": [
					"one": "{0} secondo fa",
					"other": "{0} secondi fa"
				],
				"future": [
					"one": "tra {0} secondo",
					"other": "tra {0} secondi"
				]
			],
			"now": "ora"
		]
	}

}
