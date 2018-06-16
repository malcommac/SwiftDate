import Foundation

// swiftlint:disable type_name
public class lang_yi: RelativeFormatterLang {

	/// Yiddish
	public static let identifier: String = "yi"

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
		"previous": "פֿאַראַיאָר",
		"current": "הײַ יאָר",
		"next": "איבער א יאָר",
		"past": "פֿאַר {0} יאָר",
		"future": [
			"one": "איבער א יאָר",
			"other": "איבער {0} יאָר"
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
		"previous": "פֿאַרגאנגענעם חודש",
		"current": "דעם חודש",
		"next": "קומענדיקן חודש",
		"past": [
			"one": "פֿאַר {0} חודש",
			"other": "פֿאַר {0} חדשים"
		],
		"future": [
			"one": "איבער {0} חודש",
			"other": "איבער {0} חדשים"
		]
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "איבער אַכט טאָג",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "נעכטן",
		"current": "היינט",
		"next": "מארגן",
		"past": "-{0} d",
		"future": [
			"one": "אין {0} טאָג אַרום",
			"other": "אין {0} טעג אַרום"
		]
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
		"previous": "פֿאַראַיאָר",
		"current": "הײַ יאָר",
		"next": "איבער א יאָר",
		"past": "פֿאַר {0} יאָר",
		"future": "איבער {0} יאָר"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "פֿאַרגאנגענעם חודש",
		"current": "דעם חודש",
		"next": "קומענדיקן חודש",
		"past": [
			"one": "פֿאַר {0} חודש",
			"other": "פֿאַר {0} חדשים"
		],
		"future": [
			"one": "איבער {0} חודש",
			"other": "איבער {0} חדשים"
		]
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "איבער אַכט טאָג",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "נעכטן",
		"current": "היינט",
		"next": "מארגן",
		"past": "-{0} d",
		"future": [
			"one": "אין {0} טאָג אַרום",
			"other": "אין {0} טעג אַרום"
		]
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
		"previous": "פֿאַראַיאָר",
		"current": "הײַ יאָר",
		"next": "איבער א יאָר",
		"past": "פֿאַר {0} יאָר",
		"future": "איבער {0} יאָר"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "פֿאַרגאנגענעם חודש",
		"current": "דעם חודש",
		"next": "קומענדיקן חודש",
		"past": [
			"one": "פֿאַר {0} חודש",
			"other": "פֿאַר {0} חדשים"
		],
		"future": [
			"one": "איבער {0} חודש",
			"other": "איבער {0} חדשים"
		]
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "איבער אַכט טאָג",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "נעכטן",
		"current": "היינט",
		"next": "מארגן",
		"past": "-{0} d",
		"future": [
			"one": "אין {0} טאָג אַרום",
			"other": "אין {0} טעג אַרום"
		]
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
