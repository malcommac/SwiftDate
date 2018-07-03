import Foundation

// swiftlint:disable type_name
public class lang_ksh: RelativeFormatterLang {

	/// Colognian
	public static let identifier: String = "ksh"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 0: return .zero
		case 1: return .one
		default: return .other
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
		"previous": "läz Johr",
		"current": "diß Johr",
		"next": "näx Johr",
		"past": [
			"zero": "vör keijnem Johr",
			"one": "vör {0} Johr",
			"other": "vör {0} Johre"
		],
		"future": [
			"zero": "en keinem Johr",
			"one": "en {0} Johr",
			"other": "en {0} Johre"
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
		"previous": "lätzde Mohnd",
		"current": "diese Mohnd",
		"next": "nächste Mohnd",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "läz Woch",
		"current": "di Woch",
		"next": "nächste Woche",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "jestere",
		"current": "hück",
		"next": "morje",
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
		"previous": "läz Johr",
		"current": "diß Johr",
		"next": "näx Johr",
		"past": [
			"zero": "vör keijnem Johr",
			"one": "vör {0} Johr",
			"other": "vör {0} Johre"
		],
		"future": [
			"zero": "en keinem Johr",
			"one": "en {0} Johr",
			"other": "en {0} Johre"
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
		"previous": "lätzde Mohnd",
		"current": "diese Mohnd",
		"next": "nächste Mohnd",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "läz Woch",
		"current": "di Woch",
		"next": "nächste Woche",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "jestere",
		"current": "hück",
		"next": "morje",
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
		"previous": "läz Johr",
		"current": "diß Johr",
		"next": "näx Johr",
		"past": [
			"zero": "vör keijnem Johr",
			"one": "vör {0} Johr",
			"other": "vör {0} Johre"
		],
		"future": [
			"zero": "en keinem Johr",
			"one": "en {0} Johr",
			"other": "en {0} Johre"
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
		"previous": "lätzde Mohnd",
		"current": "diese Mohnd",
		"next": "nächste Mohnd",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "läz Woch",
		"current": "di Woch",
		"next": "nächste Woche",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "jestere",
		"current": "hück",
		"next": "morje",
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
