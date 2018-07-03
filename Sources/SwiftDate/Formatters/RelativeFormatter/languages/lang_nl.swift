import Foundation

// swiftlint:disable type_name
public class lang_nl: RelativeFormatterLang {

	/// Dutch
	public static let identifier: String = "nl"

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
		"previous": "vorig jaar",
		"current": "dit jaar",
		"next": "volgend jaar",
		"past": "{0} jaar geleden",
		"future": "over {0} jaar"
	],
	"quarter": [
		"previous": "vorig kwartaal",
		"current": "dit kwartaal",
		"next": "volgend kwartaal",
		"past": [
			"one": "{0} kwartaal geleden",
			"other": "{0} kwartalen geleden"
		],
		"future": [
			"one": "over {0} kwartaal",
			"other": "over {0} kwartalen"
		]
	],
	"month": [
		"previous": "vorige maand",
		"current": "deze maand",
		"next": "volgende maand",
		"past": [
			"one": "{0} maand geleden",
			"other": "{0} maanden geleden"
		],
		"future": [
			"one": "over {0} maand",
			"other": "over {0} maanden"
		]
	],
	"week": [
		"previous": "vorige week",
		"current": "deze week",
		"next": "volgende week",
		"past": [
			"one": "{0} week geleden",
			"other": "{0} weken geleden"
		],
		"future": [
			"one": "over {0} week",
			"other": "over {0} weken"
		]
	],
	"day": [
		"previous": "gisteren",
		"current": "vandaag",
		"next": "morgen",
		"past": [
			"one": "{0} dag geleden",
			"other": "{0} dgn geleden"
		],
		"future": [
			"one": "over {0} dag",
			"other": "over {0} dgn"
		]
	],
	"hour": [
		"current": "binnen een uur",
		"past": "{0} uur geleden",
		"future": "over {0} uur"
	],
	"minute": [
		"current": "binnen een minuut",
		"past": "{0} min. geleden",
		"future": "over {0} min."
	],
	"second": [
		"current": "nu",
		"past": "{0} sec. geleden",
		"future": "over {0} sec."
	],
	"now": "nu"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "vorig jaar",
		"current": "dit jaar",
		"next": "volgend jaar",
		"past": "{0} jaar geleden",
		"future": "over {0} jaar"
	],
	"quarter": [
		"previous": "vorig kwartaal",
		"current": "dit kwartaal",
		"next": "volgend kwartaal",
		"past": [
			"one": "{0} kwartaal geleden",
			"other": "{0} kwartalen geleden"
		],
		"future": [
			"one": "over {0} kw.",
			"other": "over {0} kwartalen"
		]
	],
	"month": [
		"previous": "vorige maand",
		"current": "deze maand",
		"next": "volgende maand",
		"past": [
			"one": "{0} maand geleden",
			"other": "{0} maanden geleden"
		],
		"future": [
			"one": "over {0} maand",
			"other": "over {0} maanden"
		]
	],
	"week": [
		"previous": "vorige week",
		"current": "deze week",
		"next": "volgende week",
		"past": [
			"one": "{0} week geleden",
			"other": "{0} weken geleden"
		],
		"future": [
			"one": "over {0} week",
			"other": "over {0} weken"
		]
	],
	"day": [
		"previous": "gisteren",
		"current": "vandaag",
		"next": "morgen",
		"past": [
			"one": "{0} dag geleden",
			"other": "{0} dgn geleden"
		],
		"future": [
			"one": "over {0} dag",
			"other": "over {0} dgn"
		]
	],
	"hour": [
		"current": "binnen een uur",
		"past": "{0} uur geleden",
		"future": "over {0} uur"
	],
	"minute": [
		"current": "binnen een minuut",
		"past": "{0} min. geleden",
		"future": "over {0} min."
	],
	"second": [
		"current": "nu",
		"past": "{0} sec. geleden",
		"future": "over {0} sec."
	],
	"now": "nu"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "vorig jaar",
		"current": "dit jaar",
		"next": "volgend jaar",
		"past": "{0} jaar geleden",
		"future": "over {0} jaar"
	],
	"quarter": [
		"previous": "vorig kwartaal",
		"current": "dit kwartaal",
		"next": "volgend kwartaal",
		"past": [
			"one": "{0} kwartaal geleden",
			"other": "{0} kwartalen geleden"
		],
		"future": [
			"one": "over {0} kwartaal",
			"other": "over {0} kwartalen"
		]
	],
	"month": [
		"previous": "vorige maand",
		"current": "deze maand",
		"next": "volgende maand",
		"past": [
			"one": "{0} maand geleden",
			"other": "{0} maanden geleden"
		],
		"future": [
			"one": "over {0} maand",
			"other": "over {0} maanden"
		]
	],
	"week": [
		"previous": "vorige week",
		"current": "deze week",
		"next": "volgende week",
		"past": [
			"one": "{0} week geleden",
			"other": "{0} weken geleden"
		],
		"future": [
			"one": "over {0} week",
			"other": "over {0} weken"
		]
	],
	"day": [
		"previous": "gisteren",
		"current": "vandaag",
		"next": "morgen",
		"past": [
			"one": "{0} dag geleden",
			"other": "{0} dagen geleden"
		],
		"future": [
			"one": "over {0} dag",
			"other": "over {0} dagen"
		]
	],
	"hour": [
		"current": "binnen een uur",
		"past": "{0} uur geleden",
		"future": "over {0} uur"
	],
	"minute": [
		"current": "binnen een minuut",
		"past": [
			"one": "{0} minuut geleden",
			"other": "{0} minuten geleden"
		],
		"future": [
			"one": "over {0} minuut",
			"other": "over {0} minuten"
		]
	],
	"second": [
		"current": "nu",
		"past": [
			"one": "{0} seconde geleden",
			"other": "{0} seconden geleden"
		],
		"future": [
			"one": "over {0} seconde",
			"other": "over {0} seconden"
		]
	],
	"now": "nu"
]
	}
}
