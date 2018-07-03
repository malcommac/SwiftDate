import Foundation

// swiftlint:disable type_name
public class lang_ga: RelativeFormatterLang {

	/// Irish
	public static let identifier: String = "ga"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch Int(value) {
		case 1: return .one
		case 2: return .two
		case 3...6: return .few
		case 7...10: return .many
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
		"previous": "anuraidh",
		"current": "an bhl. seo",
		"next": "an bhl. seo chugainn",
		"past": [
			"one": "{0} bhl. ó shin",
			"two": "{0} bhl. ó shin",
			"many": "{0} mbl. ó shin",
			"other": "{0} bl. ó shin"
		],
		"future": [
			"two": "i gceann {0} bhl.",
			"many": "i gceann {0} mbl.",
			"other": "i gceann {0} bl."
		]
	],
	"quarter": [
		"previous": "an ráithe seo caite",
		"current": "an ráithe seo",
		"next": "an ráithe seo chugainn",
		"past": "{0} ráithe ó shin",
		"future": "i gceann {0} ráithe"
	],
	"month": [
		"previous": "an mhí seo caite",
		"current": "an mhí seo",
		"next": "an mhí seo chugainn",
		"past": [
			"one": "{0} mhí ó shin",
			"two": "{0} mhí ó shin",
			"few": "{0} mhí ó shin",
			"other": "{0} mí ó shin"
		],
		"future": [
			"one": "i gceann {0} mhí",
			"two": "i gceann {0} mhí",
			"few": "i gceann {0} mhí",
			"other": "i gceann {0} mí"
		]
	],
	"week": [
		"previous": "an tscht. seo caite",
		"current": "an tscht. seo",
		"next": "an tscht. seo chugainn",
		"past": "{0} scht. ó shin",
		"future": [
			"two": "i gceann {0} shcht.",
			"other": "i gceann {0} scht."
		]
	],
	"day": [
		"previous": "inné",
		"current": "inniu",
		"next": "amárach",
		"past": "{0} lá ó shin",
		"future": "i gceann {0} lá"
	],
	"hour": [
		"current": "an uair seo",
		"past": [
			"few": "{0} huaire ó shin",
			"many": "{0} n-uaire ó shin",
			"other": "{0} uair ó shin"
		],
		"future": [
			"few": "i gceann {0} huaire",
			"many": "i gceann {0} n-uaire",
			"other": "i gceann {0} uair"
		]
	],
	"minute": [
		"current": "an nóiméad seo",
		"past": "{0} nóim. ó shin",
		"future": "i gceann {0} nóim."
	],
	"second": [
		"current": "anois",
		"past": [
			"two": "{0} shoic. ó shin",
			"few": "{0} shoic. ó shin",
			"other": "{0} soic. ó shin"
		],
		"future": [
			"two": "i gceann {0} shoic.",
			"few": "i gceann {0} shoic.",
			"other": "i gceann {0} soic."
		]
	],
	"now": "anois"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "anuraidh",
		"current": "an bhl. seo",
		"next": "an bhl. seo chugainn",
		"past": [
			"one": "-{0} bhl.",
			"two": "-{0} bhl.",
			"many": "-{0} mbl.",
			"other": "-{0} bl."
		],
		"future": [
			"one": "+{0} bhl.",
			"two": "+{0} bhl.",
			"many": "+{0} mbl.",
			"other": "+{0} bl."
		]
	],
	"quarter": [
		"previous": "an ráithe seo caite",
		"current": "an ráithe seo",
		"next": "an ráithe seo chugainn",
		"past": "-{0} R",
		"future": "+{0} R"
	],
	"month": [
		"previous": "an mhí seo caite",
		"current": "an mhí seo",
		"next": "an mhí seo chugainn",
		"past": [
			"one": "-{0} mhí",
			"two": "-{0} mhí",
			"few": "-{0} mhí",
			"other": "-{0} mí"
		],
		"future": [
			"one": "+{0} mhí",
			"two": "+{0} mhí",
			"few": "+{0} mhí",
			"other": "+{0} mí"
		]
	],
	"week": [
		"previous": "an tscht. seo caite",
		"current": "an tscht. seo",
		"next": "an tscht. seo chugainn",
		"past": "-{0} scht.",
		"future": "+{0} scht."
	],
	"day": [
		"previous": "inné",
		"current": "inniu",
		"next": "amárach",
		"past": "-{0} lá",
		"future": "+{0} lá"
	],
	"hour": [
		"current": "an uair seo",
		"past": "-{0} u",
		"future": "+{0} u"
	],
	"minute": [
		"current": "an nóiméad seo",
		"past": "-{0} n",
		"future": "+{0} n"
	],
	"second": [
		"current": "anois",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "anois"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "anuraidh",
		"current": "an bhliain seo",
		"next": "an bhliain seo chugainn",
		"past": [
			"one": "{0} bhliain ó shin",
			"two": "{0} bhliain ó shin",
			"few": "{0} bliana ó shin",
			"many": "{0} mbliana ó shin",
			"other": "{0} bliain ó shin"
		],
		"future": [
			"one": "i gceann {0} bhliain",
			"two": "i gceann {0} bhliain",
			"few": "i gceann {0} bliana",
			"many": "i gceann {0} mbliana",
			"other": "i gceann {0} bliain"
		]
	],
	"quarter": [
		"previous": "an ráithe seo caite",
		"current": "an ráithe seo",
		"next": "an ráithe seo chugainn",
		"past": "{0} ráithe ó shin",
		"future": "i gceann {0} ráithe"
	],
	"month": [
		"previous": "an mhí seo caite",
		"current": "an mhí seo",
		"next": "an mhí seo chugainn",
		"past": [
			"one": "{0} mhí ó shin",
			"two": "{0} mhí ó shin",
			"few": "{0} mhí ó shin",
			"other": "{0} mí ó shin"
		],
		"future": [
			"one": "i gceann {0} mhí",
			"two": "i gceann {0} mhí",
			"few": "i gceann {0} mhí",
			"other": "i gceann {0} mí"
		]
	],
	"week": [
		"previous": "an tseachtain seo caite",
		"current": "an tseachtain seo",
		"next": "an tseachtain seo chugainn",
		"past": [
			"two": "{0} sheachtain ó shin",
			"few": "{0} seachtaine ó shin",
			"many": "{0} seachtaine ó shin",
			"other": "{0} seachtain ó shin"
		],
		"future": [
			"two": "i gceann {0} sheachtain",
			"few": "i gceann {0} seachtaine",
			"many": "i gceann {0} seachtaine",
			"other": "i gceann {0} seachtain"
		]
	],
	"day": [
		"previous": "inné",
		"current": "inniu",
		"next": "amárach",
		"past": "{0} lá ó shin",
		"future": "i gceann {0} lá"
	],
	"hour": [
		"current": "an uair seo",
		"past": [
			"few": "{0} huaire an chloig ó shin",
			"many": "{0} n-uaire an chloig ó shin",
			"other": "{0} uair an chloig ó shin"
		],
		"future": [
			"few": "i gceann {0} huaire an chloig",
			"many": "i gceann {0} n-uaire an chloig",
			"other": "i gceann {0} uair an chloig"
		]
	],
	"minute": [
		"current": "an nóiméad seo",
		"past": "{0} nóiméad ó shin",
		"future": "i gceann {0} nóiméad"
	],
	"second": [
		"current": "anois",
		"past": [
			"two": "{0} shoicind ó shin",
			"few": "{0} shoicind ó shin",
			"other": "{0} soicind ó shin"
		],
		"future": [
			"two": "i gceann {0} shoicind",
			"few": "i gceann {0} shoicind",
			"other": "i gceann {0} soicind"
		]
	],
	"now": "anois"
]
	}
}
