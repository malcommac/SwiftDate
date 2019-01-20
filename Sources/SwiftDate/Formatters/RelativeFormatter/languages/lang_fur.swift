import Foundation

// swiftlint:disable type_name
public class lang_fur: RelativeFormatterLang {

	/// Friulian
	public static let identifier: String = "fur"

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
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": [
			"one": "{0} an indaûr",
			"other": "{0} agns indaûr"
		],
		"future": [
			"one": "ca di {0} an",
			"other": "ca di {0} agns"
		]
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
		"past": "{0} mês indaûr",
		"future": "ca di {0} mês"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "{0} setemane indaûr",
			"other": "{0} setemanis indaûr"
		],
		"future": [
			"one": "ca di {0} setemane",
			"other": "ca di {0} setemanis"
		]
	],
	"day": [
		"previous": "îr",
		"current": "vuê",
		"next": "doman",
		"past": [
			"one": "{0} zornade indaûr",
			"other": "{0} zornadis indaûr"
		],
		"future": [
			"one": "ca di {0} zornade",
			"other": "ca di {0} zornadis"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "{0} ore indaûr",
			"other": "{0} oris indaûr"
		],
		"future": [
			"one": "ca di {0} ore",
			"other": "ca di {0} oris"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minût indaûr",
			"other": "{0} minûts indaûr"
		],
		"future": [
			"one": "ca di {0} minût",
			"other": "ca di {0} minûts"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "{0} secont indaûr",
			"other": "{0} seconts indaûr"
		],
		"future": [
			"one": "ca di {0} secont",
			"other": "ca di {0} seconts"
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
			"one": "{0} an indaûr",
			"other": "{0} agns indaûr"
		],
		"future": [
			"one": "ca di {0} an",
			"other": "ca di {0} agns"
		]
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
		"past": "{0} mês indaûr",
		"future": "ca di {0} mês"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "{0} setemane indaûr",
			"other": "{0} setemanis indaûr"
		],
		"future": [
			"one": "ca di {0} setemane",
			"other": "ca di {0} setemanis"
		]
	],
	"day": [
		"previous": "îr",
		"current": "vuê",
		"next": "doman",
		"past": [
			"one": "{0} zornade indaûr",
			"other": "{0} zornadis indaûr"
		],
		"future": [
			"one": "ca di {0} zornade",
			"other": "ca di {0} zornadis"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "{0} ore indaûr",
			"other": "{0} oris indaûr"
		],
		"future": [
			"one": "ca di {0} ore",
			"other": "ca di {0} oris"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minût indaûr",
			"other": "{0} minûts indaûr"
		],
		"future": [
			"one": "ca di {0} minût",
			"other": "ca di {0} minûts"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "{0} secont indaûr",
			"other": "{0} seconts indaûr"
		],
		"future": [
			"one": "ca di {0} secont",
			"other": "ca di {0} seconts"
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
			"one": "{0} an indaûr",
			"other": "{0} agns indaûr"
		],
		"future": [
			"one": "ca di {0} an",
			"other": "ca di {0} agns"
		]
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
		"past": "{0} mês indaûr",
		"future": "ca di {0} mês"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "{0} setemane indaûr",
			"other": "{0} setemanis indaûr"
		],
		"future": [
			"one": "ca di {0} setemane",
			"other": "ca di {0} setemanis"
		]
	],
	"day": [
		"previous": "îr",
		"current": "vuê",
		"next": "doman",
		"past": [
			"one": "{0} zornade indaûr",
			"other": "{0} zornadis indaûr"
		],
		"future": [
			"one": "ca di {0} zornade",
			"other": "ca di {0} zornadis"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "{0} ore indaûr",
			"other": "{0} oris indaûr"
		],
		"future": [
			"one": "ca di {0} ore",
			"other": "ca di {0} oris"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minût indaûr",
			"other": "{0} minûts indaûr"
		],
		"future": [
			"one": "ca di {0} minût",
			"other": "ca di {0} minûts"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "{0} secont indaûr",
			"other": "{0} seconts indaûr"
		],
		"future": [
			"one": "ca di {0} secont",
			"other": "ca di {0} seconts"
		]
	],
	"now": "now"
]
	}
}
