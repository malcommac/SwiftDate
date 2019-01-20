import Foundation

// swiftlint:disable type_name
public class lang_kea: RelativeFormatterLang {

	/// Kabuverdianu
	public static let identifier: String = "kea"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return nil
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
		"previous": "anu pasadu",
		"current": "es anu li",
		"next": "prósimu anu",
		"past": "a ten {0} anu",
		"future": "di li {0} anu"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "a ten {0} trim.",
		"future": "di li {0} trim."
	],
	"month": [
		"previous": "mes pasadu",
		"current": "es mes li",
		"next": "prósimu mes",
		"past": "a ten {0} mes",
		"future": "di li {0} mes"
	],
	"week": [
		"previous": "simana pasadu",
		"current": "es simana li",
		"next": "prósimu simana",
		"past": "a ten {0} sim.",
		"future": "di li {0} sim."
	],
	"day": [
		"previous": "onti",
		"current": "oji",
		"next": "manha",
		"past": "a ten {0} dia",
		"future": "di li {0} dia"
	],
	"hour": [
		"current": "this hour",
		"past": "a ten {0} ora",
		"future": "di li {0} ora"
	],
	"minute": [
		"current": "this minute",
		"past": "a ten {0} min",
		"future": "di li {0} min"
	],
	"second": [
		"current": "now",
		"past": "a ten {0} sig",
		"future": "di li {0} sig"
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "anu pasadu",
		"current": "es anu li",
		"next": "prósimu anu",
		"past": "a ten {0} anu",
		"future": "di li {0} anu"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "a ten {0} trim.",
		"future": "di li {0} trim."
	],
	"month": [
		"previous": "mes pasadu",
		"current": "es mes li",
		"next": "prósimu mes",
		"past": "a ten {0} mes",
		"future": "di li {0} mes"
	],
	"week": [
		"previous": "simana pasadu",
		"current": "es simana li",
		"next": "prósimu simana",
		"past": "a ten {0} sim.",
		"future": "di li {0} sim."
	],
	"day": [
		"previous": "onti",
		"current": "oji",
		"next": "manha",
		"past": "a ten {0} dia",
		"future": "di li {0} dia"
	],
	"hour": [
		"current": "this hour",
		"past": "a ten {0} ora",
		"future": "di li {0} ora"
	],
	"minute": [
		"current": "this minute",
		"past": "a ten {0} m",
		"future": "di li {0} m"
	],
	"second": [
		"current": "now",
		"past": "a ten {0} s",
		"future": "di li {0} s"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "anu pasadu",
		"current": "es anu li",
		"next": "prósimu anu",
		"past": "a ten {0} anu",
		"future": "di li {0} anu"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "a ten {0} trimestri",
		"future": "di li {0} trimestri"
	],
	"month": [
		"previous": "mes pasadu",
		"current": "es mes li",
		"next": "prósimu mes",
		"past": "a ten {0} mes",
		"future": "di li {0} mes"
	],
	"week": [
		"previous": "simana pasadu",
		"current": "es simana li",
		"next": "prósimu simana",
		"past": "a ten {0} simana",
		"future": "di li {0} simana"
	],
	"day": [
		"previous": "onti",
		"current": "oji",
		"next": "manha",
		"past": "a ten {0} dia",
		"future": "di li {0} dia"
	],
	"hour": [
		"current": "this hour",
		"past": "a ten {0} ora",
		"future": "di li {0} ora"
	],
	"minute": [
		"current": "this minute",
		"past": "a ten {0} minutu",
		"future": "di li {0} minutu"
	],
	"second": [
		"current": "now",
		"past": "a ten {0} sigundu",
		"future": "di li {0} sigundu"
	],
	"now": "now"
]
	}
}
