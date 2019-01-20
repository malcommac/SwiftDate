import Foundation

// swiftlint:disable type_name
public class lang_sd: RelativeFormatterLang {

	/// Sindhi
	public static let identifier: String = "sd"

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
		"previous": "پويون سال",
		"current": "پويون سال",
		"next": "پويون سال",
		"past": "{0} سال پهرين",
		"future": "{0} سالن ۾"
	],
	"quarter": [
		"previous": "پوئين ٽي ماهي",
		"current": "هن ٽي ماهي",
		"next": "اڳين ٽي ماهي",
		"past": "{0} ٽي ماهي پهرين",
		"future": "{0} ٽي ماهي ۾"
	],
	"month": [
		"previous": "پوئين مهيني",
		"current": "هن مهيني",
		"next": "اڳين مهيني",
		"past": "{0} مهينا پهرين",
		"future": "{0} مهينن ۾"
	],
	"week": [
		"previous": "پوئين هفتي",
		"current": "هن هفتي",
		"next": "اڳين هفتي",
		"past": "{0} هفتا پهرين",
		"future": "{0} هفتن ۾"
	],
	"day": [
		"previous": "ڪل",
		"current": "اڄ",
		"next": "سڀاڻي",
		"past": "{0} ڏينهن پهرين",
		"future": "{0} ڏينهن ۾"
	],
	"hour": [
		"current": "هن ڪلڪ",
		"past": "{0} ڪلاڪ پهرين",
		"future": "{0} ڪلاڪ ۾"
	],
	"minute": [
		"current": "هن منٽ",
		"past": "{0} منٽ پهرين",
		"future": "{0} منٽن ۾"
	],
	"second": [
		"current": "هاڻي",
		"past": "{0} سيڪنڊ پهرين",
		"future": "{0} سيڪنڊن ۾"
	],
	"now": "هاڻي"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "پويون سال",
		"current": "پويون سال",
		"next": "پويون سال",
		"past": "{0} سال پهرين",
		"future": "{0} سالن ۾"
	],
	"quarter": [
		"previous": "پوئين ٽي ماهي",
		"current": "هن ٽي ماهي",
		"next": "اڳين ٽي ماهي",
		"past": "{0} ٽي ماهي پهرين",
		"future": "{0} ٽي ماهي ۾"
	],
	"month": [
		"previous": "پوئين مهيني",
		"current": "هن مهيني",
		"next": "اڳين مهيني",
		"past": "{0} مهينا پهرين",
		"future": "{0} مهينن ۾"
	],
	"week": [
		"previous": "پوئين هفتي",
		"current": "هن هفتي",
		"next": "اڳين هفتي",
		"past": "{0} هفتا پهرين",
		"future": "{0} هفتن ۾"
	],
	"day": [
		"previous": "ڪل",
		"current": "اڄ",
		"next": "سڀاڻي",
		"past": "{0} ڏينهن پهرين",
		"future": "{0} ڏينهن ۾"
	],
	"hour": [
		"current": "هن ڪلڪ",
		"past": "{0} ڪلاڪ پهرين",
		"future": "{0} ڪلاڪ ۾"
	],
	"minute": [
		"current": "هن منٽ",
		"past": "{0} منٽ پهرين",
		"future": "{0} منٽن ۾"
	],
	"second": [
		"current": "هاڻي",
		"past": "{0} سيڪنڊ پهرين",
		"future": "{0} سيڪنڊن ۾"
	],
	"now": "هاڻي"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "پويون سال",
		"current": "پويون سال",
		"next": "پويون سال",
		"past": "{0} سال پهرين",
		"future": "{0} سالن ۾"
	],
	"quarter": [
		"previous": "پوئين ٽي ماهي",
		"current": "هن ٽي ماهي",
		"next": "اڳين ٽي ماهي",
		"past": "{0} ٽي ماهي پهرين",
		"future": "{0} ٽي ماهي ۾"
	],
	"month": [
		"previous": "پوئين مهيني",
		"current": "هن مهيني",
		"next": "اڳين مهيني",
		"past": "{0} مهينا پهرين",
		"future": "{0} مهينن ۾"
	],
	"week": [
		"previous": "پوئين هفتي",
		"current": "هن هفتي",
		"next": "اڳين هفتي",
		"past": "{0} هفتا پهرين",
		"future": "{0} هفتن ۾"
	],
	"day": [
		"previous": "ڪل",
		"current": "اڄ",
		"next": "سڀاڻي",
		"past": "{0} ڏينهن پهرين",
		"future": "{0} ڏينهن ۾"
	],
	"hour": [
		"current": "هن ڪلڪ",
		"past": "{0} ڪلاڪ پهرين",
		"future": "{0} ڪلاڪ ۾"
	],
	"minute": [
		"current": "هن منٽ",
		"past": "{0} منٽ پهرين",
		"future": [
			"one": "{0} منٽن ۾",
			"other": "+{0} min"
		]
	],
	"second": [
		"current": "هاڻي",
		"past": "{0} سيڪنڊ پهرين",
		"future": "{0} سيڪنڊن ۾"
	],
	"now": "هاڻي"
]
	}
}
