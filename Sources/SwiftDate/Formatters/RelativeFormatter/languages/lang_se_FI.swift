import Foundation

// swiftlint:disable type_name
public class lang_seFI: RelativeFormatterLang {

	/// Northern Sami (Finland)
	public static let identifier: String = "se_FI"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return .other
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
		"previous": "diibmá",
		"current": "dán jagi",
		"next": "boahtte jagi",
		"past": [
			"one": "diibmá",
			"two": "ovddet jagi",
			"other": "{0} j. dás ovdal"
		],
		"future": [
			"two": "{0} jagi siste",
			"other": "{0} j. siste"
		]
	],
	"quarter": [
		"previous": "mannan njealjádasjagi",
		"current": "dán njealjádasjagi",
		"next": "boahtte njealjádasjagi",
		"past": [
			"two": "{0} njealjádasjagi dás ovdal",
			"other": "{0} njealj.j. dás ovdal"
		],
		"future": [
			"two": "boahtte {0} njealjádasjagi",
			"other": "boahtte {0} njealj.j."
		]
	],
	"month": [
		"previous": "mannan mánu",
		"current": "dán mánu",
		"next": "boahtte mánu",
		"past": [
			"one": "{0} mánnu dás ovdal",
			"other": "{0} mánu dás ovdal"
		],
		"future": "{0} mánu siste"
	],
	"week": [
		"previous": "mannan vahku",
		"current": "dán vahku",
		"next": "boahtte vahku",
		"past": [
			"two": "{0} vahku dás ovdal",
			"other": "{0} v(k) dás ovdal"
		],
		"future": [
			"two": "{0} vahku siste",
			"other": "{0} v(k) siste"
		]
	],
	"day": [
		"previous": "ikte",
		"current": "odne",
		"next": "ihttin",
		"past": [
			"one": "ikte",
			"two": "ovddet beaivve",
			"other": "{0} beaivve dás ovdal"
		],
		"future": "{0} beaivve siste"
	],
	"hour": [
		"current": "dán diimmu",
		"past": [
			"two": "{0} diimmu áigi",
			"other": "{0} dmu áigi"
		],
		"future": [
			"two": "{0} diimmu siste",
			"other": "{0} dmu siste"
		]
	],
	"minute": [
		"current": "dán minuhta",
		"past": [
			"two": "{0} minuhta áigi",
			"other": "{0} min. áigi"
		],
		"future": [
			"two": "{0} minuhta siste",
			"other": "{0} min. siste"
		]
	],
	"second": [
		"current": "dál",
		"past": [
			"two": "{0} sekundda áigi",
			"other": "{0} sek. áigi"
		],
		"future": [
			"two": "{0} sekundda siste",
			"other": "{0} sek. siste"
		]
	],
	"now": "dál"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "diibmá",
		"current": "dán jagi",
		"next": "boahtte jagi",
		"past": [
			"two": "{0} jagi dás ovdal",
			"other": "{0} j. dás ovdal"
		],
		"future": "{0} jagi siste"
	],
	"quarter": [
		"previous": "mannan njealjádasjagi",
		"current": "dán njealjádasjagi",
		"next": "boahtte njealjádasjagi",
		"past": [
			"two": "-{0} njealjádasjagi dás ovdal",
			"other": "{0} njealj.j. dás ovdal"
		],
		"future": [
			"two": "boahtte {0} njealjádasjagi",
			"other": "boahtte {0} njealj.j."
		]
	],
	"month": [
		"previous": "mannan mánu",
		"current": "dán mánu",
		"next": "boahtte mánu",
		"past": [
			"one": "{0} mánnu dás ovdal",
			"other": "{0} mánu dás ovdal"
		],
		"future": "{0} mánu geahčen"
	],
	"week": [
		"previous": "mannan vahku",
		"current": "dán vahku",
		"next": "boahtte vahku",
		"past": [
			"one": "{0} vahkku dás ovdal",
			"two": "{0} vahku dás ovdal",
			"other": "{0} v(k) dás ovdal"
		],
		"future": "{0} v(k) geahčen"
	],
	"day": [
		"previous": "ikte",
		"current": "odne",
		"next": "ihttin",
		"past": [
			"one": "ikte",
			"two": "ovddet beaivve",
			"other": "{0} beaivve dás ovdal"
		],
		"future": "{0} beaivve siste"
	],
	"hour": [
		"current": "dán diimmu",
		"past": [
			"two": "{0} diimmu áigi",
			"other": "{0} dmu áigi"
		],
		"future": [
			"two": "{0} diimmu siste",
			"other": "{0} dmu siste"
		]
	],
	"minute": [
		"current": "dán minuhta",
		"past": [
			"two": "{0} minuhta áigi",
			"other": "{0} min. áigi"
		],
		"future": [
			"two": "{0} minuhta siste",
			"other": "{0} min. siste"
		]
	],
	"second": [
		"current": "dál",
		"past": [
			"two": "{0} sekundda áigi",
			"other": "{0} sek. áigi"
		],
		"future": [
			"two": "{0} sekundda siste",
			"other": "{0} sek. siste"
		]
	],
	"now": "dál"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "diibmá",
		"current": "dán jagi",
		"next": "boahtte jagi",
		"past": [
			"one": "diibmá",
			"two": "ovddet jagi",
			"other": "{0} jagi dás ovdal"
		],
		"future": "{0} jagi siste"
	],
	"quarter": [
		"previous": "mannan njealjádasjagi",
		"current": "dán njealjádasjagi",
		"next": "boahtte njealjádasjagi",
		"past": "-{0} njealjádasjagi dás ovdal",
		"future": "čuovvovaš {0} njealjádasjagi"
	],
	"month": [
		"previous": "mannan mánu",
		"current": "dán mánu",
		"next": "boahtte mánu",
		"past": [
			"one": "{0} mánnu dás ovdal",
			"other": "{0} mánu dás ovdal"
		],
		"future": "{0} mánu siste"
	],
	"week": [
		"previous": "mannan vahku",
		"current": "dán vahku",
		"next": "boahtte vahku",
		"past": [
			"one": "{0} vahkku dás ovdal",
			"other": "{0} vahku dás ovdal"
		],
		"future": "{0} vahku geahčen"
	],
	"day": [
		"previous": "ikte",
		"current": "odne",
		"next": "ihttin",
		"past": [
			"one": "ikte",
			"two": "ovddet beaivve",
			"other": "{0} beaivve dás ovdal"
		],
		"future": "{0} beaivve siste"
	],
	"hour": [
		"current": "dán diimmu",
		"past": [
			"one": "{0} diibmu áigi",
			"other": "{0} diimmu áigi"
		],
		"future": "{0} diimmu siste"
	],
	"minute": [
		"current": "dán minuhta",
		"past": [
			"one": "{0} minuhtta áigi",
			"other": "{0} minuhta áigi"
		],
		"future": "{0} minuhta siste"
	],
	"second": [
		"current": "dál",
		"past": [
			"one": "{0} sekunda áigi",
			"other": "{0} sekundda áigi"
		],
		"future": "{0} sekundda siste"
	],
	"now": "dál"
]
	}
}
