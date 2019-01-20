import Foundation

// swiftlint:disable type_name
public class lang_sl: RelativeFormatterLang {

	/// Slovenian
	public static let identifier: String = "sl"

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
			RelativeFormatter.Flavour.long.rawValue: _long,
			RelativeFormatter.Flavour.narrow.rawValue: _narrow,
			RelativeFormatter.Flavour.short.rawValue: _short
		]
	}

	private var _short: [String: Any] {
		return [
	"year": [
		"previous": "lani",
		"current": "letos",
		"next": "naslednje leto",
		"past": [
			"one": "pred {0} letom",
			"two": "pred {0} letoma",
			"other": "pred {0} leti"
		],
		"future": [
			"one": "čez {0} leto",
			"two": "čez {0} leti",
			"few": "čez {0} leta",
			"other": "čez {0} let"
		]
	],
	"quarter": [
		"previous": "zadnje četrtletje",
		"current": "to četrtletje",
		"next": "naslednje četrtletje",
		"past": "pred {0} četrtl.",
		"future": "čez {0} četrtl."
	],
	"month": [
		"previous": "prejšnji mesec",
		"current": "ta mesec",
		"next": "naslednji mesec",
		"past": "pred {0} mes.",
		"future": "čez {0} mes."
	],
	"week": [
		"previous": "prejšnji teden",
		"current": "ta teden",
		"next": "naslednji teden",
		"past": "pred {0} ted.",
		"future": "čez {0} ted."
	],
	"day": [
		"previous": "včeraj",
		"current": "danes",
		"next": "jutri",
		"past": [
			"one": "pred {0} dnevom",
			"two": "pred {0} dnevoma",
			"other": "pred {0} dnevi"
		],
		"future": [
			"one": "čez {0} dan",
			"two": "čez {0} dneva",
			"other": "čez {0} dni"
		]
	],
	"hour": [
		"current": "v tej uri",
		"past": [
			"one": "pred {0} uro",
			"two": "pred {0} urama",
			"other": "pred {0} urami"
		],
		"future": [
			"one": "čez {0} uro",
			"two": "čez {0} uri",
			"few": "čez {0} ure",
			"other": "čez {0} ur"
		]
	],
	"minute": [
		"current": "to minuto",
		"past": "pred {0} min.",
		"future": "čez {0} min."
	],
	"second": [
		"current": "zdaj",
		"past": "pred {0} s",
		"future": "čez {0} s"
	],
	"now": "zdaj"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "lani",
		"current": "letos",
		"next": "naslednje leto",
		"past": [
			"one": "pred {0} letom",
			"two": "pred {0} letoma",
			"other": "pred {0} leti"
		],
		"future": [
			"one": "čez {0} leto",
			"two": "čez {0} leti",
			"few": "čez {0} leta",
			"other": "čez {0} let"
		]
	],
	"quarter": [
		"previous": "zadnje četrtletje",
		"current": "to četrtletje",
		"next": "naslednje četrtletje",
		"past": "pred {0} četr.",
		"future": "čez {0} četr."
	],
	"month": [
		"previous": "prejšnji mesec",
		"current": "ta mesec",
		"next": "naslednji mesec",
		"past": "pred {0} mes.",
		"future": "čez {0} mes."
	],
	"week": [
		"previous": "prejšnji teden",
		"current": "ta teden",
		"next": "naslednji teden",
		"past": "pred {0} ted.",
		"future": "čez {0} ted."
	],
	"day": [
		"previous": "včeraj",
		"current": "danes",
		"next": "jutri",
		"past": [
			"one": "pred {0} dnevom",
			"two": "pred {0} dnevoma",
			"other": "pred {0} dnevi"
		],
		"future": [
			"one": "čez {0} dan",
			"two": "čez {0} dneva",
			"other": "čez {0} dni"
		]
	],
	"hour": [
		"current": "v tej uri",
		"past": "pred {0} h",
		"future": "čez {0} h"
	],
	"minute": [
		"current": "to minuto",
		"past": "pred {0} min",
		"future": "čez {0} min"
	],
	"second": [
		"current": "zdaj",
		"past": "pred {0} s",
		"future": "čez {0} s"
	],
	"now": "zdaj"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "lani",
		"current": "letos",
		"next": "naslednje leto",
		"past": [
			"one": "pred {0} letom",
			"two": "pred {0} letoma",
			"other": "pred {0} leti"
		],
		"future": [
			"one": "čez {0} leto",
			"two": "čez {0} leti",
			"few": "čez {0} leta",
			"other": "čez {0} let"
		]
	],
	"quarter": [
		"previous": "zadnje četrtletje",
		"current": "to četrtletje",
		"next": "naslednje četrtletje",
		"past": [
			"one": "pred {0} četrtletjem",
			"two": "pred {0} četrtletjema",
			"other": "pred {0} četrtletji"
		],
		"future": [
			"one": "čez {0} četrtletje",
			"two": "čez {0} četrtletji",
			"few": "čez {0} četrtletja",
			"other": "čez {0} četrtletij"
		]
	],
	"month": [
		"previous": "prejšnji mesec",
		"current": "ta mesec",
		"next": "naslednji mesec",
		"past": [
			"one": "pred {0} mesecem",
			"two": "pred {0} mesecema",
			"other": "pred {0} meseci"
		],
		"future": [
			"one": "čez {0} mesec",
			"two": "čez {0} meseca",
			"few": "čez {0} mesece",
			"other": "čez {0} mesecev"
		]
	],
	"week": [
		"previous": "prejšnji teden",
		"current": "ta teden",
		"next": "naslednji teden",
		"past": [
			"one": "pred {0} tednom",
			"two": "pred {0} tednoma",
			"other": "pred {0} tedni"
		],
		"future": [
			"one": "čez {0} teden",
			"two": "čez {0} tedna",
			"few": "čez {0} tedne",
			"other": "čez {0} tednov"
		]
	],
	"day": [
		"previous": "včeraj",
		"current": "danes",
		"next": "jutri",
		"past": [
			"one": "pred {0} dnevom",
			"two": "pred {0} dnevoma",
			"other": "pred {0} dnevi"
		],
		"future": [
			"one": "čez {0} dan",
			"two": "čez {0} dneva",
			"other": "čez {0} dni"
		]
	],
	"hour": [
		"current": "v tej uri",
		"past": [
			"one": "pred {0} uro",
			"two": "pred {0} urama",
			"other": "pred {0} urami"
		],
		"future": [
			"one": "čez {0} uro",
			"two": "čez {0} uri",
			"few": "čez {0} ure",
			"other": "čez {0} ur"
		]
	],
	"minute": [
		"current": "to minuto",
		"past": [
			"one": "pred {0} minuto",
			"two": "pred {0} minutama",
			"other": "pred {0} minutami"
		],
		"future": [
			"one": "čez {0} minuto",
			"two": "čez {0} minuti",
			"few": "čez {0} minute",
			"other": "čez {0} minut"
		]
	],
	"second": [
		"current": "zdaj",
		"past": [
			"one": "pred {0} sekundo",
			"two": "pred {0} sekundama",
			"other": "pred {0} sekundami"
		],
		"future": [
			"one": "čez {0} sekundo",
			"two": "čez {0} sekundi",
			"few": "čez {0} sekunde",
			"other": "čez {0} sekund"
		]
	],
	"now": "zdaj"
]
	}
}
