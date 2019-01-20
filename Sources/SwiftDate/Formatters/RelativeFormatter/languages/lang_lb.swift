import Foundation

// swiftlint:disable type_name
public class lang_lb: RelativeFormatterLang {

	/// Luxembourgish
	public static let identifier: String = "lb"

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
		"previous": "lescht Joer",
		"current": "dëst Joer",
		"next": "nächst Joer",
		"past": [
			"one": "virun {0} J.",
			"other": "viru(n) {0} J."
		],
		"future": [
			"one": "an {0} J.",
			"other": "a(n) {0} J."
		]
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": [
			"one": "virun {0} Q.",
			"other": "viru(n) {0} Q."
		],
		"future": [
			"one": "an {0} Q.",
			"other": "a(n) {0} Q."
		]
	],
	"month": [
		"previous": "leschte Mount",
		"current": "dëse Mount",
		"next": "nächste Mount",
		"past": [
			"one": "virun {0} M.",
			"other": "viru(n) {0} M."
		],
		"future": [
			"one": "an {0} M.",
			"other": "a(n) {0} M."
		]
	],
	"week": [
		"previous": "lescht Woch",
		"current": "dës Woch",
		"next": "nächst Woch",
		"past": [
			"one": "virun {0} W.",
			"other": "viru(n) {0} W."
		],
		"future": [
			"one": "an {0} W.",
			"other": "a(n) {0} W."
		]
	],
	"day": [
		"previous": "gëschter",
		"current": "haut",
		"next": "muer",
		"past": [
			"one": "virun {0} D.",
			"other": "viru(n) {0} D."
		],
		"future": [
			"one": "an {0} D.",
			"other": "a(n) {0} D."
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "virun {0} St.",
			"other": "viru(n) {0} St."
		],
		"future": [
			"one": "an {0} St.",
			"other": "a(n) {0} St."
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "virun {0} Min.",
			"other": "viru(n) {0} Min."
		],
		"future": [
			"one": "an {0} Min.",
			"other": "a(n) {0} Min."
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "virun {0} Sek.",
			"other": "viru(n) {0} Sek."
		],
		"future": [
			"one": "an {0} Sek.",
			"other": "a(n) {0} Sek."
		]
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "lescht Joer",
		"current": "dëst Joer",
		"next": "nächst Joer",
		"past": "-{0} J.",
		"future": "+{0} J."
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q.",
		"future": "+{0} Q."
	],
	"month": [
		"previous": "leschte Mount",
		"current": "dëse Mount",
		"next": "nächste Mount",
		"past": "-{0} M.",
		"future": "+{0} M."
	],
	"week": [
		"previous": "lescht Woch",
		"current": "dës Woch",
		"next": "nächst Woch",
		"past": "-{0} W.",
		"future": "+{0} W."
	],
	"day": [
		"previous": "gëschter",
		"current": "haut",
		"next": "muer",
		"past": "-{0} D.",
		"future": "+{0} D."
	],
	"hour": [
		"current": "this hour",
		"past": "-{0} St.",
		"future": "+{0} St."
	],
	"minute": [
		"current": "this minute",
		"past": "-{0} Min.",
		"future": "+{0} Min."
	],
	"second": [
		"current": "now",
		"past": "-{0} Sek.",
		"future": "+{0} Sek."
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "lescht Joer",
		"current": "dëst Joer",
		"next": "nächst Joer",
		"past": [
			"one": "virun {0} Joer",
			"other": "viru(n) {0} Joer"
		],
		"future": [
			"one": "an {0} Joer",
			"other": "a(n) {0} Joer"
		]
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": [
			"one": "virun {0} Quartal",
			"other": "viru(n) {0} Quartaler"
		],
		"future": [
			"one": "an {0} Quartal",
			"other": "a(n) {0} Quartaler"
		]
	],
	"month": [
		"previous": "leschte Mount",
		"current": "dëse Mount",
		"next": "nächste Mount",
		"past": [
			"one": "virun {0} Mount",
			"other": "viru(n) {0} Méint"
		],
		"future": [
			"one": "an {0} Mount",
			"other": "a(n) {0} Méint"
		]
	],
	"week": [
		"previous": "lescht Woch",
		"current": "dës Woch",
		"next": "nächst Woch",
		"past": [
			"one": "virun {0} Woch",
			"other": "viru(n) {0} Wochen"
		],
		"future": [
			"one": "an {0} Woch",
			"other": "a(n) {0} Wochen"
		]
	],
	"day": [
		"previous": "gëschter",
		"current": "haut",
		"next": "muer",
		"past": [
			"one": "virun {0} Dag",
			"other": "viru(n) {0} Deeg"
		],
		"future": [
			"one": "an {0} Dag",
			"other": "a(n) {0} Deeg"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "virun {0} Stonn",
			"other": "viru(n) {0} Stonnen"
		],
		"future": [
			"one": "an {0} Stonn",
			"other": "a(n) {0} Stonnen"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "virun {0} Minutt",
			"other": "viru(n) {0} Minutten"
		],
		"future": [
			"one": "an {0} Minutt",
			"other": "a(n) {0} Minutten"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "virun {0} Sekonn",
			"other": "viru(n) {0} Sekonnen"
		],
		"future": [
			"one": "an {0} Sekonn",
			"other": "a(n) {0} Sekonnen"
		]
	],
	"now": "now"
]
	}
}
