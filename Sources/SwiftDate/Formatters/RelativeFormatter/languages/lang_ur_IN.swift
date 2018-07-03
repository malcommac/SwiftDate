import Foundation

// swiftlint:disable type_name
public class lang_urIN: RelativeFormatterLang {

	/// Urdu (India)
	public static let identifier: String = "ur_IN"

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
		"previous": "گزشتہ سال",
		"current": "اس سال",
		"next": "اگلے سال",
		"past": [
			"one": "{0} سال پہلے",
			"other": "{0} سالوں پہلے"
		],
		"future": [
			"one": "{0} سال میں",
			"other": "{0} سالوں میں"
		]
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
		"past": "{0} ہفتے قبل",
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
		"future": "{0} دنوں میں"
	],
	"hour": [
		"current": "اس گھنٹے",
		"past": "{0} گھنٹے قبل",
		"future": "{0} گھنٹے میں"
	],
	"minute": [
		"current": "اس منٹ",
		"past": "{0} منٹ قبل",
		"future": "{0} منٹ میں"
	],
	"second": [
		"current": "اب",
		"past": "{0} سیکنڈ قبل",
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
		"past": "{0} ماہ قبل",
		"future": "{0} ماہ میں"
	],
	"week": [
		"previous": "پچھلے ہفتہ",
		"current": "اس ہفتہ",
		"next": "اگلے ہفتہ",
		"past": [
			"one": "{0} ہفتہ قبل",
			"other": "{0} ہفتے قبل"
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
		"past": "{0} دن قبل",
		"future": [
			"one": "{0} دن میں",
			"other": "{0} دنوں میں"
		]
	],
	"hour": [
		"current": "اس گھنٹے",
		"past": [
			"one": "{0} گھنٹہ قبل",
			"other": "{0} گھنٹے قبل"
		],
		"future": [
			"one": "{0} گھنٹہ میں",
			"other": "{0} گھنٹوں میں"
		]
	],
	"minute": [
		"current": "اس منٹ",
		"past": "{0} منٹ قبل",
		"future": "{0} منٹ میں"
	],
	"second": [
		"current": "اب",
		"past": "{0} سیکنڈ قبل",
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
		"future": [
			"one": "{0} سال میں",
			"other": "{0} سالوں میں"
		]
	],
	"quarter": [
		"previous": "گزشتہ سہ ماہی",
		"current": "اس سہ ماہی",
		"next": "اگلے سہ ماہی",
		"past": "{0} سہ ماہی پہلے",
		"future": "{0} سہ ماہی میں"
	],
	"month": [
		"previous": "گزشتہ ماہ",
		"current": "اس ماہ",
		"next": "اگلے ماہ",
		"past": "{0} ماہ قبل",
		"future": "{0} ماہ میں"
	],
	"week": [
		"previous": "گزشتہ ہفتہ",
		"current": "اس ہفتہ",
		"next": "اگلے ہفتہ",
		"past": [
			"one": "{0} ہفتہ قبل",
			"other": "{0} ہفتے قبل"
		],
		"future": [
			"one": "{0} ہفتہ میں",
			"other": "{0} ہفتوں میں"
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
		"past": "{0} منٹ قبل",
		"future": "{0} منٹ میں"
	],
	"second": [
		"current": "اب",
		"past": "{0} سیکنڈ قبل",
		"future": "{0} سیکنڈ میں"
	],
	"now": "اب"
]
	}
}
