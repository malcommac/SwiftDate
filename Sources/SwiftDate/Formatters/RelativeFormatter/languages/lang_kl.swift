import Foundation

// swiftlint:disable type_name
public class lang_kl: RelativeFormatterLang {

	/// Kalaallisut
	public static let identifier: String = "kl"

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
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": "for {0} ukioq siden",
		"future": "om {0} ukioq"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "for {0} qaammat siden",
		"future": "om {0} qaammat"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "for {0} sapaatip-akunnera siden",
		"future": "om {0} sapaatip-akunnera"
	],
	"day": [
		"previous": "yesterday",
		"current": "today",
		"next": "tomorrow",
		"past": "for {0} ulloq unnuarlu siden",
		"future": "om {0} ulloq unnuarlu"
	],
	"hour": [
		"current": "this hour",
		"past": "for {0} nalunaaquttap-akunnera siden",
		"future": "om {0} nalunaaquttap-akunnera"
	],
	"minute": [
		"current": "this minute",
		"past": "for {0} minutsi siden",
		"future": "om {0} minutsi"
	],
	"second": [
		"current": "now",
		"past": "for {0} sekundi siden",
		"future": "om {0} sekundi"
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": "for {0} ukioq siden",
		"future": "om {0} ukioq"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "for {0} qaammat siden",
		"future": "om {0} qaammat"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "for {0} sapaatip-akunnera siden",
		"future": "om {0} sapaatip-akunnera"
	],
	"day": [
		"previous": "yesterday",
		"current": "today",
		"next": "tomorrow",
		"past": "for {0} ulloq unnuarlu siden",
		"future": "om {0} ulloq unnuarlu"
	],
	"hour": [
		"current": "this hour",
		"past": "for {0} nalunaaquttap-akunnera siden",
		"future": "om {0} nalunaaquttap-akunnera"
	],
	"minute": [
		"current": "this minute",
		"past": "for {0} minutsi siden",
		"future": "om {0} minutsi"
	],
	"second": [
		"current": "now",
		"past": "for {0} sekundi siden",
		"future": "om {0} sekundi"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": "for {0} ukioq siden",
		"future": "om {0} ukioq"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "for {0} qaammat siden",
		"future": "om {0} qaammat"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "for {0} sapaatip-akunnera siden",
		"future": "om {0} sapaatip-akunnera"
	],
	"day": [
		"previous": "yesterday",
		"current": "today",
		"next": "tomorrow",
		"past": "for {0} ulloq unnuarlu siden",
		"future": "om {0} ulloq unnuarlu"
	],
	"hour": [
		"current": "this hour",
		"past": "for {0} nalunaaquttap-akunnera siden",
		"future": "om {0} nalunaaquttap-akunnera"
	],
	"minute": [
		"current": "this minute",
		"past": "for {0} minutsi siden",
		"future": "om {0} minutsi"
	],
	"second": [
		"current": "now",
		"past": "for {0} sekundi siden",
		"future": "om {0} sekundi"
	],
	"now": "now"
]
	}
}
