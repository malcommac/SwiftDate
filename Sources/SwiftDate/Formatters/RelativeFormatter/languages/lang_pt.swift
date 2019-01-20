import Foundation

// swiftlint:disable type_name
public class lang_pt: RelativeFormatterLang {

	/// Portuguese
	public static let identifier: String = "pt"

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
		"previous": "ano passado",
		"current": "este ano",
		"next": "próximo ano",
		"past": [
			"one": "há {0} ano",
			"other": "há {0} anos"
		],
		"future": [
			"one": "dentro de {0} ano",
			"other": "dentro de {0} anos"
		]
	],
	"quarter": [
		"previous": "trim. passado",
		"current": "este trim.",
		"next": "próximo trim.",
		"past": "há {0} trim.",
		"future": "dentro de {0} trim."
	],
	"month": [
		"previous": "mês passado",
		"current": "este mês",
		"next": "próximo mês",
		"past": [
			"one": "há {0} mês",
			"other": "há {0} meses"
		],
		"future": [
			"one": "dentro de {0} mês",
			"other": "dentro de {0} meses"
		]
	],
	"week": [
		"previous": "semana passada",
		"current": "esta semana",
		"next": "próxima semana",
		"past": "há {0} sem.",
		"future": "dentro de {0} sem."
	],
	"day": [
		"previous": "ontem",
		"current": "hoje",
		"next": "amanhã",
		"past": [
			"one": "há {0} dia",
			"other": "há {0} dias"
		],
		"future": [
			"one": "dentro de {0} dia",
			"other": "dentro de {0} dias"
		]
	],
	"hour": [
		"current": "esta hora",
		"past": "há {0} h",
		"future": "dentro de {0} h"
	],
	"minute": [
		"current": "este minuto",
		"past": "há {0} min",
		"future": "dentro de {0} min"
	],
	"second": [
		"current": "agora",
		"past": "há {0} s",
		"future": "dentro de {0} s"
	],
	"now": "agora"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ano passado",
		"current": "este ano",
		"next": "próximo ano",
		"past": [
			"one": "-{0} ano",
			"other": "-{0} anos"
		],
		"future": [
			"one": "+{0} ano",
			"other": "+{0} anos"
		]
	],
	"quarter": [
		"previous": "trim. passado",
		"current": "este trim.",
		"next": "próximo trim.",
		"past": "-{0} trim.",
		"future": "+{0} trim."
	],
	"month": [
		"previous": "mês passado",
		"current": "este mês",
		"next": "próximo mês",
		"past": [
			"one": "-{0} mês",
			"other": "-{0} meses"
		],
		"future": [
			"one": "+{0} mês",
			"other": "+{0} meses"
		]
	],
	"week": [
		"previous": "semana passada",
		"current": "esta semana",
		"next": "próxima semana",
		"past": "-{0} sem.",
		"future": "+{0} sem."
	],
	"day": [
		"previous": "ontem",
		"current": "hoje",
		"next": "amanhã",
		"past": "há {0} dias",
		"future": [
			"one": "+{0} dia",
			"other": "+{0} dias"
		]
	],
	"hour": [
		"current": "esta hora",
		"past": "-{0} h",
		"future": "+{0} h"
	],
	"minute": [
		"current": "este minuto",
		"past": "-{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "agora",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "agora"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ano passado",
		"current": "este ano",
		"next": "próximo ano",
		"past": [
			"one": "há {0} ano",
			"other": "há {0} anos"
		],
		"future": [
			"one": "dentro de {0} ano",
			"other": "dentro de {0} anos"
		]
	],
	"quarter": [
		"previous": "trimestre passado",
		"current": "este trimestre",
		"next": "próximo trimestre",
		"past": [
			"one": "há {0} trimestre",
			"other": "há {0} trimestres"
		],
		"future": [
			"one": "dentro de {0} trimestre",
			"other": "dentro de {0} trimestres"
		]
	],
	"month": [
		"previous": "mês passado",
		"current": "este mês",
		"next": "próximo mês",
		"past": [
			"one": "há {0} mês",
			"other": "há {0} meses"
		],
		"future": [
			"one": "dentro de {0} mês",
			"other": "dentro de {0} meses"
		]
	],
	"week": [
		"previous": "semana passada",
		"current": "esta semana",
		"next": "próxima semana",
		"past": [
			"one": "há {0} semana",
			"other": "há {0} semanas"
		],
		"future": [
			"one": "dentro de {0} semana",
			"other": "dentro de {0} semanas"
		]
	],
	"day": [
		"previous": "ontem",
		"current": "hoje",
		"next": "amanhã",
		"past": [
			"one": "há {0} dia",
			"other": "há {0} dias"
		],
		"future": [
			"one": "dentro de {0} dia",
			"other": "dentro de {0} dias"
		]
	],
	"hour": [
		"current": "esta hora",
		"past": [
			"one": "há {0} hora",
			"other": "há {0} horas"
		],
		"future": [
			"one": "dentro de {0} hora",
			"other": "dentro de {0} horas"
		]
	],
	"minute": [
		"current": "este minuto",
		"past": [
			"one": "há {0} minuto",
			"other": "há {0} minutos"
		],
		"future": [
			"one": "dentro de {0} minuto",
			"other": "dentro de {0} minutos"
		]
	],
	"second": [
		"current": "agora",
		"past": [
			"one": "há {0} segundo",
			"other": "há {0} segundos"
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
