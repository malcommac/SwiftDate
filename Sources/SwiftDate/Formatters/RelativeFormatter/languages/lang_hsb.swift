import Foundation

// swiftlint:disable type_name
public class lang_hsb: RelativeFormatterLang {

	/// Upper Sorbian
	public static let identifier: String = "hsb"

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
		"previous": "loni",
		"current": "lětsa",
		"next": "klětu",
		"past": "před {0} l.",
		"future": "za {0} l."
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "před {0} kwart.",
		"future": "za {0} kwart."
	],
	"month": [
		"previous": "zašły měsac",
		"current": "tutón měsac",
		"next": "přichodny měsac",
		"past": "před {0} měs.",
		"future": "za {0} měs."
	],
	"week": [
		"previous": "zašły tydźeń",
		"current": "tutón tydźeń",
		"next": "přichodny tydźeń",
		"past": "před {0} tydź.",
		"future": "za {0} tydź."
	],
	"day": [
		"previous": "wčera",
		"current": "dźensa",
		"next": "jutře",
		"past": "před {0} dnj.",
		"future": [
			"one": "za {0} dźeń",
			"few": "za {0} dny",
			"other": "za {0} dnj."
		]
	],
	"hour": [
		"current": "this hour",
		"past": "před {0} hodź.",
		"future": "za {0} hodź."
	],
	"minute": [
		"current": "this minute",
		"past": "před {0} min.",
		"future": "za {0} min."
	],
	"second": [
		"current": "now",
		"past": "před {0} sek.",
		"future": "za {0} sek."
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "loni",
		"current": "lětsa",
		"next": "klětu",
		"past": "před {0} l.",
		"future": "za {0} l."
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "před {0} kw.",
		"future": "za {0} kw."
	],
	"month": [
		"previous": "zašły měsac",
		"current": "tutón měsac",
		"next": "přichodny měsac",
		"past": "před {0} měs.",
		"future": "za {0} měs."
	],
	"week": [
		"previous": "zašły tydźeń",
		"current": "tutón tydźeń",
		"next": "přichodny tydźeń",
		"past": "před {0} tydź.",
		"future": "za {0} tydź."
	],
	"day": [
		"previous": "wčera",
		"current": "dźensa",
		"next": "jutře",
		"past": "před {0} d",
		"future": "za {0} d"
	],
	"hour": [
		"current": "this hour",
		"past": "před {0} h",
		"future": "za {0} h"
	],
	"minute": [
		"current": "this minute",
		"past": "před {0} m",
		"future": "za {0} m"
	],
	"second": [
		"current": "now",
		"past": "před {0} s",
		"future": "za {0} s"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "loni",
		"current": "lětsa",
		"next": "klětu",
		"past": [
			"one": "před {0} lětom",
			"two": "před {0} lětomaj",
			"other": "před {0} lětami"
		],
		"future": [
			"one": "za {0} lěto",
			"two": "za {0} lěće",
			"few": "za {0} lěta",
			"other": "za {0} lět"
		]
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": [
			"one": "před {0} kwartalom",
			"two": "před {0} kwartalomaj",
			"other": "před {0} kwartalemi"
		],
		"future": [
			"one": "za {0} kwartal",
			"two": "za {0} kwartalej",
			"few": "za {0} kwartale",
			"other": "za {0} kwartalow"
		]
	],
	"month": [
		"previous": "zašły měsac",
		"current": "tutón měsac",
		"next": "přichodny měsac",
		"past": [
			"one": "před {0} měsacom",
			"two": "před {0} měsacomaj",
			"other": "před {0} měsacami"
		],
		"future": [
			"one": "za {0} měsac",
			"two": "za {0} měsacaj",
			"few": "za {0} měsacy",
			"other": "za {0} měsacow"
		]
	],
	"week": [
		"previous": "zašły tydźeń",
		"current": "tutón tydźeń",
		"next": "přichodny tydźeń",
		"past": [
			"one": "před {0} tydźenjom",
			"two": "před {0} tydźenjomaj",
			"other": "před {0} tydźenjemi"
		],
		"future": [
			"one": "za {0} tydźeń",
			"two": "za {0} tydźenjej",
			"few": "za {0} tydźenje",
			"other": "za {0} tydźenjow"
		]
	],
	"day": [
		"previous": "wčera",
		"current": "dźensa",
		"next": "jutře",
		"past": [
			"one": "před {0} dnjom",
			"two": "před {0} dnjomaj",
			"other": "před {0} dnjemi"
		],
		"future": [
			"one": "za {0} dźeń",
			"two": "za {0} dnjej",
			"few": "za {0} dny",
			"other": "za {0} dnjow"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "před {0} hodźinu",
			"two": "před {0} hodźinomaj",
			"other": "před {0} hodźinami"
		],
		"future": [
			"one": "za {0} hodźinu",
			"two": "za {0} hodźinje",
			"few": "za {0} hodźiny",
			"other": "za {0} hodźin"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "před {0} minutu",
			"two": "před {0} minutomaj",
			"other": "před {0} minutami"
		],
		"future": [
			"one": "za {0} minutu",
			"two": "za {0} minuće",
			"few": "za {0} minuty",
			"other": "za {0} minutow"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "před {0} sekundu",
			"two": "před {0} sekundomaj",
			"other": "před {0} sekundami"
		],
		"future": [
			"one": "za {0} sekundu",
			"two": "za {0} sekundźe",
			"few": "za {0} sekundy",
			"other": "za {0} sekundow"
		]
	],
	"now": "now"
]
	}
}
