import Foundation

// swiftlint:disable type_name
public class lang_gd: RelativeFormatterLang {

	/// Scottish Gaelic
	public static let identifier: String = "gd"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch Int(value) {
		case 1, 11: return .one
		case 2, 12: return .two
		case 3...10: return .few
		case 13...19: return .few
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
		"previous": "an-uiridh",
		"current": "am bliadhna",
		"next": "an ath-bhliadhna",
		"past": [
			"one": "o {0} bhlia.",
			"two": "o {0} bhlia.",
			"other": "o {0} blia."
		],
		"future": [
			"one": "an {0} bhlia.",
			"two": "an {0} bhlia.",
			"other": "an {0} blia."
		]
	],
	"quarter": [
		"previous": "an cairt. sa chaidh",
		"current": "an cairt. seo",
		"next": "an ath-chairt.",
		"past": [
			"one": "o {0} chairt.",
			"two": "o {0} chairt.",
			"other": "o {0} cairt."
		],
		"future": [
			"one": "an {0} chairt.",
			"two": "an {0} chairt.",
			"other": "an {0} cairt."
		]
	],
	"month": [
		"previous": "am mìos sa chaidh",
		"current": "am mìos seo",
		"next": "an ath-mhìos",
		"past": [
			"one": "o {0} mhìos.",
			"two": "o {0} mhìos.",
			"other": "o {0} mìos."
		],
		"future": [
			"one": "an {0} mhìos.",
			"two": "an {0} mhìos.",
			"other": "an {0} mìos."
		]
	],
	"week": [
		"previous": "seachd. sa chaidh",
		"current": "an t-seachd. seo",
		"next": "an ath-sheachd.",
		"past": [
			"one": "o {0} sheachd.",
			"two": "o {0} sheachd.",
			"other": "o {0} seachd."
		],
		"future": [
			"one": "an {0} sheachd.",
			"two": "an {0} sheachd.",
			"other": "an {0} seachd."
		]
	],
	"day": [
		"previous": "an-dè",
		"current": "an-diugh",
		"next": "a-màireach",
		"past": [
			"few": "o {0} là.",
			"other": "o {0} là"
		],
		"future": [
			"few": "an {0} là.",
			"other": "an {0} là"
		]
	],
	"hour": [
		"current": "am broinn uair",
		"past": [
			"few": "o {0} uair.",
			"other": "o {0} uair"
		],
		"future": [
			"few": "an {0} uair.",
			"other": "an {0} uair"
		]
	],
	"minute": [
		"current": "am broinn mion.",
		"past": [
			"one": "o {0} mhion.",
			"two": "o {0} mhion.",
			"other": "o {0} mion."
		],
		"future": [
			"one": "an {0} mhion.",
			"two": "an {0} mhion.",
			"other": "an {0} mion."
		]
	],
	"second": [
		"current": "an-dràsta",
		"past": [
			"two": "o {0} dhiog",
			"few": "o {0} diog.",
			"other": "o {0} diog"
		],
		"future": [
			"two": "an {0} dhiog",
			"few": "an {0} diog.",
			"other": "an {0} diog"
		]
	],
	"now": "an-dràsta"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "an-uir.",
		"current": "am bl.",
		"next": "an ath-bhl.",
		"past": [
			"one": "-{0} bhl.",
			"two": "-{0} bhl.",
			"other": "-{0} bl."
		],
		"future": [
			"one": "+{0} bhl.",
			"two": "+{0} bhl.",
			"other": "+{0} bl."
		]
	],
	"quarter": [
		"previous": "c. ch.",
		"current": "an c. seo",
		"next": "ath-ch.",
		"past": "-{0} c.",
		"future": "+{0} c."
	],
	"month": [
		"previous": "mì. ch.",
		"current": "am mì. seo",
		"next": "ath-mhì.",
		"past": [
			"one": "-{0} mhì.",
			"two": "-{0} mhì.",
			"other": "-{0} mì."
		],
		"future": [
			"one": "+{0} mhì.",
			"two": "+{0} mhì.",
			"other": "+{0} mì."
		]
	],
	"week": [
		"previous": "sn. ch.",
		"current": "an t-sn. seo",
		"next": "ath-shn.",
		"past": "-{0} sn.",
		"future": "+{0} sn."
	],
	"day": [
		"previous": "an-dè",
		"current": "an-diugh",
		"next": "a-màireach",
		"past": "-{0} là",
		"future": "+{0} là"
	],
	"hour": [
		"current": "san uair",
		"past": "-{0} u.",
		"future": "+{0} u."
	],
	"minute": [
		"current": "sa mhion.",
		"past": "-{0} m",
		"future": "+{0} m"
	],
	"second": [
		"current": "an-dràsta",
		"past": "-{0} d",
		"future": "+{0} d"
	],
	"now": "an-dràsta"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "an-uiridh",
		"current": "am bliadhna",
		"next": "an ath-bhliadhna",
		"past": [
			"one": "{0} bhliadhna air ais",
			"two": "{0} bhliadhna air ais",
			"few": "{0} bhliadhnaichean air ais",
			"other": "{0} bliadhna air ais"
		],
		"future": [
			"one": "an ceann {0} bhliadhna",
			"two": "an ceann {0} bhliadhna",
			"few": "an ceann {0} bliadhnaichean",
			"other": "an ceann {0} bliadhna"
		]
	],
	"quarter": [
		"previous": "an cairteal seo chaidh",
		"current": "an cairteal seo",
		"next": "an ath-chairteal",
		"past": [
			"one": "o chionn {0} chairteil",
			"two": "o chionn {0} chairteil",
			"few": "o chionn {0} cairtealan",
			"other": "o chionn {0} cairteil"
		],
		"future": [
			"one": "an ceann {0} chairteil",
			"two": "an ceann {0} chairteil",
			"few": "an ceann {0} cairtealan",
			"other": "an ceann {0} cairteil"
		]
	],
	"month": [
		"previous": "am mìos seo chaidh",
		"current": "am mìos seo",
		"next": "an ath-mhìos",
		"past": [
			"one": "{0} mhìos air ais",
			"two": "{0} mhìos air ais",
			"few": "{0} mìosan air ais",
			"other": "{0} mìos air ais"
		],
		"future": [
			"one": "an ceann {0} mhìosa",
			"two": "an ceann {0} mhìosa",
			"few": "an ceann {0} mìosan",
			"other": "an ceann {0} mìosa"
		]
	],
	"week": [
		"previous": "an t-seachdain seo chaidh",
		"current": "an t-seachdain seo",
		"next": "an ath-sheachdain",
		"past": [
			"two": "{0} sheachdain air ais",
			"few": "{0} seachdainean air ais",
			"other": "{0} seachdain air ais"
		],
		"future": [
			"two": "an ceann {0} sheachdain",
			"few": "an ceann {0} seachdainean",
			"other": "an ceann {0} seachdain"
		]
	],
	"day": [
		"previous": "an-dè",
		"current": "an-diugh",
		"next": "a-màireach",
		"past": [
			"few": "{0} làithean air ais",
			"other": "{0} latha air ais"
		],
		"future": [
			"few": "an ceann {0} làithean",
			"other": "an ceann {0} latha"
		]
	],
	"hour": [
		"current": "am broinn uair a thìde",
		"past": [
			"few": "{0} uairean a thìde air ais",
			"other": "{0} uair a thìde air ais"
		],
		"future": [
			"few": "an ceann {0} uairean a thìde",
			"other": "an ceann {0} uair a thìde"
		]
	],
	"minute": [
		"current": "am broinn mionaid",
		"past": [
			"one": "{0} mhionaid air ais",
			"two": "{0} mhionaid air ais",
			"few": "{0} mionaidean air ais",
			"other": "{0} mionaid air ais"
		],
		"future": [
			"one": "an ceann {0} mhionaid",
			"two": "an ceann {0} mhionaid",
			"few": "an ceann {0} mionaidean",
			"other": "an ceann {0} mionaid"
		]
	],
	"second": [
		"current": "an-dràsta",
		"past": [
			"two": "{0} dhiog air ais",
			"few": "{0} diogan air ais",
			"other": "{0} diog air ais"
		],
		"future": [
			"two": "an ceann {0} dhiog",
			"few": "an ceann {0} diogan",
			"other": "an ceann {0} diog"
		]
	],
	"now": "an-dràsta"
]
	}
}
