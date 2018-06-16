import Foundation

// swiftlint:disable type_name
public class lang_sk: RelativeFormatterLang {

	/// Slovak
	public static let identifier: String = "sk"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1:
			return .one
		case 2...4:
			return .few
		default:
			return .other
		}
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
		"previous": "minulý rok",
		"current": "tento rok",
		"next": "budúci rok",
		"past": "pred {0} r.",
		"future": "o {0} r."
	],
	"quarter": [
		"previous": "minulý štvrťr.",
		"current": "tento štvrťr.",
		"next": "budúci štvrťr.",
		"past": "pred {0} štvrťr.",
		"future": "o {0} štvrťr."
	],
	"month": [
		"previous": "minulý mes.",
		"current": "tento mes.",
		"next": "budúci mes.",
		"past": "pred {0} mes.",
		"future": "o {0} mes."
	],
	"week": [
		"previous": "minulý týž.",
		"current": "tento týž.",
		"next": "budúci týž.",
		"past": "pred {0} týž.",
		"future": "o {0} týž."
	],
	"day": [
		"previous": "včera",
		"current": "dnes",
		"next": "zajtra",
		"past": "pred {0} d.",
		"future": "o {0} d."
	],
	"hour": [
		"current": "v tejto hodine",
		"past": "pred {0} h",
		"future": "o {0} h"
	],
	"minute": [
		"current": "v tejto minúte",
		"past": "pred {0} min",
		"future": "o {0} min"
	],
	"second": [
		"current": "teraz",
		"past": "pred {0} s",
		"future": "o {0} s"
	],
	"now": "teraz"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "minulý rok",
		"current": "tento rok",
		"next": "budúci rok",
		"past": "pred {0} r.",
		"future": "o {0} r."
	],
	"quarter": [
		"previous": "minulý štvrťr.",
		"current": "tento štvrťr.",
		"next": "budúci štvrťr.",
		"past": "pred {0} štvrťr.",
		"future": "o {0} štvrťr."
	],
	"month": [
		"previous": "minulý mes.",
		"current": "tento mes.",
		"next": "budúci mes.",
		"past": "pred {0} mes.",
		"future": "o {0} mes."
	],
	"week": [
		"previous": "minulý týž.",
		"current": "tento týž.",
		"next": "budúci týž.",
		"past": "pred {0} týž.",
		"future": "o {0} týž."
	],
	"day": [
		"previous": "včera",
		"current": "dnes",
		"next": "zajtra",
		"past": "pred {0} d.",
		"future": "o {0} d."
	],
	"hour": [
		"current": "v tejto hodine",
		"past": "pred {0} h",
		"future": "o {0} h"
	],
	"minute": [
		"current": "v tejto minúte",
		"past": "pred {0} min",
		"future": "o {0} min"
	],
	"second": [
		"current": "teraz",
		"past": "pred {0} s",
		"future": "o {0} s"
	],
	"now": "teraz"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "minulý rok",
		"current": "tento rok",
		"next": "budúci rok",
		"past": [
			"one": "pred {0} rokom",
			"many": "pred {0} roka",
			"other": "pred {0} rokmi"
		],
		"future": [
			"one": "o {0} rok",
			"few": "o {0} roky",
			"many": "o {0} roka",
			"other": "o {0} rokov"
		]
	],
	"quarter": [
		"previous": "minulý štvrťrok",
		"current": "tento štvrťrok",
		"next": "budúci štvrťrok",
		"past": [
			"one": "pred {0} štvrťrokom",
			"many": "pred {0} štvrťroka",
			"other": "pred {0} štvrťrokmi"
		],
		"future": [
			"one": "o {0} štvrťrok",
			"few": "o {0} štvrťroky",
			"many": "o {0} štvrťroka",
			"other": "o {0} štvrťrokov"
		]
	],
	"month": [
		"previous": "minulý mesiac",
		"current": "tento mesiac",
		"next": "budúci mesiac",
		"past": [
			"one": "pred {0} mesiacom",
			"many": "pred {0} mesiaca",
			"other": "pred {0} mesiacmi"
		],
		"future": [
			"one": "o {0} mesiac",
			"few": "o {0} mesiace",
			"many": "o {0} mesiaca",
			"other": "o {0} mesiacov"
		]
	],
	"week": [
		"previous": "minulý týždeň",
		"current": "tento týždeň",
		"next": "budúci týždeň",
		"past": [
			"one": "pred {0} týždňom",
			"many": "pred {0} týždňa",
			"other": "pred {0} týždňami"
		],
		"future": [
			"one": "o {0} týždeň",
			"few": "o {0} týždne",
			"many": "o {0} týždňa",
			"other": "o {0} týždňov"
		]
	],
	"day": [
		"previous": "včera",
		"current": "dnes",
		"next": "zajtra",
		"past": [
			"one": "pred {0} dňom",
			"many": "pred {0} dňa",
			"other": "pred {0} dňami"
		],
		"future": [
			"one": "o {0} deň",
			"few": "o {0} dni",
			"many": "o {0} dňa",
			"other": "o {0} dní"
		]
	],
	"hour": [
		"current": "v tejto hodine",
		"past": [
			"one": "pred {0} hodinou",
			"many": "pred {0} hodinou",
			"other": "pred {0} hodinami"
		],
		"future": [
			"one": "o {0} hodinu",
			"few": "o {0} hodiny",
			"many": "o {0} hodiny",
			"other": "o {0} hodín"
		]
	],
	"minute": [
		"current": "v tejto minúte",
		"past": [
			"one": "pred {0} minútou",
			"many": "pred {0} minúty",
			"other": "pred {0} minútami"
		],
		"future": [
			"one": "o {0} minútu",
			"few": "o {0} minúty",
			"many": "o {0} minúty",
			"other": "o {0} minút"
		]
	],
	"second": [
		"current": "teraz",
		"past": [
			"one": "pred {0} sekundou",
			"many": "pred {0} sekundy",
			"other": "pred {0} sekundami"
		],
		"future": [
			"one": "o {0} sekundu",
			"few": "o {0} sekundy",
			"many": "o {0} sekundy",
			"other": "o {0} sekúnd"
		]
	],
	"now": "teraz"
]
	}
}
