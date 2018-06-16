import Foundation

// swiftlint:disable type_name
public class lang_mt: RelativeFormatterLang {

	/// Maltese
	public static let identifier: String = "mt"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1: return .one
		case 0: return .few
		case 2...10: return .few
		case 11...19: return .many
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
		"previous": "Is-sena li għaddiet",
		"current": "din is-sena",
		"next": "Is-sena d-dieħla",
		"past": [
			"one": "{0} sena ilu",
			"other": "{0} snin ilu"
		],
		"future": "+{0} y"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "Ix-xahar li għadda",
		"current": "Dan ix-xahar",
		"next": "Ix-xahar id-dieħel",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "Il-ġimgħa li għaddiet",
		"current": "Din il-ġimgħa",
		"next": "Il-ġimgħa d-dieħla",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "Ilbieraħ",
		"current": "Illum",
		"next": "Għada",
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
		"previous": "Is-sena li għaddiet",
		"current": "din is-sena",
		"next": "Is-sena d-dieħla",
		"past": [
			"one": "{0} sena ilu",
			"other": "{0} snin ilu"
		],
		"future": "+{0} y"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "Ix-xahar li għadda",
		"current": "Dan ix-xahar",
		"next": "Ix-xahar id-dieħel",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "Il-ġimgħa li għaddiet",
		"current": "Din il-ġimgħa",
		"next": "Il-ġimgħa d-dieħla",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "Ilbieraħ",
		"current": "Illum",
		"next": "Għada",
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
		"previous": "Is-sena li għaddiet",
		"current": "din is-sena",
		"next": "Is-sena d-dieħla",
		"past": [
			"one": "{0} sena ilu",
			"other": "{0} snin ilu"
		],
		"future": "+{0} y"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "Ix-xahar li għadda",
		"current": "Dan ix-xahar",
		"next": "Ix-xahar id-dieħel",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"week": [
		"previous": "Il-ġimgħa li għaddiet",
		"current": "Din il-ġimgħa",
		"next": "Il-ġimgħa d-dieħla",
		"past": "-{0} w",
		"future": "+{0} w"
	],
	"day": [
		"previous": "Ilbieraħ",
		"current": "Illum",
		"next": "Għada",
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
