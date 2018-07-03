import Foundation

// swiftlint:disable type_name
public class lang_wae: RelativeFormatterLang {

	/// Walser
	public static let identifier: String = "wae"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
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
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": [
			"one": "vor {0} jár",
			"other": "cor {0} jár"
		],
		"future": "I {0} jár"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "vor {0} mánet",
		"future": "I {0} mánet"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "vor {0} wuča",
			"other": "cor {0} wučä"
		],
		"future": [
			"one": "i {0} wuča",
			"other": "i {0} wučä"
		]
	],
	"day": [
		"previous": "Gešter",
		"current": "Hitte",
		"next": "Móre",
		"past": [
			"one": "vor {0} tag",
			"other": "vor {0} täg"
		],
		"future": [
			"one": "i {0} tag",
			"other": "i {0} täg"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "vor {0} stund",
			"other": "vor {0} stunde"
		],
		"future": [
			"one": "i {0} stund",
			"other": "i {0} stunde"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "vor {0} minüta",
			"other": "vor {0} minüte"
		],
		"future": [
			"one": "i {0} minüta",
			"other": "i {0} minüte"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "vor {0} sekund",
			"other": "vor {0} sekunde"
		],
		"future": [
			"one": "i {0} sekund",
			"other": "i {0} sekunde"
		]
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": [
			"one": "vor {0} jár",
			"other": "cor {0} jár"
		],
		"future": "I {0} jár"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "vor {0} mánet",
		"future": "I {0} mánet"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "vor {0} wuča",
			"other": "cor {0} wučä"
		],
		"future": [
			"one": "i {0} wuča",
			"other": "i {0} wučä"
		]
	],
	"day": [
		"previous": "Gešter",
		"current": "Hitte",
		"next": "Móre",
		"past": [
			"one": "vor {0} tag",
			"other": "vor {0} täg"
		],
		"future": [
			"one": "i {0} tag",
			"other": "i {0} täg"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "vor {0} stund",
			"other": "vor {0} stunde"
		],
		"future": [
			"one": "i {0} stund",
			"other": "i {0} stunde"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "vor {0} minüta",
			"other": "vor {0} minüte"
		],
		"future": [
			"one": "i {0} minüta",
			"other": "i {0} minüte"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "vor {0} sekund",
			"other": "vor {0} sekunde"
		],
		"future": [
			"one": "i {0} sekund",
			"other": "i {0} sekunde"
		]
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": [
			"one": "vor {0} jár",
			"other": "cor {0} jár"
		],
		"future": "I {0} jár"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "vor {0} mánet",
		"future": "I {0} mánet"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "vor {0} wuča",
			"other": "cor {0} wučä"
		],
		"future": [
			"one": "i {0} wuča",
			"other": "i {0} wučä"
		]
	],
	"day": [
		"previous": "Gešter",
		"current": "Hitte",
		"next": "Móre",
		"past": [
			"one": "vor {0} tag",
			"other": "vor {0} täg"
		],
		"future": [
			"one": "i {0} tag",
			"other": "i {0} täg"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "vor {0} stund",
			"other": "vor {0} stunde"
		],
		"future": [
			"one": "i {0} stund",
			"other": "i {0} stunde"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "vor {0} minüta",
			"other": "vor {0} minüte"
		],
		"future": [
			"one": "i {0} minüta",
			"other": "i {0} minüte"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "vor {0} sekund",
			"other": "vor {0} sekunde"
		],
		"future": [
			"one": "i {0} sekund",
			"other": "i {0} sekunde"
		]
	],
	"now": "now"
]
	}
}
