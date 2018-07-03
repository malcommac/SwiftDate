import Foundation

// swiftlint:disable type_name
public class lang_mr: RelativeFormatterLang {

	/// Marathi
	public static let identifier: String = "mr"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value <= 1 ? .one : .other)
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
		"previous": "मागील वर्ष",
		"current": "हे वर्ष",
		"next": "पुढील वर्ष",
		"past": [
			"one": "{0} वर्षापूर्वी",
			"other": "{0} वर्षांपूर्वी"
		],
		"future": [
			"one": "{0} वर्षामध्ये",
			"other": "{0} वर्षांमध्ये"
		]
	],
	"quarter": [
		"previous": "मागील तिमाही",
		"current": "ही तिमाही",
		"next": "पुढील तिमाही",
		"past": [
			"one": "{0} तिमाहीपूर्वी",
			"other": "{0} तिमाहींपूर्वी"
		],
		"future": [
			"one": "येत्या {0} तिमाहीमध्ये",
			"other": "येत्या {0} तिमाहींमध्ये"
		]
	],
	"month": [
		"previous": "मागील महिना",
		"current": "हा महिना",
		"next": "पुढील महिना",
		"past": [
			"one": "{0} महिन्यापूर्वी",
			"other": "{0} महिन्यांपूर्वी"
		],
		"future": "{0} महिन्यामध्ये"
	],
	"week": [
		"previous": "मागील आठवडा",
		"current": "हा आठवडा",
		"next": "पुढील आठवडा",
		"past": [
			"one": "{0} आठवड्यापूर्वी",
			"other": "{0} आठवड्यांपूर्वी"
		],
		"future": [
			"one": "येत्या {0} आठवड्यामध्ये",
			"other": "येत्या {0} आठवड्यांमध्ये"
		]
	],
	"day": [
		"previous": "काल",
		"current": "आज",
		"next": "उद्या",
		"past": [
			"one": "{0} दिवसापूर्वी",
			"other": "{0} दिवसांपूर्वी"
		],
		"future": [
			"one": "{0} दिवसामध्ये",
			"other": "येत्या {0} दिवसांमध्ये"
		]
	],
	"hour": [
		"current": "तासात",
		"past": [
			"one": "{0} तासापूर्वी",
			"other": "{0} तासांपूर्वी"
		],
		"future": [
			"one": "{0} तासामध्ये",
			"other": "{0} तासांमध्ये"
		]
	],
	"minute": [
		"current": "या मिनिटात",
		"past": "{0} मिनि. पूर्वी",
		"future": "{0} मिनि. मध्ये"
	],
	"second": [
		"current": "आत्ता",
		"past": "{0} से. पूर्वी",
		"future": "{0} से. मध्ये"
	],
	"now": "आत्ता"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "मागील वर्ष",
		"current": "हे वर्ष",
		"next": "पुढील वर्ष",
		"past": [
			"one": "{0} वर्षापूर्वी",
			"other": "{0} वर्षांपूर्वी"
		],
		"future": [
			"one": "येत्या {0} वर्षामध्ये",
			"other": "येत्या {0} वर्षांमध्ये"
		]
	],
	"quarter": [
		"previous": "मागील तिमाही",
		"current": "ही तिमाही",
		"next": "पुढील तिमाही",
		"past": [
			"one": "{0} तिमाहीपूर्वी",
			"other": "{0} तिमाहींपूर्वी"
		],
		"future": [
			"one": "{0} तिमाहीमध्ये",
			"other": "{0} तिमाहींमध्ये"
		]
	],
	"month": [
		"previous": "मागील महिना",
		"current": "हा महिना",
		"next": "पुढील महिना",
		"past": [
			"one": "{0} महिन्यापूर्वी",
			"other": "{0} महिन्यांपूर्वी"
		],
		"future": [
			"one": "{0} महिन्यामध्ये",
			"other": "{0} महिन्यांमध्ये"
		]
	],
	"week": [
		"previous": "मागील आठवडा",
		"current": "हा आठवडा",
		"next": "पुढील आठवडा",
		"past": [
			"one": "{0} आठवड्यापूर्वी",
			"other": "{0} आठवड्यांपूर्वी"
		],
		"future": [
			"one": "येत्या {0} आठवड्यामध्ये",
			"other": "येत्या {0} आठवड्यांमध्ये"
		]
	],
	"day": [
		"previous": "काल",
		"current": "आज",
		"next": "उद्या",
		"past": [
			"one": "{0} दिवसापूर्वी",
			"other": "{0} दिवसांपूर्वी"
		],
		"future": [
			"one": "{0} दिवसामध्ये",
			"other": "{0} दिवसांमध्ये"
		]
	],
	"hour": [
		"current": "तासात",
		"past": [
			"one": "{0} तासापूर्वी",
			"other": "{0} तासांपूर्वी"
		],
		"future": [
			"one": "येत्या {0} तासामध्ये",
			"other": "येत्या {0} तासांमध्ये"
		]
	],
	"minute": [
		"current": "या मिनिटात",
		"past": "{0} मिनि. पूर्वी",
		"future": "{0} मिनि. मध्ये"
	],
	"second": [
		"current": "आत्ता",
		"past": "{0} से. पूर्वी",
		"future": [
			"one": "{0} से. मध्ये",
			"other": "येत्या {0} से. मध्ये"
		]
	],
	"now": "आत्ता"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "मागील वर्ष",
		"current": "हे वर्ष",
		"next": "पुढील वर्ष",
		"past": [
			"one": "{0} वर्षापूर्वी",
			"other": "{0} वर्षांपूर्वी"
		],
		"future": [
			"one": "येत्या {0} वर्षामध्ये",
			"other": "येत्या {0} वर्षांमध्ये"
		]
	],
	"quarter": [
		"previous": "मागील तिमाही",
		"current": "ही तिमाही",
		"next": "पुढील तिमाही",
		"past": [
			"one": "{0} तिमाहीपूर्वी",
			"other": "{0} तिमाहींपूर्वी"
		],
		"future": [
			"one": "{0} तिमाहीमध्ये",
			"other": "{0} तिमाहींमध्ये"
		]
	],
	"month": [
		"previous": "मागील महिना",
		"current": "हा महिना",
		"next": "पुढील महिना",
		"past": [
			"one": "{0} महिन्यापूर्वी",
			"other": "{0} महिन्यांपूर्वी"
		],
		"future": [
			"one": "येत्या {0} महिन्यामध्ये",
			"other": "येत्या {0} महिन्यांमध्ये"
		]
	],
	"week": [
		"previous": "मागील आठवडा",
		"current": "हा आठवडा",
		"next": "पुढील आठवडा",
		"past": [
			"one": "{0} आठवड्यापूर्वी",
			"other": "{0} आठवड्यांपूर्वी"
		],
		"future": [
			"one": "{0} आठवड्यामध्ये",
			"other": "{0} आठवड्यांमध्ये"
		]
	],
	"day": [
		"previous": "काल",
		"current": "आज",
		"next": "उद्या",
		"past": [
			"one": "{0} दिवसापूर्वी",
			"other": "{0} दिवसांपूर्वी"
		],
		"future": [
			"one": "येत्या {0} दिवसामध्ये",
			"other": "येत्या {0} दिवसांमध्ये"
		]
	],
	"hour": [
		"current": "तासात",
		"past": [
			"one": "{0} तासापूर्वी",
			"other": "{0} तासांपूर्वी"
		],
		"future": [
			"one": "{0} तासामध्ये",
			"other": "{0} तासांमध्ये"
		]
	],
	"minute": [
		"current": "या मिनिटात",
		"past": [
			"one": "{0} मिनिटापूर्वी",
			"other": "{0} मिनिटांपूर्वी"
		],
		"future": [
			"one": "{0} मिनिटामध्ये",
			"other": "{0} मिनिटांमध्ये"
		]
	],
	"second": [
		"current": "आत्ता",
		"past": [
			"one": "{0} सेकंदापूर्वी",
			"other": "{0} सेकंदांपूर्वी"
		],
		"future": [
			"one": "{0} सेकंदामध्ये",
			"other": "{0} सेकंदांमध्ये"
		]
	],
	"now": "आत्ता"
]
	}
}
