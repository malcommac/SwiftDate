import Foundation

// swiftlint:disable type_name
public class lang_srLatn: RelativeFormatterLang {

	/// Serbian (Latin)
	public static let identifier: String = "sr_Latn"

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
		"next": "sledeće god.",
		"past": "pre {0} god.",
		"future": "za {0} god."
	],
	"quarter": [
		"previous": "prošlog kvartala",
		"current": "ovog kvartala",
		"next": "sledećeg kvartala",
		"past": "pre {0} kv.",
		"future": "za {0} kv."
	],
	"month": [
		"previous": "prošlog mes.",
		"current": "ovog mes.",
		"next": "sledećeg mes.",
		"past": "pre {0} mes.",
		"future": "za {0} mes."
	],
	"week": [
		"previous": "prošle ned.",
		"current": "ove ned.",
		"next": "sledeće ned.",
		"past": "pre {0} ned.",
		"future": "za {0} ned."
	],
	"day": [
		"previous": "juče",
		"current": "danas",
		"next": "sutra",
		"past": "pre {0} d.",
		"future": "za {0} d."
	],
	"hour": [
		"current": "ovog sata",
		"past": "pre {0} č.",
		"future": "za {0} č."
	],
	"minute": [
		"current": "ovog minuta",
		"past": "pre {0} min.",
		"future": "za {0} min."
	],
	"second": [
		"current": "sada",
		"past": "pre {0} sek.",
		"future": "za {0} sek."
	],
	"now": "sada"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "prošle g.",
		"current": "ove g.",
		"next": "sledeće g.",
		"past": "pre {0} g.",
		"future": "za {0} g."
	],
	"quarter": [
		"previous": "prošlog kvartala",
		"current": "ovog kvartala",
		"next": "sledećeg kvartala",
		"past": "pre {0} kv.",
		"future": "za {0} kv."
	],
	"month": [
		"previous": "prošlog m.",
		"current": "ovog m.",
		"next": "sledećeg m.",
		"past": "pre {0} m.",
		"future": "za {0} m."
	],
	"week": [
		"previous": "prošle n.",
		"current": "ove n.",
		"next": "sledeće n.",
		"past": "pre {0} n.",
		"future": "za {0} n."
	],
	"day": [
		"previous": "juče",
		"current": "danas",
		"next": "sutra",
		"past": "pre {0} d.",
		"future": "za {0} d."
	],
	"hour": [
		"current": "ovog sata",
		"past": "pre {0} č.",
		"future": "za {0} č."
	],
	"minute": [
		"current": "ovog minuta",
		"past": "pre {0} min.",
		"future": "za {0} min."
	],
	"second": [
		"current": "sada",
		"past": "pre {0} s.",
		"future": "za {0} s."
	],
	"now": "sada"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "prošle godine",
		"current": "ove godine",
		"next": "sledeće godine",
		"past": [
			"one": "pre {0} godine",
			"few": "pre {0} godine",
			"other": "pre {0} godina"
		],
		"future": [
			"one": "za {0} godinu",
			"few": "za {0} godine",
			"other": "za {0} godina"
		]
	],
	"quarter": [
		"previous": "prošlog kvartala",
		"current": "ovog kvartala",
		"next": "sledećeg kvartala",
		"past": "pre {0} kvartala",
		"future": [
			"one": "za {0} kvartal",
			"other": "za {0} kvartala"
		]
	],
	"month": [
		"previous": "prošlog meseca",
		"current": "ovog meseca",
		"next": "sledećeg meseca",
		"past": [
			"one": "pre {0} meseca",
			"few": "pre {0} meseca",
			"other": "pre {0} meseci"
		],
		"future": [
			"one": "za {0} mesec",
			"few": "za {0} meseca",
			"other": "za {0} meseci"
		]
	],
	"week": [
		"previous": "prošle nedelje",
		"current": "ove nedelje",
		"next": "sledeće nedelje",
		"past": [
			"one": "pre {0} nedelje",
			"few": "pre {0} nedelje",
			"other": "pre {0} nedelja"
		],
		"future": [
			"one": "za {0} nedelju",
			"few": "za {0} nedelje",
			"other": "za {0} nedelja"
		]
	],
	"day": [
		"previous": "juče",
		"current": "danas",
		"next": "sutra",
		"past": "pre {0} dana",
		"future": [
			"one": "za {0} dan",
			"other": "za {0} dana"
		]
	],
	"hour": [
		"current": "ovog sata",
		"past": [
			"one": "pre {0} sata",
			"few": "pre {0} sata",
			"other": "pre {0} sati"
		],
		"future": [
			"one": "za {0} sat",
			"few": "za {0} sata",
			"other": "za {0} sati"
		]
	],
	"minute": [
		"current": "ovog minuta",
		"past": "pre {0} minuta",
		"future": [
			"one": "za {0} minut",
			"other": "za {0} minuta"
		]
	],
	"second": [
		"current": "sada",
		"past": [
			"one": "pre {0} sekunde",
			"few": "pre {0} sekunde",
			"other": "pre {0} sekundi"
		],
		"future": [
			"one": "za {0} sekundu",
			"few": "za {0} sekunde",
			"other": "za {0} sekundi"
		]
	],
	"now": "sada"
]
	}
}
