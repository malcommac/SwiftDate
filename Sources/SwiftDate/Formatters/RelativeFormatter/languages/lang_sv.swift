import Foundation

// swiftlint:disable type_name
public class lang_sv: RelativeFormatterLang {

	/// Swedish
	public static let identifier: String = "sv"

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
		"previous": "i fjol",
		"current": "i år",
		"next": "nästa år",
		"past": "för {0} år sen",
		"future": "om {0} år"
	],
	"quarter": [
		"previous": "förra kv.",
		"current": "detta kv.",
		"next": "nästa kv.",
		"past": "för {0} kv. sen",
		"future": "om {0} kv."
	],
	"month": [
		"previous": "förra mån.",
		"current": "denna mån.",
		"next": "nästa mån.",
		"past": "för {0} mån. sen",
		"future": "om {0} mån."
	],
	"week": [
		"previous": "förra v.",
		"current": "denna v.",
		"next": "nästa v.",
		"past": "för {0} v. sedan",
		"future": "om {0} v."
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgon",
		"past": [
			"one": "för {0} d sedan",
			"other": "för {0} d sedan"
		],
		"future": "om {0} d"
	],
	"hour": [
		"current": "denna timme",
		"past": "för {0} tim sedan",
		"future": "om {0} tim"
	],
	"minute": [
		"current": "denna minut",
		"past": "för {0} min sen",
		"future": "om {0} min"
	],
	"second": [
		"current": "nu",
		"past": "för {0} s sen",
		"future": [
			"one": "om {0} sek",
			"other": "om {0} sek"
		]
	],
	"now": "nu"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "i fjol",
		"current": "i år",
		"next": "nästa år",
		"past": "−{0} år",
		"future": "+{0} år"
	],
	"quarter": [
		"previous": "förra kv.",
		"current": "detta kv.",
		"next": "nästa kv.",
		"past": "−{0} kv",
		"future": "+{0} kv."
	],
	"month": [
		"previous": "förra mån.",
		"current": "denna mån.",
		"next": "nästa mån.",
		"past": "−{0} mån",
		"future": "+{0} mån."
	],
	"week": [
		"previous": "förra v.",
		"current": "denna v.",
		"next": "nästa v.",
		"past": "−{0} v",
		"future": "+{0} v."
	],
	"day": [
		"previous": "igår",
		"current": "idag",
		"next": "imorgon",
		"past": "−{0} d",
		"future": "+{0} d"
	],
	"hour": [
		"current": "denna timme",
		"past": "−{0} h",
		"future": "+{0} h"
	],
	"minute": [
		"current": "denna minut",
		"past": "−{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "nu",
		"past": "−{0} s",
		"future": "+{0} s"
	],
	"now": "nu"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "i fjol",
		"current": "i år",
		"next": "nästa år",
		"past": "för {0} år sedan",
		"future": "om {0} år"
	],
	"quarter": [
		"previous": "förra kvartalet",
		"current": "detta kvartal",
		"next": "nästa kvartal",
		"past": "för {0} kvartal sedan",
		"future": "om {0} kvartal"
	],
	"month": [
		"previous": "förra månaden",
		"current": "denna månad",
		"next": "nästa månad",
		"past": [
			"one": "för {0} månad sedan",
			"other": "för {0} månader sedan"
		],
		"future": [
			"one": "om {0} månad",
			"other": "om {0} månader"
		]
	],
	"week": [
		"previous": "förra veckan",
		"current": "denna vecka",
		"next": "nästa vecka",
		"past": [
			"one": "för {0} vecka sedan",
			"other": "för {0} veckor sedan"
		],
		"future": [
			"one": "om {0} vecka",
			"other": "om {0} veckor"
		]
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgon",
		"past": [
			"one": "för {0} dag sedan",
			"other": "för {0} dagar sedan"
		],
		"future": [
			"one": "om {0} dag",
			"other": "om {0} dagar"
		]
	],
	"hour": [
		"current": "denna timme",
		"past": [
			"one": "för {0} timme sedan",
			"other": "för {0} timmar sedan"
		],
		"future": [
			"one": "om {0} timme",
			"other": "om {0} timmar"
		]
	],
	"minute": [
		"current": "denna minut",
		"past": [
			"one": "för {0} minut sedan",
			"other": "för {0} minuter sedan"
		],
		"future": [
			"one": "om {0} minut",
			"other": "om {0} minuter"
		]
	],
	"second": [
		"current": "nu",
		"past": [
			"one": "för {0} sekund sedan",
			"other": "för {0} sekunder sedan"
		],
		"future": [
			"one": "om {0} sekund",
			"other": "om {0} sekunder"
		]
	],
	"now": "nu"
]
	}
}
