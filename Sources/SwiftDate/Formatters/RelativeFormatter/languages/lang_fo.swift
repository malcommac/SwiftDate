import Foundation

// swiftlint:disable type_name
public class lang_fo: RelativeFormatterLang {

	/// Faroese
	public static let identifier: String = "fo"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
/*
module.exports=function(n)[return 1==n?"one":"other"]
*/
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
		"previous": "í fjør",
		"current": "í ár",
		"next": "næsta ár",
		"past": "{0} ár síðan",
		"future": "um {0} ár"
	],
	"quarter": [
		"previous": "seinasta ársfjórðing",
		"current": "hendan ársfjórðingin",
		"next": "næsta ársfjórðing",
		"past": "{0} ársfj. síðan",
		"future": "um {0} ársfj."
	],
	"month": [
		"previous": "seinasta mánað",
		"current": "henda mánaðin",
		"next": "næsta mánað",
		"past": "{0} mnð. síðan",
		"future": "um {0} mnð."
	],
	"week": [
		"previous": "seinastu viku",
		"current": "hesu viku",
		"next": "næstu viku",
		"past": "{0} vi. síðan",
		"future": "um {0} vi."
	],
	"day": [
		"previous": "í gjár",
		"current": "í dag",
		"next": "í morgin",
		"past": "{0} da. síðan",
		"future": "um {0} da."
	],
	"hour": [
		"current": "hendan tíman",
		"past": "{0} t. síðan",
		"future": "um {0} t."
	],
	"minute": [
		"current": "hendan minuttin",
		"past": "{0} min. síðan",
		"future": "um {0} min."
	],
	"second": [
		"current": "nú",
		"past": "{0} sek. síðan",
		"future": "um {0} sek."
	],
	"now": "nú"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "í fjør",
		"current": "í ár",
		"next": "næsta ár",
		"past": "{0} ár síðan",
		"future": "um {0} ár"
	],
	"quarter": [
		"previous": "seinasta ársfjórðing",
		"current": "hendan ársfjórðingin",
		"next": "næsta ársfjórðing",
		"past": "{0} ársfj. síðan",
		"future": "um {0} ársfj."
	],
	"month": [
		"previous": "seinasta mánað",
		"current": "henda mánaðin",
		"next": "næsta mánað",
		"past": "{0} mnð. síðan",
		"future": "um {0} mnð."
	],
	"week": [
		"previous": "seinastu viku",
		"current": "hesu viku",
		"next": "næstu viku",
		"past": "{0} v. síðan",
		"future": "um {0} v."
	],
	"day": [
		"previous": "í gjár",
		"current": "í dag",
		"next": "í morgin",
		"past": "{0} d. síðan",
		"future": "um {0} d."
	],
	"hour": [
		"current": "hendan tíman",
		"past": "{0} t. síðan",
		"future": "um {0} t."
	],
	"minute": [
		"current": "hendan minuttin",
		"past": "{0} m. síðan",
		"future": "um {0} m."
	],
	"second": [
		"current": "nú",
		"past": "{0} s. síðan",
		"future": "um {0} s."
	],
	"now": "nú"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "í fjør",
		"current": "í ár",
		"next": "næsta ár",
		"past": "{0} ár síðan",
		"future": "um {0} ár"
	],
	"quarter": [
		"previous": "seinasta ársfjórðing",
		"current": "hendan ársfjórðingin",
		"next": "næsta ársfjórðing",
		"past": [
			"one": "{0} ársfjórðing síðan",
			"other": "{0} ársfjórðingar síðan"
		],
		"future": [
			"one": "um {0} ársfjórðing",
			"other": "um {0} ársfjórðingar"
		]
	],
	"month": [
		"previous": "seinasta mánað",
		"current": "henda mánaðin",
		"next": "næsta mánað",
		"past": [
			"one": "{0} mánað síðan",
			"other": "{0} mánaðir síðan"
		],
		"future": [
			"one": "um {0} mánað",
			"other": "um {0} mánaðir"
		]
	],
	"week": [
		"previous": "seinastu viku",
		"current": "hesu viku",
		"next": "næstu viku",
		"past": [
			"one": "{0} vika síðan",
			"other": "{0} vikur síðan"
		],
		"future": [
			"one": "um {0} viku",
			"other": "um {0} vikur"
		]
	],
	"day": [
		"previous": "í gjár",
		"current": "í dag",
		"next": "í morgin",
		"past": [
			"one": "{0} dagur síðan",
			"other": "{0} dagar síðan"
		],
		"future": [
			"one": "um {0} dag",
			"other": "um {0} dagar"
		]
	],
	"hour": [
		"current": "hendan tíman",
		"past": [
			"one": "{0} tími síðan",
			"other": "{0} tímar síðan"
		],
		"future": [
			"one": "um {0} tíma",
			"other": "um {0} tímar"
		]
	],
	"minute": [
		"current": "hendan minuttin",
		"past": [
			"one": "{0} minutt síðan",
			"other": "{0} minuttir síðan"
		],
		"future": [
			"one": "um {0} minutt",
			"other": "um {0} minuttir"
		]
	],
	"second": [
		"current": "nú",
		"past": "{0} sekund síðan",
		"future": "um {0} sekund"
	],
	"now": "nú"
]
	}
}
