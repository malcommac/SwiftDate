//
//  lang_es.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_esMX: RelativeFormatterLang {

	/// Locales.spanishMexico
	public static let identifier: String = "es_MX"

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
				"previous": "el año pasado",
				"current": "este año",
				"next": "el próximo año",
				"past": "hace {0} a",
				"future": "dentro de {0} a"
			],
			"quarter": [
				"previous": "el trimestre pasado",
				"current": "este trimestre",
				"next": "el próximo trimestre",
				"past": "hace {0} trim.",
				"future": "dentro de {0} trim."
			],
			"month": [
				"previous": "el mes pasado",
				"current": "este mes",
				"next": "el próximo mes",
				"past": "hace {0} m",
				"future": "dentro de {0} m"
			],
			"week": [
				"previous": "la semana pasada",
				"current": "esta semana",
				"next": "la próxima semana",
				"past": "hace {0} sem.",
				"future": "dentro de {0} sem."
			],
			"day": [
				"previous": "ayer",
				"current": "hoy",
				"next": "mañana",
				"past": [
					"one": "hace {0} día",
					"other": "hace {0} días"
				],
				"future": [
					"one": "dentro de {0} día",
					"other": "dentro de {0} días"
				]
			],
			"hour": [
				"current": "esta hora",
				"past": "hace {0} h",
				"future": "dentro de {0} h"
			],
			"minute": [
				"current": "este minuto",
				"past": "hace {0} min",
				"future": "dentro de {0} min"
			],
			"second": [
				"current": "ahora",
				"past": "hace {0} seg.",
				"future": "dentro de {0} seg."
			],
			"now": "ahora"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "el año pasado",
				"current": "este año",
				"next": "el próximo año",
				"past": "hace {0} a",
				"future": "dentro de {0} a"
			],
			"quarter": [
				"previous": "el trimestre pasado",
				"current": "este trimestre",
				"next": "el próximo trimestre",
				"past": "hace {0} trim.",
				"future": "dentro de {0} trim."
			],
			"month": [
				"previous": "el mes pasado",
				"current": "este mes",
				"next": "el próximo mes",
				"past": "hace {0} m",
				"future": "dentro de {0} m"
			],
			"week": [
				"previous": "la semana pasada",
				"current": "esta semana",
				"next": "la próxima semana",
				"past": "hace {0} sem.",
				"future": "dentro de {0} sem."
			],
			"day": [
				"previous": "ayer",
				"current": "hoy",
				"next": "mañana",
				"past": [
					"one": "hace {0} día",
					"other": "hace {0} días"
				],
				"future": [
					"one": "dentro de {0} día",
					"other": "dentro de {0} días"
				]
			],
			"hour": [
				"current": "esta hora",
				"past": "hace {0} h",
				"future": "dentro de {0} h"
			],
			"minute": [
				"current": "este minuto",
				"past": "hace {0} min",
				"future": "dentro de {0} min"
			],
			"second": [
				"current": "ahora",
				"past": "hace {0} seg.",
				"future": "dentro de {0} seg."
			],
			"now": "ahora"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "el año pasado",
				"current": "este año",
				"next": "el próximo año",
				"past": [
					"one": "hace {0} año",
					"other": "hace {0} años"
				],
				"future": [
					"one": "dentro de {0} año",
					"other": "dentro de {0} años"
				]
			],
			"quarter": [
				"previous": "el trimestre pasado",
				"current": "este trimestre",
				"next": "el próximo trimestre",
				"past": [
					"one": "hace {0} trimestre",
					"other": "hace {0} trimestres"
				],
				"future": [
					"one": "dentro de {0} trimestre",
					"other": "dentro de {0} trimestres"
				]
			],
			"month": [
				"previous": "el mes pasado",
				"current": "este mes",
				"next": "el próximo mes",
				"past": [
					"one": "hace {0} mes",
					"other": "hace {0} meses"
				],
				"future": [
					"one": "dentro de {0} mes",
					"other": "dentro de {0} meses"
				]
			],
			"week": [
				"previous": "la semana pasada",
				"current": "esta semana",
				"next": "la próxima semana",
				"past": [
					"one": "hace {0} semana",
					"other": "hace {0} semanas"
				],
				"future": [
					"one": "dentro de {0} semana",
					"other": "dentro de {0} semanas"
				]
			],
			"day": [
				"previous": "ayer",
				"current": "hoy",
				"next": "mañana",
				"past": [
					"one": "hace {0} día",
					"other": "hace {0} días"
				],
				"future": [
					"one": "dentro de {0} día",
					"other": "dentro de {0} días"
				]
			],
			"hour": [
				"current": "esta hora",
				"past": [
					"one": "hace {0} hora",
					"other": "hace {0} horas"
				],
				"future": [
					"one": "dentro de {0} hora",
					"other": "dentro de {0} horas"
				]
			],
			"minute": [
				"current": "este minuto",
				"past": [
					"one": "hace {0} minuto",
					"other": "hace {0} minutos"
				],
				"future": [
					"one": "dentro de {0} minuto",
					"other": "dentro de {0} minutos"
				]
			],
			"second": [
				"current": "ahora",
				"past": [
					"one": "hace {0} segundo",
					"other": "hace {0} segundos"
				],
				"future": [
					"one": "dentro de {0} segundo",
					"other": "dentro de {0} segundos"
				]
			],
			"now": "ahora"
		]
	}
}
