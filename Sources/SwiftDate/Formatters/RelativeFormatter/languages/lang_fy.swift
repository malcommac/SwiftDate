import Foundation

// swiftlint:disable type_name
public class lang_fy: RelativeFormatterLang {

	/// Western Frisian
	public static let identifier: String = "fy"

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
		"previous": "foarich jier",
		"current": "dit jier",
		"next": "folgjend jier",
		"past": "{0} jier lyn",
		"future": "Oer {0} jier"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "foarige moanne",
		"current": "dizze moanne",
		"next": "folgjende moanne",
		"past": [
			"one": "{0} moanne lyn",
			"other": "{0} moannen lyn"
		],
		"future": [
			"one": "Oer {0} moanne",
			"other": "Oer {0} moannen"
		]
	],
	"week": [
		"previous": "foarige wike",
		"current": "dizze wike",
		"next": "folgjende wike",
		"past": [
			"one": "{0} wike lyn",
			"other": "{0} wiken lyn"
		],
		"future": [
			"one": "Oer {0} wike",
			"other": "Oer {0} wiken"
		]
	],
	"day": [
		"previous": "gisteren",
		"current": "vandaag",
		"next": "morgen",
		"past": [
			"one": "{0} dei lyn",
			"other": "{0} deien lyn"
		],
		"future": [
			"one": "Oer {0} dei",
			"other": "Oer {0} deien"
		]
	],
	"hour": [
		"current": "this hour",
		"past": "{0} oere lyn",
		"future": "Oer {0} oere"
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minút lyn",
			"other": "{0} minuten lyn"
		],
		"future": [
			"one": "Oer {0} minút",
			"other": "Oer {0} minuten"
		]
	],
	"second": [
		"current": "nu",
		"past": [
			"one": "{0} sekonde lyn",
			"other": "{0} sekonden lyn"
		],
		"future": [
			"one": "Oer {0} sekonde",
			"other": "Oer {0} sekonden"
		]
	],
	"now": "nu"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "foarich jier",
		"current": "dit jier",
		"next": "folgjend jier",
		"past": "{0} jier lyn",
		"future": "Oer {0} jier"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "foarige moanne",
		"current": "dizze moanne",
		"next": "folgjende moanne",
		"past": [
			"one": "{0} moanne lyn",
			"other": "{0} moannen lyn"
		],
		"future": [
			"one": "Oer {0} moanne",
			"other": "Oer {0} moannen"
		]
	],
	"week": [
		"previous": "foarige wike",
		"current": "dizze wike",
		"next": "folgjende wike",
		"past": [
			"one": "{0} wike lyn",
			"other": "{0} wiken lyn"
		],
		"future": [
			"one": "Oer {0} wike",
			"other": "Oer {0} wiken"
		]
	],
	"day": [
		"previous": "gisteren",
		"current": "vandaag",
		"next": "morgen",
		"past": [
			"one": "{0} dei lyn",
			"other": "{0} deien lyn"
		],
		"future": [
			"one": "Oer {0} dei",
			"other": "Oer {0} deien"
		]
	],
	"hour": [
		"current": "this hour",
		"past": "{0} oere lyn",
		"future": "Oer {0} oere"
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minút lyn",
			"other": "{0} minuten lyn"
		],
		"future": [
			"one": "Oer {0} minút",
			"other": "Oer {0} minuten"
		]
	],
	"second": [
		"current": "nu",
		"past": [
			"one": "{0} sekonde lyn",
			"other": "{0} sekonden lyn"
		],
		"future": [
			"one": "Oer {0} sekonde",
			"other": "Oer {0} sekonden"
		]
	],
	"now": "nu"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "foarich jier",
		"current": "dit jier",
		"next": "folgjend jier",
		"past": "{0} jier lyn",
		"future": "Oer {0} jier"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "foarige moanne",
		"current": "dizze moanne",
		"next": "folgjende moanne",
		"past": [
			"one": "{0} moanne lyn",
			"other": "{0} moannen lyn"
		],
		"future": [
			"one": "Oer {0} moanne",
			"other": "Oer {0} moannen"
		]
	],
	"week": [
		"previous": "foarige wike",
		"current": "dizze wike",
		"next": "folgjende wike",
		"past": [
			"one": "{0} wike lyn",
			"other": "{0} wiken lyn"
		],
		"future": [
			"one": "Oer {0} wike",
			"other": "Oer {0} wiken"
		]
	],
	"day": [
		"previous": "gisteren",
		"current": "vandaag",
		"next": "morgen",
		"past": [
			"one": "{0} dei lyn",
			"other": "{0} deien lyn"
		],
		"future": [
			"one": "Oer {0} dei",
			"other": "Oer {0} deien"
		]
	],
	"hour": [
		"current": "this hour",
		"past": "{0} oere lyn",
		"future": "Oer {0} oere"
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minút lyn",
			"other": "{0} minuten lyn"
		],
		"future": [
			"one": "Oer {0} minút",
			"other": "Oer {0} minuten"
		]
	],
	"second": [
		"current": "nu",
		"past": [
			"one": "{0} sekonde lyn",
			"other": "{0} sekonden lyn"
		],
		"future": [
			"one": "Oer {0} sekonde",
			"other": "Oer {0} sekonden"
		]
	],
	"now": "nu"
]
	}
}
