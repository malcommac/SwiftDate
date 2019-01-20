import Foundation

// swiftlint:disable type_name
public class lang_te: RelativeFormatterLang {

	/// Telugu
	public static let identifier: String = "te"

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
		"previous": "గత సంవత్సరం",
		"current": "ఈ సంవత్సరం",
		"next": "తదుపరి సంవత్సరం",
		"past": "{0} సం. క్రితం",
		"future": [
			"one": "{0} సం.లో",
			"other": "{0} సం.ల్లో"
		]
	],
	"quarter": [
		"previous": "గత త్రైమాసికం",
		"current": "ఈ త్రైమాసికం",
		"next": "తదుపరి త్రైమాసికం",
		"past": "{0} త్రైమా. క్రితం",
		"future": [
			"one": "{0} త్రైమా.లో",
			"other": "{0} త్రైమా.ల్లో"
		]
	],
	"month": [
		"previous": "గత నెల",
		"current": "ఈ నెల",
		"next": "తదుపరి నెల",
		"past": [
			"one": "{0} నెల క్రితం",
			"other": "{0} నెలల క్రితం"
		],
		"future": [
			"one": "{0} నెలలో",
			"other": "{0} నెలల్లో"
		]
	],
	"week": [
		"previous": "గత వారం",
		"current": "ఈ వారం",
		"next": "తదుపరి వారం",
		"past": [
			"one": "{0} వారం క్రితం",
			"other": "{0} వారాల క్రితం"
		],
		"future": [
			"one": "{0} వారంలో",
			"other": "{0} వారాల్లో"
		]
	],
	"day": [
		"previous": "నిన్న",
		"current": "ఈ రోజు",
		"next": "రేపు",
		"past": [
			"one": "{0} రోజు క్రితం",
			"other": "{0} రోజుల క్రితం"
		],
		"future": [
			"one": "{0} రోజులో",
			"other": "{0} రోజుల్లో"
		]
	],
	"hour": [
		"current": "ఈ గంట",
		"past": "{0} గం. క్రితం",
		"future": "{0} గం.లో"
	],
	"minute": [
		"current": "ఈ నిమిషం",
		"past": "{0} నిమి. క్రితం",
		"future": "{0} నిమి.లో"
	],
	"second": [
		"current": "ప్రస్తుతం",
		"past": "{0} సెక. క్రితం",
		"future": [
			"one": "{0} సెకనులో",
			"other": "{0} సెకన్లలో"
		]
	],
	"now": "ప్రస్తుతం"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "గత సంవత్సరం",
		"current": "ఈ సంవత్సరం",
		"next": "తదుపరి సంవత్సరం",
		"past": "{0} సం. క్రితం",
		"future": [
			"one": "{0} సం.లో",
			"other": "{0} సం.ల్లో"
		]
	],
	"quarter": [
		"previous": "గత త్రైమాసికం",
		"current": "ఈ త్రైమాసికం",
		"next": "తదుపరి త్రైమాసికం",
		"past": "{0} త్రైమా. క్రితం",
		"future": [
			"one": "{0} త్రైమాసికంలో",
			"other": "{0} త్రైమాసికాల్లో"
		]
	],
	"month": [
		"previous": "గత నెల",
		"current": "ఈ నెల",
		"next": "తదుపరి నెల",
		"past": [
			"one": "{0} నెల క్రితం",
			"other": "{0} నెలల క్రితం"
		],
		"future": [
			"one": "{0} నెలలో",
			"other": "{0} నెలల్లో"
		]
	],
	"week": [
		"previous": "గత వారం",
		"current": "ఈ వారం",
		"next": "తదుపరి వారం",
		"past": [
			"one": "{0} వారం క్రితం",
			"other": "{0} వారాల క్రితం"
		],
		"future": [
			"one": "{0} వారంలో",
			"other": "{0} వారాల్లో"
		]
	],
	"day": [
		"previous": "నిన్న",
		"current": "ఈ రోజు",
		"next": "రేపు",
		"past": [
			"one": "{0} రోజు క్రితం",
			"other": "{0} రోజుల క్రితం"
		],
		"future": [
			"one": "{0} రోజులో",
			"other": "{0} రోజుల్లో"
		]
	],
	"hour": [
		"current": "ఈ గంట",
		"past": "{0} గం. క్రితం",
		"future": "{0} గం.లో"
	],
	"minute": [
		"current": "ఈ నిమిషం",
		"past": "{0} నిమి. క్రితం",
		"future": "{0} నిమి.లో"
	],
	"second": [
		"current": "ప్రస్తుతం",
		"past": "{0} సెక. క్రితం",
		"future": [
			"one": "{0} సెక.లో",
			"other": "{0} సెక. లో"
		]
	],
	"now": "ప్రస్తుతం"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "గత సంవత్సరం",
		"current": "ఈ సంవత్సరం",
		"next": "తదుపరి సంవత్సరం",
		"past": [
			"one": "{0} సంవత్సరం క్రితం",
			"other": "{0} సంవత్సరాల క్రితం"
		],
		"future": [
			"one": "{0} సంవత్సరంలో",
			"other": "{0} సంవత్సరాల్లో"
		]
	],
	"quarter": [
		"previous": "గత త్రైమాసికం",
		"current": "ఈ త్రైమాసికం",
		"next": "తదుపరి త్రైమాసికం",
		"past": [
			"one": "{0} త్రైమాసికం క్రితం",
			"other": "{0} త్రైమాసికాల క్రితం"
		],
		"future": [
			"one": "{0} త్రైమాసికంలో",
			"other": "{0} త్రైమాసికాల్లో"
		]
	],
	"month": [
		"previous": "గత నెల",
		"current": "ఈ నెల",
		"next": "తదుపరి నెల",
		"past": [
			"one": "{0} నెల క్రితం",
			"other": "{0} నెలల క్రితం"
		],
		"future": [
			"one": "{0} నెలలో",
			"other": "{0} నెలల్లో"
		]
	],
	"week": [
		"previous": "గత వారం",
		"current": "ఈ వారం",
		"next": "తదుపరి వారం",
		"past": [
			"one": "{0} వారం క్రితం",
			"other": "{0} వారాల క్రితం"
		],
		"future": [
			"one": "{0} వారంలో",
			"other": "{0} వారాల్లో"
		]
	],
	"day": [
		"previous": "నిన్న",
		"current": "ఈ రోజు",
		"next": "రేపు",
		"past": [
			"one": "{0} రోజు క్రితం",
			"other": "{0} రోజుల క్రితం"
		],
		"future": [
			"one": "{0} రోజులో",
			"other": "{0} రోజుల్లో"
		]
	],
	"hour": [
		"current": "ఈ గంట",
		"past": [
			"one": "{0} గంట క్రితం",
			"other": "{0} గంటల క్రితం"
		],
		"future": [
			"one": "{0} గంటలో",
			"other": "{0} గంటల్లో"
		]
	],
	"minute": [
		"current": "ఈ నిమిషం",
		"past": [
			"one": "{0} నిమిషం క్రితం",
			"other": "{0} నిమిషాల క్రితం"
		],
		"future": [
			"one": "{0} నిమిషంలో",
			"other": "{0} నిమిషాల్లో"
		]
	],
	"second": [
		"current": "ప్రస్తుతం",
		"past": [
			"one": "{0} సెకను క్రితం",
			"other": "{0} సెకన్ల క్రితం"
		],
		"future": [
			"one": "{0} సెకనులో",
			"other": "{0} సెకన్లలో"
		]
	],
	"now": "ప్రస్తుతం"
]
	}
}
