import Foundation

// swiftlint:disable type_name
public class lang_is: RelativeFormatterLang {

	/// Icelandic
	public static let identifier: String = "is"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		let mod100 = Int(value) % 100

		if value == 0 {
			return .zero
		}

		if value == 1 {
			return .one
		}

		switch mod10 {
		case 1:
			if mod100 != 11 {
				return .one
			}
		default:
			break
		}

		return .many
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
		"previous": "á síðasta ári",
		"current": "á þessu ári",
		"next": "á næsta ári",
		"past": [
			"one": "fyrir {0} ári",
			"other": "fyrir {0} árum"
		],
		"future": "eftir {0} ár"
	],
	"quarter": [
		"previous": "síðasti ársfj.",
		"current": "þessi ársfj.",
		"next": "næsti ársfj.",
		"past": "fyrir {0} ársfj.",
		"future": "eftir {0} ársfj."
	],
	"month": [
		"previous": "í síðasta mán.",
		"current": "í þessum mán.",
		"next": "í næsta mán.",
		"past": "fyrir {0} mán.",
		"future": "eftir {0} mán."
	],
	"week": [
		"previous": "í síðustu viku",
		"current": "í þessari viku",
		"next": "í næstu viku",
		"past": [
			"one": "fyrir {0} viku",
			"other": "fyrir {0} vikum"
		],
		"future": "eftir {0} vikur"
	],
	"day": [
		"previous": "í gær",
		"current": "í dag",
		"next": "á morgun",
		"past": [
			"one": "fyrir {0} degi",
			"other": "fyrir {0} dögum"
		],
		"future": [
			"one": "eftir {0} dag",
			"other": "eftir {0} daga"
		]
	],
	"hour": [
		"current": "þessa stundina",
		"past": "fyrir {0} klst.",
		"future": "eftir {0} klst."
	],
	"minute": [
		"current": "á þessari mínútu",
		"past": "fyrir {0} mín.",
		"future": "eftir {0} mín."
	],
	"second": [
		"current": "núna",
		"past": "fyrir {0} sek.",
		"future": "eftir {0} sek."
	],
	"now": "núna"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "á síðasta ári",
		"current": "á þessu ári",
		"next": "á næsta ári",
		"past": "fyrir {0} árum",
		"future": "eftir {0} ár"
	],
	"quarter": [
		"previous": "síðasti ársfj.",
		"current": "þessi ársfj.",
		"next": "næsti ársfj.",
		"past": "fyrir {0} ársfj.",
		"future": "eftir {0} ársfj."
	],
	"month": [
		"previous": "í síðasta mán.",
		"current": "í þessum mán.",
		"next": "í næsta mán.",
		"past": "fyrir {0} mán.",
		"future": "eftir {0} mán."
	],
	"week": [
		"previous": "í síðustu viku",
		"current": "í þessari viku",
		"next": "í næstu viku",
		"past": [
			"one": "-{0} viku",
			"other": "-{0} vikur"
		],
		"future": [
			"one": "+{0} viku",
			"other": "+{0} vikur"
		]
	],
	"day": [
		"previous": "í gær",
		"current": "í dag",
		"next": "á morgun",
		"past": [
			"one": "-{0} degi",
			"other": "-{0} dögum"
		],
		"future": [
			"one": "+{0} dag",
			"other": "+{0} daga"
		]
	],
	"hour": [
		"current": "þessa stundina",
		"past": "-{0} klst.",
		"future": "+{0} klst."
	],
	"minute": [
		"current": "á þessari mínútu",
		"past": "-{0} mín.",
		"future": "+{0} mín."
	],
	"second": [
		"current": "núna",
		"past": "-{0} sek.",
		"future": "+{0} sek."
	],
	"now": "núna"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "á síðasta ári",
		"current": "á þessu ári",
		"next": "á næsta ári",
		"past": [
			"one": "fyrir {0} ári",
			"other": "fyrir {0} árum"
		],
		"future": "eftir {0} ár"
	],
	"quarter": [
		"previous": "síðasti ársfjórðungur",
		"current": "þessi ársfjórðungur",
		"next": "næsti ársfjórðungur",
		"past": [
			"one": "fyrir {0} ársfjórðungi",
			"other": "fyrir {0} ársfjórðungum"
		],
		"future": [
			"one": "eftir {0} ársfjórðung",
			"other": "eftir {0} ársfjórðunga"
		]
	],
	"month": [
		"previous": "í síðasta mánuði",
		"current": "í þessum mánuði",
		"next": "í næsta mánuði",
		"past": [
			"one": "fyrir {0} mánuði",
			"other": "fyrir {0} mánuðum"
		],
		"future": [
			"one": "eftir {0} mánuð",
			"other": "eftir {0} mánuði"
		]
	],
	"week": [
		"previous": "í síðustu viku",
		"current": "í þessari viku",
		"next": "í næstu viku",
		"past": [
			"one": "fyrir {0} viku",
			"other": "fyrir {0} vikum"
		],
		"future": [
			"one": "eftir {0} viku",
			"other": "eftir {0} vikur"
		]
	],
	"day": [
		"previous": "í gær",
		"current": "í dag",
		"next": "á morgun",
		"past": [
			"one": "fyrir {0} degi",
			"other": "fyrir {0} dögum"
		],
		"future": [
			"one": "eftir {0} dag",
			"other": "eftir {0} daga"
		]
	],
	"hour": [
		"current": "þessa stundina",
		"past": [
			"one": "fyrir {0} klukkustund",
			"other": "fyrir {0} klukkustundum"
		],
		"future": [
			"one": "eftir {0} klukkustund",
			"other": "eftir {0} klukkustundir"
		]
	],
	"minute": [
		"current": "á þessari mínútu",
		"past": [
			"one": "fyrir {0} mínútu",
			"other": "fyrir {0} mínútum"
		],
		"future": [
			"one": "eftir {0} mínútu",
			"other": "eftir {0} mínútur"
		]
	],
	"second": [
		"current": "núna",
		"past": [
			"one": "fyrir {0} sekúndu",
			"other": "fyrir {0} sekúndum"
		],
		"future": [
			"one": "eftir {0} sekúndu",
			"other": "eftir {0} sekúndur"
		]
	],
	"now": "núna"
]
	}
}
