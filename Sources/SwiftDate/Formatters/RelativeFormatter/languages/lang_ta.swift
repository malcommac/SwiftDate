import Foundation

// swiftlint:disable type_name
public class lang_ta: RelativeFormatterLang {

	/// Tamil
	public static let identifier: String = "ta"

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
		"previous": "கடந்த ஆண்டு",
		"current": "இந்த ஆண்டு",
		"next": "அடுத்த ஆண்டு",
		"past": [
			"one": "{0} ஆண்டிற்கு முன்",
			"other": "{0} ஆண்டுகளுக்கு முன்"
		],
		"future": [
			"one": "{0} ஆண்டில்",
			"other": "{0} ஆண்டுகளில்"
		]
	],
	"quarter": [
		"previous": "இறுதி காலாண்டு",
		"current": "இந்த காலாண்டு",
		"next": "அடுத்த காலாண்டு",
		"past": "{0} காலா. முன்",
		"future": "{0} காலா."
	],
	"month": [
		"previous": "கடந்த மாதம்",
		"current": "இந்த மாதம்",
		"next": "அடுத்த மாதம்",
		"past": "{0} மாத. முன்",
		"future": "{0} மாத."
	],
	"week": [
		"previous": "கடந்த வாரம்",
		"current": "இந்த வாரம்",
		"next": "அடுத்த வாரம்",
		"past": "{0} வார. முன்",
		"future": "{0} வார."
	],
	"day": [
		"previous": "நேற்று",
		"current": "இன்று",
		"next": "நாளை",
		"past": [
			"one": "{0} நாளுக்கு முன்",
			"other": "{0} நாட்களுக்கு முன்"
		],
		"future": [
			"one": "{0} நாளில்",
			"other": "{0} நாட்களில்"
		]
	],
	"hour": [
		"current": "இந்த ஒரு மணிநேரத்தில்",
		"past": "{0} மணி. முன்",
		"future": "{0} மணி."
	],
	"minute": [
		"current": "இந்த ஒரு நிமிடத்தில்",
		"past": "{0} நிமி. முன்",
		"future": "{0} நிமி."
	],
	"second": [
		"current": "இப்போது",
		"past": "{0} விநா. முன்",
		"future": "{0} விநா."
	],
	"now": "இப்போது"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "கடந்த ஆண்டு",
		"current": "இந்த ஆண்டு",
		"next": "அடுத்த ஆண்டு",
		"past": "{0} ஆ. முன்",
		"future": "{0} ஆ."
	],
	"quarter": [
		"previous": "இறுதி காலாண்டு",
		"current": "இந்த காலாண்டு",
		"next": "அடுத்த காலாண்டு",
		"past": "{0} கா. முன்",
		"future": "{0} கா."
	],
	"month": [
		"previous": "கடந்த மாதம்",
		"current": "இந்த மாதம்",
		"next": "அடுத்த மாதம்",
		"past": "{0} மா. முன்",
		"future": "{0} மா."
	],
	"week": [
		"previous": "கடந்த வாரம்",
		"current": "இந்த வாரம்",
		"next": "அடுத்த வாரம்",
		"past": "{0} வா. முன்",
		"future": "{0} வா."
	],
	"day": [
		"previous": "நேற்று",
		"current": "இன்று",
		"next": "நாளை",
		"past": "{0} நா. முன்",
		"future": "{0} நா."
	],
	"hour": [
		"current": "இந்த ஒரு மணிநேரத்தில்",
		"past": "{0} ம. முன்",
		"future": "{0} ம."
	],
	"minute": [
		"current": "இந்த ஒரு நிமிடத்தில்",
		"past": "{0} நி. முன்",
		"future": "{0} நி."
	],
	"second": [
		"current": "இப்போது",
		"past": "{0} வி. முன்",
		"future": "{0} வி."
	],
	"now": "இப்போது"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "கடந்த ஆண்டு",
		"current": "இந்த ஆண்டு",
		"next": "அடுத்த ஆண்டு",
		"past": [
			"one": "{0} ஆண்டிற்கு முன்",
			"other": "{0} ஆண்டுகளுக்கு முன்"
		],
		"future": [
			"one": "{0} ஆண்டில்",
			"other": "{0} ஆண்டுகளில்"
		]
	],
	"quarter": [
		"previous": "கடந்த காலாண்டு",
		"current": "இந்த காலாண்டு",
		"next": "அடுத்த காலாண்டு",
		"past": [
			"one": "{0} காலாண்டுக்கு முன்",
			"other": "{0} காலாண்டுகளுக்கு முன்"
		],
		"future": [
			"one": "+{0} காலாண்டில்",
			"other": "{0} காலாண்டுகளில்"
		]
	],
	"month": [
		"previous": "கடந்த மாதம்",
		"current": "இந்த மாதம்",
		"next": "அடுத்த மாதம்",
		"past": [
			"one": "{0} மாதத்துக்கு முன்",
			"other": "{0} மாதங்களுக்கு முன்"
		],
		"future": [
			"one": "{0} மாதத்தில்",
			"other": "{0} மாதங்களில்"
		]
	],
	"week": [
		"previous": "கடந்த வாரம்",
		"current": "இந்த வாரம்",
		"next": "அடுத்த வாரம்",
		"past": [
			"one": "{0} வாரத்திற்கு முன்",
			"other": "{0} வாரங்களுக்கு முன்"
		],
		"future": [
			"one": "{0} வாரத்தில்",
			"other": "{0} வாரங்களில்"
		]
	],
	"day": [
		"previous": "நேற்று",
		"current": "இன்று",
		"next": "நாளை",
		"past": [
			"one": "{0} நாளுக்கு முன்",
			"other": "{0} நாட்களுக்கு முன்"
		],
		"future": [
			"one": "{0} நாளில்",
			"other": "{0} நாட்களில்"
		]
	],
	"hour": [
		"current": "இந்த ஒரு மணிநேரத்தில்",
		"past": "{0} மணிநேரம் முன்",
		"future": "{0} மணிநேரத்தில்"
	],
	"minute": [
		"current": "இந்த ஒரு நிமிடத்தில்",
		"past": [
			"one": "{0} நிமிடத்திற்கு முன்",
			"other": "{0} நிமிடங்களுக்கு முன்"
		],
		"future": [
			"one": "{0} நிமிடத்தில்",
			"other": "{0} நிமிடங்களில்"
		]
	],
	"second": [
		"current": "இப்போது",
		"past": [
			"one": "{0} விநாடிக்கு முன்",
			"other": "{0} விநாடிகளுக்கு முன்"
		],
		"future": [
			"one": "{0} விநாடியில்",
			"other": "{0} விநாடிகளில்"
		]
	],
	"now": "இப்போது"
]
	}
}
