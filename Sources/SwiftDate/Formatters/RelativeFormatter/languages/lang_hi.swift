import Foundation

// swiftlint:disable type_name
public class lang_hi: RelativeFormatterLang {

	/// Hindi
	public static let identifier: String = "hi"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value <= 1 ? .one : .other)
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
		"previous": "पिछला वर्ष",
		"current": "इस वर्ष",
		"next": "अगला वर्ष",
		"past": "{0} वर्ष पहले",
		"future": "{0} वर्ष में"
	],
	"quarter": [
		"previous": "अंतिम तिमाही",
		"current": "इस तिमाही",
		"next": "अगली तिमाही",
		"past": [
			"one": "{0} तिमाही पहले",
			"other": "{0} तिमाहियों पहले"
		],
		"future": [
			"one": "{0} तिमाही में",
			"other": "{0} तिमाहियों में"
		]
	],
	"month": [
		"previous": "पिछला माह",
		"current": "इस माह",
		"next": "अगला माह",
		"past": "{0} माह पहले",
		"future": "{0} माह में"
	],
	"week": [
		"previous": "पिछला सप्ताह",
		"current": "इस सप्ताह",
		"next": "अगला सप्ताह",
		"past": "{0} सप्ताह पहले",
		"future": "{0} सप्ताह में"
	],
	"day": [
		"previous": "कल",
		"current": "आज",
		"next": "कल",
		"past": "{0} दिन पहले",
		"future": "{0} दिन में"
	],
	"hour": [
		"current": "यह घंटा",
		"past": "{0} घं॰ पहले",
		"future": "{0} घं॰ में"
	],
	"minute": [
		"current": "यह मिनट",
		"past": "{0} मि॰ पहले",
		"future": "{0} मि॰ में"
	],
	"second": [
		"current": "अब",
		"past": "{0} से॰ पहले",
		"future": "{0} से॰ में"
	],
	"now": "अब"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "पिछला वर्ष",
		"current": "इस वर्ष",
		"next": "अगला वर्ष",
		"past": "{0} वर्ष पहले",
		"future": "{0} वर्ष में"
	],
	"quarter": [
		"previous": "अंतिम तिमाही",
		"current": "इस तिमाही",
		"next": "अगली तिमाही",
		"past": "{0} ति॰ पहले",
		"future": "{0} ति॰ में"
	],
	"month": [
		"previous": "पिछला माह",
		"current": "इस माह",
		"next": "अगला माह",
		"past": "{0} माह पहले",
		"future": "{0} माह में"
	],
	"week": [
		"previous": "पिछला सप्ताह",
		"current": "इस सप्ताह",
		"next": "अगला सप्ताह",
		"past": "{0} सप्ताह पहले",
		"future": "{0} सप्ताह में"
	],
	"day": [
		"previous": "कल",
		"current": "आज",
		"next": "कल",
		"past": "{0} दिन पहले",
		"future": "{0} दिन में"
	],
	"hour": [
		"current": "यह घंटा",
		"past": "{0} घं॰ पहले",
		"future": "{0} घं॰ में"
	],
	"minute": [
		"current": "यह मिनट",
		"past": "{0} मि॰ पहले",
		"future": "{0} मि॰ में"
	],
	"second": [
		"current": "अब",
		"past": "{0} से॰ पहले",
		"future": "{0} से॰ में"
	],
	"now": "अब"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "पिछला वर्ष",
		"current": "इस वर्ष",
		"next": "अगला वर्ष",
		"past": "{0} वर्ष पहले",
		"future": "{0} वर्ष में"
	],
	"quarter": [
		"previous": "अंतिम तिमाही",
		"current": "इस तिमाही",
		"next": "अगली तिमाही",
		"past": "{0} तिमाही पहले",
		"future": [
			"one": "{0} तिमाही में",
			"other": "{0} तिमाहियों में"
		]
	],
	"month": [
		"previous": "पिछला माह",
		"current": "इस माह",
		"next": "अगला माह",
		"past": "{0} माह पहले",
		"future": "{0} माह में"
	],
	"week": [
		"previous": "पिछला सप्ताह",
		"current": "इस सप्ताह",
		"next": "अगला सप्ताह",
		"past": "{0} सप्ताह पहले",
		"future": "{0} सप्ताह में"
	],
	"day": [
		"previous": "कल",
		"current": "आज",
		"next": "कल",
		"past": "{0} दिन पहले",
		"future": "{0} दिन में"
	],
	"hour": [
		"current": "यह घंटा",
		"past": "{0} घंटे पहले",
		"future": "{0} घंटे में"
	],
	"minute": [
		"current": "यह मिनट",
		"past": "{0} मिनट पहले",
		"future": "{0} मिनट में"
	],
	"second": [
		"current": "अब",
		"past": "{0} सेकंड पहले",
		"future": "{0} सेकंड में"
	],
	"now": "अब"
]
	}
}
