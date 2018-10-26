import Foundation

// swiftlint:disable type_name
public class lang_ne: RelativeFormatterLang {

	/// Nepali
	public static let identifier: String = "ne"

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
		"previous": "गत वर्ष",
		"current": "यो वर्ष",
		"next": "आगामी वर्ष",
		"past": "{0} वर्ष अघि",
		"future": "{0} वर्षमा"
	],
	"quarter": [
		"previous": "अघिल्लो सत्र",
		"current": "यो सत्र",
		"next": "अर्को सत्र",
		"past": "{0}सत्र अघि",
		"future": "{0}सत्रमा"
	],
	"month": [
		"previous": "गत महिना",
		"current": "यो महिना",
		"next": "अर्को महिना",
		"past": "{0} महिना पहिले",
		"future": "{0} महिनामा"
	],
	"week": [
		"previous": "गत हप्ता",
		"current": "यो हप्ता",
		"next": "आउने हप्ता",
		"past": "{0} हप्ता पहिले",
		"future": "{0} हप्तामा"
	],
	"day": [
		"previous": "हिजो",
		"current": "आज",
		"next": "भोलि",
		"past": "{0} दिन पहिले",
		"future": "{0} दिनमा"
	],
	"hour": [
		"current": "यस घडीमा",
		"past": "{0} घण्टा पहिले",
		"future": "{0} घण्टामा"
	],
	"minute": [
		"current": "यही मिनेटमा",
		"past": "{0} मिनेट पहिले",
		"future": "{0} मिनेटमा"
	],
	"second": [
		"current": "अहिले",
		"past": "{0} सेकेन्ड पहिले",
		"future": "{0} सेकेन्डमा"
	],
	"now": "अहिले"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "गत वर्ष",
		"current": "यो वर्ष",
		"next": "आगामी वर्ष",
		"past": "{0} वर्ष अघि",
		"future": "{0} वर्षमा"
	],
	"quarter": [
		"previous": "अघिल्लो सत्र",
		"current": "यो सत्र",
		"next": "अर्को सत्र",
		"past": "{0}सत्र अघि",
		"future": "{0}सत्रमा"
	],
	"month": [
		"previous": "गत महिना",
		"current": "यो महिना",
		"next": "अर्को महिना",
		"past": "{0} महिना पहिले",
		"future": "{0} महिनामा"
	],
	"week": [
		"previous": "गत हप्ता",
		"current": "यो हप्ता",
		"next": "आउने हप्ता",
		"past": "{0} हप्ता पहिले",
		"future": "{0} हप्तामा"
	],
	"day": [
		"previous": "हिजो",
		"current": "आज",
		"next": "भोलि",
		"past": "{0} दिन पहिले",
		"future": "{0} दिनमा"
	],
	"hour": [
		"current": "यस घडीमा",
		"past": "{0} घण्टा पहिले",
		"future": "{0} घण्टामा"
	],
	"minute": [
		"current": "यही मिनेटमा",
		"past": "{0} मिनेट पहिले",
		"future": "{0} मिनेटमा"
	],
	"second": [
		"current": "अहिले",
		"past": "{0} सेकेन्ड पहिले",
		"future": "{0} सेकेन्डमा"
	],
	"now": "अहिले"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "गत वर्ष",
		"current": "यो वर्ष",
		"next": "आगामी वर्ष",
		"past": "{0} वर्ष अघि",
		"future": "{0} वर्षमा"
	],
	"quarter": [
		"previous": "अघिल्लो सत्र",
		"current": "यो सत्र",
		"next": "अर्को सत्र",
		"past": "{0}सत्र अघि",
		"future": [
			"one": "+{0} सत्रमा",
			"other": "{0}सत्रमा"
		]
	],
	"month": [
		"previous": "गत महिना",
		"current": "यो महिना",
		"next": "अर्को महिना",
		"past": "{0} महिना पहिले",
		"future": "{0} महिनामा"
	],
	"week": [
		"previous": "गत हप्ता",
		"current": "यो हप्ता",
		"next": "आउने हप्ता",
		"past": "{0} हप्ता पहिले",
		"future": "{0} हप्तामा"
	],
	"day": [
		"previous": "हिजो",
		"current": "आज",
		"next": "भोलि",
		"past": "{0} दिन पहिले",
		"future": "{0} दिनमा"
	],
	"hour": [
		"current": "यस घडीमा",
		"past": "{0} घण्टा पहिले",
		"future": "{0} घण्टामा"
	],
	"minute": [
		"current": "यही मिनेटमा",
		"past": "{0} मिनेट पहिले",
		"future": "{0} मिनेटमा"
	],
	"second": [
		"current": "अहिले",
		"past": "{0} सेकेन्ड पहिले",
		"future": "{0} सेकेन्डमा"
	],
	"now": "अहिले"
]
	}
}
