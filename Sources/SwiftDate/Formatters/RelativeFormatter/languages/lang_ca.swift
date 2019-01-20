//
//  lang_ca.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_ca: RelativeFormatterLang {

	/// Locales.catalan
	public static let identifier: String = "ca"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1:		return .one
		default:	return .other
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
				"previous": "l’any passat",
				"current": "enguany",
				"next": "l’any que ve",
				"past": [
					"one": "fa {0} any",
					"other": "fa {0} anys"
				],
				"future": [
					"one": "d’aquí a {0} any",
					"other": "d’aquí a {0} anys"
				]
			],
			"quarter": [
				"previous": "el trim. passat",
				"current": "aquest trim.",
				"next": "el trim. que ve",
				"past": "fa {0} trim.",
				"future": "d’aquí a {0} trim."
			],
			"month": [
				"previous": "el mes passat",
				"current": "aquest mes",
				"next": "el mes que ve",
				"past": [
					"one": "fa {0} mes",
					"other": "fa {0} mesos"
				],
				"future": [
					"one": "d’aquí a {0} mes",
					"other": "d’aquí a {0} mesos"
				]
			],
			"week": [
				"previous": "la setm. passada",
				"current": "aquesta setm.",
				"next": "la setm. que ve",
				"past": "fa {0} setm.",
				"future": "d’aquí a {0} setm."
			],
			"day": [
				"previous": "ahir",
				"current": "avui",
				"next": "demà",
				"past": [
					"one": "fa {0} dia",
					"other": "fa {0} dies"
				],
				"future": [
					"one": "d’aquí a {0} dia",
					"other": "d’aquí a {0} dies"
				]
			],
			"hour": [
				"current": "aquesta hora",
				"past": "fa {0} h",
				"future": "d’aquí a {0} h"
			],
			"minute": [
				"current": "aquest minut",
				"past": "fa {0} min",
				"future": "d’aquí a {0} min"
			],
			"second": [
				"current": "ara",
				"past": "fa {0} s",
				"future": "d’aquí a {0} s"
			],
			"now": "ara"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "l’any passat",
				"current": "enguany",
				"next": "l’any que ve",
				"past": [
					"one": "fa {0} any",
					"other": "fa {0} anys"
				],
				"future": [
					"one": "d’aquí a {0} any",
					"other": "d’aquí a {0} anys"
				]
			],
			"quarter": [
				"previous": "trim. passat",
				"current": "aquest trim.",
				"next": "trim. vinent",
				"past": "fa {0} trim.",
				"future": "d’aquí a {0} trim."
			],
			"month": [
				"previous": "mes passat",
				"current": "aquest mes",
				"next": "mes vinent",
				"past": [
					"one": "fa {0} mes",
					"other": "fa {0} mesos"
				],
				"future": [
					"one": "d’aquí a {0} mes",
					"other": "d’aquí a {0} mesos"
				]
			],
			"week": [
				"previous": "setm. passada",
				"current": "aquesta setm.",
				"next": "setm. vinent",
				"past": "fa {0} setm.",
				"future": "d’aquí a {0} setm."
			],
			"day": [
				"previous": "ahir",
				"current": "avui",
				"next": "demà",
				"past": [
					"one": "fa {0} dia",
					"other": "fa {0} dies"
				],
				"future": [
					"one": "d’aquí a {0} dia",
					"other": "d’aquí a {0} dies"
				]
			],
			"hour": [
				"current": "aquesta hora",
				"past": "fa {0} h",
				"future": "d‘aquí a {0} h"
			],
			"minute": [
				"current": "aquest minut",
				"past": "fa {0} min",
				"future": "d’aquí a {0} min"
			],
			"second": [
				"current": "ara",
				"past": "fa {0} s",
				"future": "d’aquí a {0} s"
			],
			"now": "ara"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "l’any passat",
				"current": "enguany",
				"next": "l’any que ve",
				"past": [
					"one": "fa {0} any",
					"other": "fa {0} anys"
				],
				"future": [
					"one": "d’aquí a {0} any",
					"other": "d’aquí a {0} anys"
				]
			],
			"quarter": [
				"previous": "el trimestre passat",
				"current": "aquest trimestre",
				"next": "el trimestre que ve",
				"past": [
					"one": "fa {0} trimestre",
					"other": "fa {0} trimestres"
				],
				"future": [
					"one": "d’aquí a {0} trimestre",
					"other": "d’aquí a {0} trimestres"
				]
			],
			"month": [
				"previous": "el mes passat",
				"current": "aquest mes",
				"next": "el mes que ve",
				"past": [
					"one": "fa {0} mes",
					"other": "fa {0} mesos"
				],
				"future": [
					"one": "d’aquí a {0} mes",
					"other": "d’aquí a {0} mesos"
				]
			],
			"week": [
				"previous": "la setmana passada",
				"current": "aquesta setmana",
				"next": "la setmana que ve",
				"past": [
					"one": "fa {0} setmana",
					"other": "fa {0} setmanes"
				],
				"future": [
					"one": "d’aquí a {0} setmana",
					"other": "d’aquí a {0} setmanes"
				]
			],
			"day": [
				"previous": "ahir",
				"current": "avui",
				"next": "demà",
				"past": [
					"one": "fa {0} dia",
					"other": "fa {0} dies"
				],
				"future": [
					"one": "d’aquí a {0} dia",
					"other": "d’aquí a {0} dies"
				]
			],
			"hour": [
				"current": "aquesta hora",
				"past": [
					"one": "fa {0} hora",
					"other": "fa {0} hores"
				],
				"future": [
					"one": "d’aquí a {0} hora",
					"other": "d’aquí a {0} hores"
				]
			],
			"minute": [
				"current": "aquest minut",
				"past": [
					"one": "fa {0} minut",
					"other": "fa {0} minuts"
				],
				"future": [
					"one": "d’aquí a {0} minut",
					"other": "d’aquí a {0} minuts"
				]
			],
			"second": [
				"current": "ara",
				"past": [
					"one": "fa {0} segon",
					"other": "fa {0} segons"
				],
				"future": [
					"one": "d’aquí a {0} segon",
					"other": "d’aquí a {0} segons"
				]
			],
			"now": "ara"
		]
	}
}
