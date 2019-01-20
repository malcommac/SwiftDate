import Foundation

// swiftlint:disable type_name
public class lang_ps: RelativeFormatterLang {

	/// Pashto
	public static let identifier: String = "ps"

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
		"previous": "پروسږکال",
		"current": "سږکال",
		"next": "بل کال",
		"past": [
			"one": "{0} کال مخکې",
			"other": "{0} کاله مخکې"
		],
		"future": [
			"one": "په {0} کال کې",
			"other": "په {0} کالونو کې"
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
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "yesterday",
		"current": "today",
		"next": "tomorrow",
		"past": "-{0} d",
		"future": "+{0} d"
	],
	"hour": [
		"current": "this hour",
		"past": "-{0} h",
		"future": "+{0} h"
	],
	"minute": [
		"current": "this minute",
		"past": "-{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "now",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "پروسږکال",
		"current": "سږکال",
		"next": "بل کال",
		"past": [
			"one": "{0} کال مخکې",
			"other": "{0} کاله مخکې"
		],
		"future": [
			"one": "په {0} کال کې",
			"other": "په {0} کالونو کې"
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
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "yesterday",
		"current": "today",
		"next": "tomorrow",
		"past": "-{0} d",
		"future": "+{0} d"
	],
	"hour": [
		"current": "this hour",
		"past": "-{0} h",
		"future": "+{0} h"
	],
	"minute": [
		"current": "this minute",
		"past": "-{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "now",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "پروسږکال",
		"current": "سږکال",
		"next": "بل کال",
		"past": [
			"one": "{0} کال مخکې",
			"other": "{0} کاله مخکې"
		],
		"future": [
			"one": "په {0} کال کې",
			"other": "په {0} کالونو کې"
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
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "yesterday",
		"current": "today",
		"next": "tomorrow",
		"past": "-{0} d",
		"future": "+{0} d"
	],
	"hour": [
		"current": "this hour",
		"past": "-{0} h",
		"future": "+{0} h"
	],
	"minute": [
		"current": "this minute",
		"past": "-{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "now",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "now"
]
	}
}
