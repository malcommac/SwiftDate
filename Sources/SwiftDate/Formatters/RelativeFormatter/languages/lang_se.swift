import Foundation

// swiftlint:disable type_name
public class lang_se: RelativeFormatterLang {

	/// Northern Sami
	public static let identifier: String = "se"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1: return .one
		case 2: return .two
		default: return .other
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
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": [
			"one": "{0} jahki árat",
			"other": "{0} jahkki árat"
		],
		"future": [
			"one": "{0} jahki maŋŋilit",
			"other": "{0} jahkki maŋŋilit"
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
		"past": "{0} mánotbadji árat",
		"future": "{0} mánotbadji maŋŋilit"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "{0} vahku árat",
			"other": "{0} vahkku árat"
		],
		"future": [
			"one": "{0} vahku maŋŋilit",
			"other": "{0} vahkku maŋŋilit"
		]
	],
	"day": [
		"previous": "ikte",
		"current": "odne",
		"next": "ihttin",
		"past": [
			"one": "{0} jándor árat",
			"other": "{0} jándora árat"
		],
		"future": [
			"one": "{0} jándor maŋŋilit",
			"two": "{0} jándor amaŋŋilit",
			"other": "{0} jándora maŋŋilit"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "{0} diibmu árat",
			"other": "{0} diibmur árat"
		],
		"future": [
			"one": "{0} diibmu maŋŋilit",
			"other": "{0} diibmur maŋŋilit"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minuhta árat",
			"other": "{0} minuhtta árat"
		],
		"future": [
			"one": "{0} minuhta maŋŋilit",
			"other": "{0} minuhtta maŋŋilit"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "{0} sekunda árat",
			"other": "{0} sekundda árat"
		],
		"future": [
			"one": "{0} sekunda maŋŋilit",
			"other": "{0} sekundda maŋŋilit"
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
			"one": "{0} jahki árat",
			"other": "{0} jahkki árat"
		],
		"future": [
			"one": "{0} jahki maŋŋilit",
			"other": "{0} jahkki maŋŋilit"
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
		"past": "{0} mánotbadji árat",
		"future": "{0} mánotbadji maŋŋilit"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "{0} vahku árat",
			"other": "{0} vahkku árat"
		],
		"future": [
			"one": "{0} vahku maŋŋilit",
			"other": "{0} vahkku maŋŋilit"
		]
	],
	"day": [
		"previous": "ikte",
		"current": "odne",
		"next": "ihttin",
		"past": [
			"one": "{0} jándor árat",
			"other": "{0} jándora árat"
		],
		"future": [
			"one": "{0} jándor maŋŋilit",
			"two": "{0} jándor amaŋŋilit",
			"other": "{0} jándora maŋŋilit"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "{0} diibmu árat",
			"other": "{0} diibmur árat"
		],
		"future": [
			"one": "{0} diibmu maŋŋilit",
			"other": "{0} diibmur maŋŋilit"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minuhta árat",
			"other": "{0} minuhtta árat"
		],
		"future": [
			"one": "{0} minuhta maŋŋilit",
			"other": "{0} minuhtta maŋŋilit"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "{0} sekunda árat",
			"other": "{0} sekundda árat"
		],
		"future": [
			"one": "{0} sekunda maŋŋilit",
			"other": "{0} sekundda maŋŋilit"
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
			"one": "{0} jahki árat",
			"other": "{0} jahkki árat"
		],
		"future": [
			"one": "{0} jahki maŋŋilit",
			"other": "{0} jahkki maŋŋilit"
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
		"past": "{0} mánotbadji árat",
		"future": "{0} mánotbadji maŋŋilit"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": [
			"one": "{0} vahku árat",
			"other": "{0} vahkku árat"
		],
		"future": [
			"one": "{0} vahku maŋŋilit",
			"other": "{0} vahkku maŋŋilit"
		]
	],
	"day": [
		"previous": "ikte",
		"current": "odne",
		"next": "ihttin",
		"past": [
			"one": "{0} jándor árat",
			"other": "{0} jándora árat"
		],
		"future": [
			"one": "{0} jándor maŋŋilit",
			"two": "{0} jándor amaŋŋilit",
			"other": "{0} jándora maŋŋilit"
		]
	],
	"hour": [
		"current": "this hour",
		"past": [
			"one": "{0} diibmu árat",
			"other": "{0} diibmur árat"
		],
		"future": [
			"one": "{0} diibmu maŋŋilit",
			"other": "{0} diibmur maŋŋilit"
		]
	],
	"minute": [
		"current": "this minute",
		"past": [
			"one": "{0} minuhta árat",
			"other": "{0} minuhtta árat"
		],
		"future": [
			"one": "{0} minuhta maŋŋilit",
			"other": "{0} minuhtta maŋŋilit"
		]
	],
	"second": [
		"current": "now",
		"past": [
			"one": "{0} sekunda árat",
			"other": "{0} sekundda árat"
		],
		"future": [
			"one": "{0} sekunda maŋŋilit",
			"other": "{0} sekundda maŋŋilit"
		]
	],
	"now": "now"
]
	}
}
