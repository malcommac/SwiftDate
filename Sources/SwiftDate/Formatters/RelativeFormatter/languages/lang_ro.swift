import Foundation

// swiftlint:disable type_name
public class lang_ro: RelativeFormatterLang {

	/// Romanian
	public static let identifier: String = "ro"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod100 = Int(value) % 100

		switch value {
		case 0:
			return .few
		case 1:
			return .one
		default:
			if mod100 > 1 && mod100 <= 19 {
				return .few
			}
		}

		return .other
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
		"previous": "anul trecut",
		"current": "anul acesta",
		"next": "anul viitor",
		"past": [
			"one": "acum {0} an",
			"few": "acum {0} ani",
			"other": "acum {0} de ani"
		],
		"future": [
			"one": "peste {0} an",
			"few": "peste {0} ani",
			"other": "peste {0} de ani"
		]
	],
	"quarter": [
		"previous": "trim. trecut",
		"current": "trim. acesta",
		"next": "trim. viitor",
		"past": "acum {0} trim.",
		"future": "peste {0} trim."
	],
	"month": [
		"previous": "luna trecută",
		"current": "luna aceasta",
		"next": "luna viitoare",
		"past": [
			"one": "acum {0} lună",
			"other": "acum {0} luni"
		],
		"future": [
			"one": "peste {0} lună",
			"other": "peste {0} luni"
		]
	],
	"week": [
		"previous": "săptămâna trecută",
		"current": "săptămâna aceasta",
		"next": "săptămâna viitoare",
		"past": "acum {0} săpt.",
		"future": "peste {0} săpt."
	],
	"day": [
		"previous": "ieri",
		"current": "azi",
		"next": "mâine",
		"past": [
			"one": "acum {0} zi",
			"few": "acum {0} zile",
			"other": "acum {0} de zile"
		],
		"future": [
			"one": "peste {0} zi",
			"few": "peste {0} zile",
			"other": "peste {0} de zile"
		]
	],
	"hour": [
		"current": "ora aceasta",
		"past": "acum {0} h",
		"future": "peste {0} h"
	],
	"minute": [
		"current": "minutul acesta",
		"past": "acum {0} min.",
		"future": "peste {0} min."
	],
	"second": [
		"current": "acum",
		"past": "acum {0} sec.",
		"future": "peste {0} sec."
	],
	"now": "acum"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "anul trecut",
		"current": "anul acesta",
		"next": "anul viitor",
		"past": [
			"one": "-{0} an",
			"other": "-{0} ani"
		],
		"future": [
			"one": "+{0} an",
			"other": "+{0} ani"
		]
	],
	"quarter": [
		"previous": "trim. trecut",
		"current": "trim. acesta",
		"next": "trim. viitor",
		"past": "-{0} trim.",
		"future": "+{0} trim."
	],
	"month": [
		"previous": "luna trecută",
		"current": "luna aceasta",
		"next": "luna viitoare",
		"past": [
			"one": "-{0} lună",
			"other": "-{0} luni"
		],
		"future": [
			"one": "+{0} lună",
			"other": "+{0} luni"
		]
	],
	"week": [
		"previous": "săptămâna trecută",
		"current": "săptămâna aceasta",
		"next": "săptămâna viitoare",
		"past": "-{0} săpt.",
		"future": "+{0} săpt."
	],
	"day": [
		"previous": "ieri",
		"current": "azi",
		"next": "mâine",
		"past": [
			"one": "-{0} zi",
			"other": "-{0} zile"
		],
		"future": [
			"one": "+{0} zi",
			"other": "+{0} zile"
		]
	],
	"hour": [
		"current": "ora aceasta",
		"past": "-{0} h",
		"future": "+{0} h"
	],
	"minute": [
		"current": "minutul acesta",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"second": [
		"current": "acum",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "acum"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "anul trecut",
		"current": "anul acesta",
		"next": "anul viitor",
		"past": [
			"one": "acum {0} an",
			"few": "acum {0} ani",
			"other": "acum {0} de ani"
		],
		"future": [
			"one": "peste {0} an",
			"few": "peste {0} ani",
			"other": "peste {0} de ani"
		]
	],
	"quarter": [
		"previous": "trimestrul trecut",
		"current": "trimestrul acesta",
		"next": "trimestrul viitor",
		"past": [
			"one": "acum {0} trimestru",
			"few": "acum {0} trimestre",
			"other": "acum {0} de trimestre"
		],
		"future": [
			"one": "peste {0} trimestru",
			"few": "peste {0} trimestre",
			"other": "peste {0} de trimestre"
		]
	],
	"month": [
		"previous": "luna trecută",
		"current": "luna aceasta",
		"next": "luna viitoare",
		"past": [
			"one": "acum {0} lună",
			"few": "acum {0} luni",
			"other": "acum {0} de luni"
		],
		"future": [
			"one": "peste {0} lună",
			"few": "peste {0} luni",
			"other": "peste {0} de luni"
		]
	],
	"week": [
		"previous": "săptămâna trecută",
		"current": "săptămâna aceasta",
		"next": "săptămâna viitoare",
		"past": [
			"one": "acum {0} săptămână",
			"few": "acum {0} săptămâni",
			"other": "acum {0} de săptămâni"
		],
		"future": [
			"one": "peste {0} săptămână",
			"few": "peste {0} săptămâni",
			"other": "peste {0} de săptămâni"
		]
	],
	"day": [
		"previous": "ieri",
		"current": "azi",
		"next": "mâine",
		"past": [
			"one": "acum {0} zi",
			"few": "acum {0} zile",
			"other": "acum {0} de zile"
		],
		"future": [
			"one": "peste {0} zi",
			"few": "peste {0} zile",
			"other": "peste {0} de zile"
		]
	],
	"hour": [
		"current": "ora aceasta",
		"past": [
			"one": "acum {0} oră",
			"few": "acum {0} ore",
			"other": "acum {0} de ore"
		],
		"future": [
			"one": "peste {0} oră",
			"few": "peste {0} ore",
			"other": "peste {0} de ore"
		]
	],
	"minute": [
		"current": "minutul acesta",
		"past": [
			"one": "acum {0} minut",
			"few": "acum {0} minute",
			"other": "acum {0} de minute"
		],
		"future": [
			"one": "peste {0} minut",
			"few": "peste {0} minute",
			"other": "peste {0} de minute"
		]
	],
	"second": [
		"current": "acum",
		"past": [
			"one": "acum {0} secundă",
			"few": "acum {0} secunde",
			"other": "acum {0} de secunde"
		],
		"future": [
			"one": "peste {0} secundă",
			"few": "peste {0} secunde",
			"other": "peste {0} de secunde"
		]
	],
	"now": "acum"
]
	}
}
