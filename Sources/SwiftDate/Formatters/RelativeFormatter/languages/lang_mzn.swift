import Foundation

// swiftlint:disable type_name
public class lang_mzn: RelativeFormatterLang {

	/// Mazanderani
	public static let identifier: String = "mzn"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return .other
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
		"previous": "پارسال",
		"current": "امسال",
		"next": "سال دیگه",
		"past": "{0} سال پیش",
		"future": "{0} سال دله"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "{0} ربع پیش",
		"future": "{0} ربع دله"
	],
	"month": [
		"previous": "ماه قبل",
		"current": "این ماه",
		"next": "ماه ِبعد",
		"past": "{0} ماه پیش",
		"future": "{0} ماه دله"
	],
	"week": [
		"previous": "قبلی هفته",
		"current": "این هفته",
		"next": "بعدی هفته",
		"past": "{0} هفته پیش",
		"future": "{0} هفته دله"
	],
	"day": [
		"previous": "دیروز",
		"current": "اَمروز",
		"next": "فِردا",
		"past": "{0} روز پیش",
		"future": "{0} روز دله"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} ساعت پیش",
		"future": "{0} ساعت دله"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} دَقه پیش",
		"future": "{0} دَقه دله"
	],
	"second": [
		"current": "now",
		"past": "{0} ثانیه پیش",
		"future": "{0} ثانیه دله"
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "پارسال",
		"current": "امسال",
		"next": "سال دیگه",
		"past": "{0} سال پیش",
		"future": "{0} سال دله"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "{0} ربع پیش",
		"future": "{0} ربع دله"
	],
	"month": [
		"previous": "ماه قبل",
		"current": "این ماه",
		"next": "ماه ِبعد",
		"past": "{0} ماه پیش",
		"future": "{0} ماه دله"
	],
	"week": [
		"previous": "قبلی هفته",
		"current": "این هفته",
		"next": "بعدی هفته",
		"past": "{0} هفته پیش",
		"future": "{0} هفته دله"
	],
	"day": [
		"previous": "دیروز",
		"current": "اَمروز",
		"next": "فِردا",
		"past": "{0} روز پیش",
		"future": "{0} روز دله"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} ساعت پیش",
		"future": "{0} ساعت دله"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} دَقه پیش",
		"future": "{0} دَقه دله"
	],
	"second": [
		"current": "now",
		"past": "{0} ثانیه پیش",
		"future": "{0} ثانیه دله"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "پارسال",
		"current": "امسال",
		"next": "سال دیگه",
		"past": "{0} سال پیش",
		"future": "{0} سال دله"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "{0} ربع پیش",
		"future": "{0} ربع دله"
	],
	"month": [
		"previous": "ماه قبل",
		"current": "این ماه",
		"next": "ماه ِبعد",
		"past": "{0} ماه پیش",
		"future": "{0} ماه دله"
	],
	"week": [
		"previous": "قبلی هفته",
		"current": "این هفته",
		"next": "بعدی هفته",
		"past": "{0} هفته پیش",
		"future": "{0} هفته دله"
	],
	"day": [
		"previous": "دیروز",
		"current": "اَمروز",
		"next": "فِردا",
		"past": "{0} روز پیش",
		"future": "{0} روز دله"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} ساعِت پیش",
		"future": "{0} ساعِت دله"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} دَقه پیش",
		"future": "{0} دقیقه دله"
	],
	"second": [
		"current": "now",
		"past": "{0} ثانیه پیش",
		"future": "{0} ثانیه دله"
	],
	"now": "now"
]
	}
}
