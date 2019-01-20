import Foundation

// swiftlint:disable type_name
public class lang_ur: RelativeFormatterLang {

	/// Urdu
	public static let identifier: String = "ur"

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
		"previous": "گزشتہ سال",
		"current": "اس سال",
		"next": "اگلے سال",
		"past": "{0} سال پہلے",
		"future": "{0} سال میں"
	],
	"quarter": [
		"previous": "گزشتہ سہ ماہی",
		"current": "اس سہ ماہی",
		"next": "اگلے سہ ماہی",
		"past": "{0} سہ ماہی قبل",
		"future": "{0} سہ ماہی میں"
	],
	"month": [
		"previous": "پچھلے مہینہ",
		"current": "اس مہینہ",
		"next": "اگلے مہینہ",
		"past": "{0} ماہ قبل",
		"future": "{0} ماہ میں"
	],
	"week": [
		"previous": "پچھلے ہفتہ",
		"current": "اس ہفتہ",
		"next": "اگلے ہفتہ",
		"past": "{0} ہفتے پہلے",
		"future": "{0} ہفتے میں"
	],
	"day": [
		"previous": "گزشتہ کل",
		"current": "آج",
		"next": "آئندہ کل",
		"past": [
			"one": "{0} دن پہلے",
			"other": "{0} دنوں پہلے"
		],
		"future": [
			"one": "{0} دن میں",
			"other": "{0} دنوں میں"
		]
	],
	"hour": [
		"current": "اس گھنٹے",
		"past": "{0} گھنٹے پہلے",
		"future": "{0} گھنٹے میں"
	],
	"minute": [
		"current": "اس منٹ",
		"past": "{0} منٹ پہلے",
		"future": "{0} منٹ میں"
	],
	"second": [
		"current": "اب",
		"past": "{0} سیکنڈ پہلے",
		"future": "{0} سیکنڈ میں"
	],
	"now": "اب"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "گزشتہ سال",
		"current": "اس سال",
		"next": "اگلے سال",
		"past": "{0} سال پہلے",
		"future": "{0} سال میں"
	],
	"quarter": [
		"previous": "گزشتہ سہ ماہی",
		"current": "اس سہ ماہی",
		"next": "اگلے سہ ماہی",
		"past": "{0} سہ ماہی پہلے",
		"future": "{0} سہ ماہی میں"
	],
	"month": [
		"previous": "پچھلے مہینہ",
		"current": "اس مہینہ",
		"next": "اگلے مہینہ",
		"past": "{0} ماہ پہلے",
		"future": "{0} ماہ میں"
	],
	"week": [
		"previous": "پچھلے ہفتہ",
		"current": "اس ہفتہ",
		"next": "اگلے ہفتہ",
		"past": [
			"one": "{0} ہفتہ پہلے",
			"other": "{0} ہفتے پہلے"
		],
		"future": [
			"one": "{0} ہفتہ میں",
			"other": "{0} ہفتے میں"
		]
	],
	"day": [
		"previous": "گزشتہ کل",
		"current": "آج",
		"next": "آئندہ کل",
		"past": "{0} دن پہلے",
		"future": [
			"one": "{0} دن میں",
			"other": "{0} دنوں میں"
		]
	],
	"hour": [
		"current": "اس گھنٹے",
		"past": [
			"one": "{0} گھنٹہ پہلے",
			"other": "{0} گھنٹے پہلے"
		],
		"future": [
			"one": "{0} گھنٹہ میں",
			"other": "{0} گھنٹوں میں"
		]
	],
	"minute": [
		"current": "اس منٹ",
		"past": "{0} منٹ پہلے",
		"future": "{0} منٹ میں"
	],
	"second": [
		"current": "اب",
		"past": "{0} سیکنڈ پہلے",
		"future": "{0} سیکنڈ میں"
	],
	"now": "اب"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "گزشتہ سال",
		"current": "اس سال",
		"next": "اگلے سال",
		"past": "{0} سال پہلے",
		"future": "{0} سال میں"
	],
	"quarter": [
		"previous": "گزشتہ سہ ماہی",
		"current": "اس سہ ماہی",
		"next": "اگلے سہ ماہی",
		"past": "{0} سہ ماہی پہلے",
		"future": "{0} سہ ماہی میں"
	],
	"month": [
		"previous": "پچھلا مہینہ",
		"current": "اس مہینہ",
		"next": "اگلا مہینہ",
		"past": [
			"one": "{0} مہینہ پہلے",
			"other": "{0} مہینے پہلے"
		],
		"future": [
			"one": "{0} مہینہ میں",
			"other": "{0} مہینے میں"
		]
	],
	"week": [
		"previous": "پچھلے ہفتہ",
		"current": "اس ہفتہ",
		"next": "اگلے ہفتہ",
		"past": [
			"one": "{0} ہفتہ پہلے",
			"other": "{0} ہفتے پہلے"
		],
		"future": [
			"one": "{0} ہفتہ میں",
			"other": "{0} ہفتے میں"
		]
	],
	"day": [
		"previous": "گزشتہ کل",
		"current": "آج",
		"next": "آئندہ کل",
		"past": [
			"one": "{0} دن پہلے",
			"other": "{0} دنوں پہلے"
		],
		"future": [
			"one": "{0} دن میں",
			"other": "{0} دنوں میں"
		]
	],
	"hour": [
		"current": "اس گھنٹے",
		"past": [
			"one": "{0} گھنٹہ پہلے",
			"other": "{0} گھنٹے پہلے"
		],
		"future": "{0} گھنٹے میں"
	],
	"minute": [
		"current": "اس منٹ",
		"past": "{0} منٹ پہلے",
		"future": "{0} منٹ میں"
	],
	"second": [
		"current": "اب",
		"past": "{0} سیکنڈ پہلے",
		"future": "{0} سیکنڈ میں"
	],
	"now": "اب"
]
	}
}
