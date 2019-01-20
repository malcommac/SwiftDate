import Foundation

// swiftlint:disable type_name
public class lang_sw: RelativeFormatterLang {

	/// Swahili
	public static let identifier: String = "sw"

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
		"previous": "mwaka uliopita",
		"current": "mwaka huu",
		"next": "mwaka ujao",
		"past": [
			"one": "mwaka {0} uliopita",
			"other": "miaka {0} iliyopita"
		],
		"future": [
			"one": "baada ya mwaka {0}",
			"other": "baada ya miaka {0}"
		]
	],
	"quarter": [
		"previous": "robo ya mwaka iliyopita",
		"current": "robo hii ya mwaka",
		"next": "robo ya mwaka inayofuata",
		"past": [
			"one": "robo {0} iliyopita",
			"other": "robo {0} zilizopita"
		],
		"future": "baada ya robo {0}"
	],
	"month": [
		"previous": "mwezi uliopita",
		"current": "mwezi huu",
		"next": "mwezi ujao",
		"past": [
			"one": "mwezi {0} uliopita",
			"other": "miezi {0} iliyopita"
		],
		"future": [
			"one": "baada ya mwezi {0}",
			"other": "baada ya miezi {0}"
		]
	],
	"week": [
		"previous": "wiki iliyopita",
		"current": "wiki hii",
		"next": "wiki ijayo",
		"past": [
			"one": "wiki {0} iliyopita",
			"other": "wiki {0} zilizopita"
		],
		"future": "baada ya wiki {0}"
	],
	"day": [
		"previous": "jana",
		"current": "leo",
		"next": "kesho",
		"past": [
			"one": "siku {0} iliyopita",
			"other": "siku {0} zilizopita"
		],
		"future": "baada ya siku {0}"
	],
	"hour": [
		"current": "saa hii",
		"past": [
			"one": "saa {0} iliyopita",
			"other": "saa {0} zilizopita"
		],
		"future": "baada ya saa {0}"
	],
	"minute": [
		"current": "dakika hii",
		"past": [
			"one": "dakika {0} iliyopita",
			"other": "dakika {0} zilizopita"
		],
		"future": "baada ya dakika {0}"
	],
	"second": [
		"current": "sasa hivi",
		"past": [
			"one": "sekunde {0} iliyopita",
			"other": "sekunde {0} zilizopita"
		],
		"future": "baada ya sekunde {0}"
	],
	"now": "sasa hivi"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "mwaka uliopita",
		"current": "mwaka huu",
		"next": "mwaka ujao",
		"past": [
			"one": "mwaka {0} uliopita",
			"other": "miaka {0} iliyopita"
		],
		"future": [
			"one": "baada ya mwaka {0}",
			"other": "baada ya miaka {0}"
		]
	],
	"quarter": [
		"previous": "robo ya mwaka iliyopita",
		"current": "robo hii ya mwaka",
		"next": "robo ya mwaka inayofuata",
		"past": [
			"one": "robo {0} iliyopita",
			"other": "robo {0} zilizopita"
		],
		"future": "baada ya robo {0}"
	],
	"month": [
		"previous": "mwezi uliopita",
		"current": "mwezi huu",
		"next": "mwezi ujao",
		"past": [
			"one": "mwezi {0} uliopita",
			"other": "miezi {0} iliyopita"
		],
		"future": [
			"one": "baada ya mwezi {0}",
			"other": "baada ya miezi {0}"
		]
	],
	"week": [
		"previous": "wiki iliyopita",
		"current": "wiki hii",
		"next": "wiki ijayo",
		"past": [
			"one": "wiki {0} iliyopita",
			"other": "wiki {0} zilizopita"
		],
		"future": "baada ya wiki {0}"
	],
	"day": [
		"previous": "jana",
		"current": "leo",
		"next": "kesho",
		"past": [
			"one": "siku {0} iliyopita",
			"other": "siku {0} zilizopita"
		],
		"future": "baada ya siku {0}"
	],
	"hour": [
		"current": "saa hii",
		"past": [
			"one": "Saa {0} iliyopita",
			"other": "Saa {0} zilizopita"
		],
		"future": "baada ya saa {0}"
	],
	"minute": [
		"current": "dakika hii",
		"past": [
			"one": "dakika {0} iliyopita",
			"other": "dakika {0} zilizopita"
		],
		"future": "baada ya dakika {0}"
	],
	"second": [
		"current": "sasa hivi",
		"past": [
			"one": "sekunde {0} iliyopita",
			"other": "sekunde {0} zilizopita"
		],
		"future": "baada ya sekunde {0}"
	],
	"now": "sasa hivi"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "mwaka uliopita",
		"current": "mwaka huu",
		"next": "mwaka ujao",
		"past": [
			"one": "mwaka {0} uliopita",
			"other": "miaka {0} iliyopita"
		],
		"future": [
			"one": "baada ya mwaka {0}",
			"other": "baada ya miaka {0}"
		]
	],
	"quarter": [
		"previous": "robo ya mwaka iliyopita",
		"current": "robo hii ya mwaka",
		"next": "robo ya mwaka inayofuata",
		"past": [
			"one": "robo {0} iliyopita",
			"other": "robo {0} zilizopita"
		],
		"future": "baada ya robo {0}"
	],
	"month": [
		"previous": "mwezi uliopita",
		"current": "mwezi huu",
		"next": "mwezi ujao",
		"past": [
			"one": "mwezi {0} uliopita",
			"other": "miezi {0} iliyopita"
		],
		"future": [
			"one": "baada ya mwezi {0}",
			"other": "baada ya miezi {0}"
		]
	],
	"week": [
		"previous": "wiki iliyopita",
		"current": "wiki hii",
		"next": "wiki ijayo",
		"past": [
			"one": "wiki {0} iliyopita",
			"other": "wiki {0} zilizopita"
		],
		"future": "baada ya wiki {0}"
	],
	"day": [
		"previous": "jana",
		"current": "leo",
		"next": "kesho",
		"past": [
			"one": "siku {0} iliyopita",
			"other": "siku {0} zilizopita"
		],
		"future": "baada ya siku {0}"
	],
	"hour": [
		"current": "saa hii",
		"past": [
			"one": "saa {0} iliyopita",
			"other": "saa {0} zilizopita"
		],
		"future": "baada ya saa {0}"
	],
	"minute": [
		"current": "dakika hii",
		"past": [
			"one": "dakika {0} iliyopita",
			"other": "dakika {0} zilizopita"
		],
		"future": "baada ya dakika {0}"
	],
	"second": [
		"current": "sasa hivi",
		"past": [
			"one": "Sekunde {0} iliyopita",
			"other": "Sekunde {0} zilizopita"
		],
		"future": "baada ya sekunde {0}"
	],
	"now": "sasa hivi"
]
	}
}
