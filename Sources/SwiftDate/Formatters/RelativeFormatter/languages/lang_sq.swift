import Foundation

// swiftlint:disable type_name
public class lang_sq: RelativeFormatterLang {

	/// Albanian
	public static let identifier: String = "sq"

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
		"previous": "vitin e kaluar",
		"current": "këtë vit",
		"next": "vitin e ardhshëm",
		"past": [
			"one": "{0} vit më parë",
			"other": "{0} vjet më parë"
		],
		"future": [
			"one": "pas {0} viti",
			"other": "pas {0} vjetësh"
		]
	],
	"quarter": [
		"previous": "tremujorin e kaluar",
		"current": "këtë tremujor",
		"next": "tremujorin e ardhshëm",
		"past": [
			"one": "{0} tremujor më parë",
			"other": "{0} tremujorë më parë"
		],
		"future": [
			"one": "pas {0} tremujori",
			"other": "pas {0} tremujorësh"
		]
	],
	"month": [
		"previous": "muajin e kaluar",
		"current": "këtë muaj",
		"next": "muajin e ardhshëm",
		"past": "{0} muaj më parë",
		"future": [
			"one": "pas {0} muaji",
			"other": "pas {0} muajsh"
		]
	],
	"week": [
		"previous": "javën e kaluar",
		"current": "këtë javë",
		"next": "javën e ardhshme",
		"past": "{0} javë më parë",
		"future": [
			"one": "pas {0} jave",
			"other": "pas {0} javësh"
		]
	],
	"day": [
		"previous": "dje",
		"current": "sot",
		"next": "nesër",
		"past": "{0} ditë më parë",
		"future": [
			"one": "pas {0} dite",
			"other": "pas {0} ditësh"
		]
	],
	"hour": [
		"current": "këtë orë",
		"past": "{0} orë më parë",
		"future": [
			"one": "pas {0} ore",
			"other": "pas {0} orësh"
		]
	],
	"minute": [
		"current": "këtë minutë",
		"past": "{0} min. më parë",
		"future": "pas {0} min."
	],
	"second": [
		"current": "tani",
		"past": "{0} sek. më parë",
		"future": "pas {0} sek."
	],
	"now": "tani"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "vitin e kaluar",
		"current": "këtë vit",
		"next": "vitin e ardhshëm",
		"past": [
			"one": "{0} vit më parë",
			"other": "{0} vjet më parë"
		],
		"future": [
			"one": "pas {0} viti",
			"other": "pas {0} vjetësh"
		]
	],
	"quarter": [
		"previous": "tremujorin e kaluar",
		"current": "këtë tremujor",
		"next": "tremujorin e ardhshëm",
		"past": [
			"one": "{0} tremujor më parë",
			"other": "{0} tremujorë më parë"
		],
		"future": [
			"one": "pas {0} tremujori",
			"other": "pas {0} tremujorësh"
		]
	],
	"month": [
		"previous": "muajin e kaluar",
		"current": "këtë muaj",
		"next": "muajin e ardhshëm",
		"past": "{0} muaj më parë",
		"future": [
			"one": "pas {0} muaji",
			"other": "pas {0} muajsh"
		]
	],
	"week": [
		"previous": "javën e kaluar",
		"current": "këtë javë",
		"next": "javën e ardhshme",
		"past": "{0} javë më parë",
		"future": [
			"one": "pas {0} jave",
			"other": "pas {0} javësh"
		]
	],
	"day": [
		"previous": "dje",
		"current": "sot",
		"next": "nesër",
		"past": "{0} ditë më parë",
		"future": [
			"one": "pas {0} dite",
			"other": "pas {0} ditësh"
		]
	],
	"hour": [
		"current": "këtë orë",
		"past": "{0} orë më parë",
		"future": [
			"one": "pas {0} ore",
			"other": "pas {0} orësh"
		]
	],
	"minute": [
		"current": "këtë minutë",
		"past": "{0} min. më parë",
		"future": "pas {0} min."
	],
	"second": [
		"current": "tani",
		"past": "{0} sek. më parë",
		"future": "pas {0} sek."
	],
	"now": "tani"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "vitin e kaluar",
		"current": "këtë vit",
		"next": "vitin e ardhshëm",
		"past": [
			"one": "{0} vit më parë",
			"other": "{0} vjet më parë"
		],
		"future": [
			"one": "pas {0} viti",
			"other": "pas {0} vjetësh"
		]
	],
	"quarter": [
		"previous": "tremujorin e kaluar",
		"current": "këtë tremujor",
		"next": "tremujorin e ardhshëm",
		"past": [
			"one": "{0} tremujor më parë",
			"other": "{0} tremujorë më parë"
		],
		"future": [
			"one": "pas {0} tremujori",
			"other": "pas {0} tremujorësh"
		]
	],
	"month": [
		"previous": "muajin e kaluar",
		"current": "këtë muaj",
		"next": "muajin e ardhshëm",
		"past": "{0} muaj më parë",
		"future": [
			"one": "pas {0} muaji",
			"other": "pas {0} muajsh"
		]
	],
	"week": [
		"previous": "javën e kaluar",
		"current": "këtë javë",
		"next": "javën e ardhshme",
		"past": "{0} javë më parë",
		"future": [
			"one": "pas {0} jave",
			"other": "pas {0} javësh"
		]
	],
	"day": [
		"previous": "dje",
		"current": "sot",
		"next": "nesër",
		"past": "{0} ditë më parë",
		"future": [
			"one": "pas {0} dite",
			"other": "pas {0} ditësh"
		]
	],
	"hour": [
		"current": "këtë orë",
		"past": "{0} orë më parë",
		"future": [
			"one": "pas {0} ore",
			"other": "pas {0} orësh"
		]
	],
	"minute": [
		"current": "këtë minutë",
		"past": [
			"one": "{0} minutë më parë",
			"other": "{0} minuta më parë"
		],
		"future": [
			"one": "pas {0} minute",
			"other": "pas {0} minutash"
		]
	],
	"second": [
		"current": "tani",
		"past": [
			"one": "{0} sekondë më parë",
			"other": "{0} sekonda më parë"
		],
		"future": [
			"one": "pas {0} sekonde",
			"other": "pas {0} sekondash"
		]
	],
	"now": "tani"
]
	}
}
