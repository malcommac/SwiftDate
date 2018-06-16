import Foundation

// swiftlint:disable type_name
public class lang_hr: RelativeFormatterLang {

	/// Croatian
	public static let identifier: String = "hr"

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
			RelativeFormatter.Flavour.long.rawValue: self._long,
			RelativeFormatter.Flavour.narrow.rawValue: self._narrow,
			RelativeFormatter.Flavour.short.rawValue: self._short
		]
	}

	private var _short: [String: Any] {
		return [
	"year": [
		"previous": "prošle god.",
		"current": "ove god.",
		"next": "sljedeće god.",
		"past": "prije {0} g.",
		"future": "za {0} g."
	],
	"quarter": [
		"previous": "prošli kv.",
		"current": "ovaj kv.",
		"next": "sljedeći kv.",
		"past": "prije {0} kv.",
		"future": "za {0} kv."
	],
	"month": [
		"previous": "prošli mj.",
		"current": "ovaj mj.",
		"next": "sljedeći mj.",
		"past": "prije {0} mj.",
		"future": "za {0} mj."
	],
	"week": [
		"previous": "prošli tj.",
		"current": "ovaj tj.",
		"next": "sljedeći tj.",
		"past": "prije {0} tj.",
		"future": "za {0} tj."
	],
	"day": [
		"previous": "jučer",
		"current": "danas",
		"next": "sutra",
		"past": [
			"one": "prije {0} dan",
			"other": "prije {0} dana"
		],
		"future": [
			"one": "za {0} dan",
			"other": "za {0} dana"
		]
	],
	"hour": [
		"current": "ovaj sat",
		"past": "prije {0} h",
		"future": "za {0} h"
	],
	"minute": [
		"current": "ova minuta",
		"past": "prije {0} min",
		"future": "za {0} min"
	],
	"second": [
		"current": "sad",
		"past": "prije {0} s",
		"future": "za {0} s"
	],
	"now": "sad"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "prošle g.",
		"current": "ove g.",
		"next": "sljedeće g.",
		"past": "prije {0} g.",
		"future": "za {0} g."
	],
	"quarter": [
		"previous": "prošli kv.",
		"current": "ovaj kv.",
		"next": "sljedeći kv.",
		"past": "prije {0} kv.",
		"future": "za {0} kv."
	],
	"month": [
		"previous": "prošli mj.",
		"current": "ovaj mj.",
		"next": "sljedeći mj.",
		"past": "prije {0} mj.",
		"future": "za {0} mj."
	],
	"week": [
		"previous": "prošli tj.",
		"current": "ovaj tj.",
		"next": "sljedeći tj.",
		"past": "prije {0} tj.",
		"future": "za {0} tj."
	],
	"day": [
		"previous": "jučer",
		"current": "danas",
		"next": "sutra",
		"past": "prije {0} d",
		"future": "za {0} d"
	],
	"hour": [
		"current": "ovaj sat",
		"past": "prije {0} h",
		"future": "za {0} h"
	],
	"minute": [
		"current": "ova minuta",
		"past": "prije {0} min",
		"future": "za {0} min"
	],
	"second": [
		"current": "sad",
		"past": "prije {0} s",
		"future": "za {0} s"
	],
	"now": "sad"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "prošle godine",
		"current": "ove godine",
		"next": "sljedeće godine",
		"past": [
			"one": "prije {0} godinu",
			"few": "prije {0} godine",
			"other": "prije {0} godina"
		],
		"future": [
			"one": "za {0} godinu",
			"few": "za {0} godine",
			"other": "za {0} godina"
		]
	],
	"quarter": [
		"previous": "prošli kvartal",
		"current": "ovaj kvartal",
		"next": "sljedeći kvartal",
		"past": [
			"one": "prije {0} kvartal",
			"other": "prije {0} kvartala"
		],
		"future": [
			"one": "za {0} kvartal",
			"other": "za {0} kvartala"
		]
	],
	"month": [
		"previous": "prošli mjesec",
		"current": "ovaj mjesec",
		"next": "sljedeći mjesec",
		"past": [
			"one": "prije {0} mjesec",
			"few": "prije {0} mjeseca",
			"other": "prije {0} mjeseci"
		],
		"future": [
			"one": "za {0} mjesec",
			"few": "za {0} mjeseca",
			"other": "za {0} mjeseci"
		]
	],
	"week": [
		"previous": "prošli tjedan",
		"current": "ovaj tjedan",
		"next": "sljedeći tjedan",
		"past": [
			"one": "prije {0} tjedan",
			"few": "prije {0} tjedna",
			"other": "prije {0} tjedana"
		],
		"future": [
			"one": "za {0} tjedan",
			"few": "za {0} tjedna",
			"other": "za {0} tjedana"
		]
	],
	"day": [
		"previous": "jučer",
		"current": "danas",
		"next": "sutra",
		"past": [
			"one": "prije {0} dan",
			"other": "prije {0} dana"
		],
		"future": [
			"one": "za {0} dan",
			"other": "za {0} dana"
		]
	],
	"hour": [
		"current": "ovaj sat",
		"past": [
			"one": "prije {0} sat",
			"few": "prije {0} sata",
			"other": "prije {0} sati"
		],
		"future": [
			"one": "za {0} sat",
			"few": "za {0} sata",
			"other": "za {0} sati"
		]
	],
	"minute": [
		"current": "ova minuta",
		"past": [
			"one": "prije {0} minutu",
			"few": "prije {0} minute",
			"other": "prije {0} minuta"
		],
		"future": [
			"one": "za {0} minutu",
			"few": "za {0} minute",
			"other": "za {0} minuta"
		]
	],
	"second": [
		"current": "sad",
		"past": [
			"one": "prije {0} sekundu",
			"few": "prije {0} sekunde",
			"other": "prije {0} sekundi"
		],
		"future": [
			"one": "za {0} sekundu",
			"few": "za {0} sekunde",
			"other": "za {0} sekundi"
		]
	],
	"now": "sad"
]
	}
}
