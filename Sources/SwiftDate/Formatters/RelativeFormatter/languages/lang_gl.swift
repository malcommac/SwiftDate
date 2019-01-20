import Foundation

// swiftlint:disable type_name
public class lang_gl: RelativeFormatterLang {

	/// Galician
	public static let identifier: String = "gl"

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
		"previous": "ano pasado",
		"current": "este ano",
		"next": "seguinte ano",
		"past": [
			"one": "hai {0} ano",
			"other": "hai {0} anos"
		],
		"future": [
			"one": "dentro de {0} ano",
			"other": "dentro de {0} anos"
		]
	],
	"quarter": [
		"previous": "trim. pasado",
		"current": "este trim.",
		"next": "trim. seguinte",
		"past": "hai {0} trim.",
		"future": "dentro de {0} trim."
	],
	"month": [
		"previous": "m. pasado",
		"current": "este m.",
		"next": "m. seguinte",
		"past": [
			"one": "hai {0} mes",
			"other": "hai {0} mes."
		],
		"future": [
			"one": "dentro de {0} mes",
			"other": "dentro de {0} mes."
		]
	],
	"week": [
		"previous": "sem. pasada",
		"current": "esta sem.",
		"next": "sem. seguinte",
		"past": "hai {0} sem.",
		"future": "dentro de {0} sem."
	],
	"day": [
		"previous": "onte",
		"current": "hoxe",
		"next": "mañá",
		"past": [
			"one": "hai {0} día",
			"other": "hai {0} días"
		],
		"future": [
			"one": "dentro de {0} día",
			"other": "dentro de {0} días"
		]
	],
	"hour": [
		"current": "esta hora",
		"past": "hai {0} h",
		"future": "dentro de {0} h"
	],
	"minute": [
		"current": "este minuto",
		"past": "hai {0} min",
		"future": "dentro de {0} min"
	],
	"second": [
		"current": "agora",
		"past": "hai {0} s",
		"future": "dentro de {0} s"
	],
	"now": "agora"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ano pasado",
		"current": "este ano",
		"next": "seguinte ano",
		"past": "hai {0} a.",
		"future": "en {0} a."
	],
	"quarter": [
		"previous": "trim. pasado",
		"current": "este trim.",
		"next": "trim. seguinte",
		"past": "hai {0} trim.",
		"future": "en {0} trim."
	],
	"month": [
		"previous": "m. pasado",
		"current": "este m.",
		"next": "m. seguinte",
		"past": "hai {0} m.",
		"future": "en {0} m."
	],
	"week": [
		"previous": "sem. pasada",
		"current": "esta sem.",
		"next": "sem. seguinte",
		"past": "hai {0} sem.",
		"future": "en {0} sem."
	],
	"day": [
		"previous": "onte",
		"current": "hoxe",
		"next": "mañá",
		"past": "hai {0} d.",
		"future": "en {0} d."
	],
	"hour": [
		"current": "esta hora",
		"past": "hai {0} h",
		"future": "en {0} h"
	],
	"minute": [
		"current": "este minuto",
		"past": "hai {0} min",
		"future": "en {0} min"
	],
	"second": [
		"current": "agora",
		"past": "hai {0} s",
		"future": "en {0} s"
	],
	"now": "agora"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "o ano pasado",
		"current": "este ano",
		"next": "o próximo ano",
		"past": [
			"one": "hai {0} ano",
			"other": "hai {0} anos"
		],
		"future": [
			"one": "dentro de {0} ano",
			"other": "dentro de {0} anos"
		]
	],
	"quarter": [
		"previous": "o trimestre pasado",
		"current": "este trimestre",
		"next": "o próximo trimestre",
		"past": [
			"one": "hai {0} trimestre",
			"other": "hai {0} trimestres"
		],
		"future": [
			"one": "dentro de {0} trimestre",
			"other": "dentro de {0} trimestres"
		]
	],
	"month": [
		"previous": "o mes pasado",
		"current": "este mes",
		"next": "o próximo mes",
		"past": [
			"one": "hai {0} mes",
			"other": "hai {0} meses"
		],
		"future": [
			"one": "dentro de {0} mes",
			"other": "dentro de {0} meses"
		]
	],
	"week": [
		"previous": "a semana pasada",
		"current": "esta semana",
		"next": "a próxima semana",
		"past": [
			"one": "hai {0} semana",
			"other": "hai {0} semanas"
		],
		"future": [
			"one": "dentro de {0} semana",
			"other": "dentro de {0} semanas"
		]
	],
	"day": [
		"previous": "onte",
		"current": "hoxe",
		"next": "mañá",
		"past": [
			"one": "hai {0} día",
			"other": "hai {0} días"
		],
		"future": [
			"one": "dentro de {0} día",
			"other": "dentro de {0} días"
		]
	],
	"hour": [
		"current": "esta hora",
		"past": [
			"one": "hai {0} hora",
			"other": "hai {0} horas"
		],
		"future": [
			"one": "dentro de {0} hora",
			"other": "dentro de {0} horas"
		]
	],
	"minute": [
		"current": "este minuto",
		"past": [
			"one": "hai {0} minuto",
			"other": "hai {0} minutos"
		],
		"future": [
			"one": "dentro de {0} minuto",
			"other": "dentro de {0} minutos"
		]
	],
	"second": [
		"current": "agora",
		"past": [
			"one": "hai {0} segundo",
			"other": "hai {0} segundos"
		],
		"future": [
			"one": "dentro de {0} segundo",
			"other": "dentro de {0} segundos"
		]
	],
	"now": "agora"
]
	}
}
