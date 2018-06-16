import Foundation

// swiftlint:disable type_name
public class lang_to: RelativeFormatterLang {

	/// Tongan
	public static let identifier: String = "to"

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
		"previous": "taʻu kuoʻosi",
		"current": "taʻú ni",
		"next": "taʻu kahaʻu",
		"past": "taʻu ʻe {0} kuoʻosi",
		"future": "ʻi he taʻu ʻe {0}"
	],
	"quarter": [
		"previous": "kuata kuoʻosi",
		"current": "kuata koʻeni",
		"next": "kuata hoko",
		"past": "kuata ʻe {0} kuoʻosi",
		"future": "ʻi he kuata ʻe {0}"
	],
	"month": [
		"previous": "māhina kuoʻosi",
		"current": "māhiná ni",
		"next": "māhina kahaʻu",
		"past": "māhina ʻe {0} kuoʻosi",
		"future": "ʻi he māhina ʻe {0}"
	],
	"week": [
		"previous": "uike kuoʻosi",
		"current": "uiké ni",
		"next": "uike kahaʻu",
		"past": "uike ʻe {0} kuoʻosi",
		"future": "ʻi he uike ʻe {0}"
	],
	"day": [
		"previous": "ʻaneafi",
		"current": "ʻahó ni",
		"next": "ʻapongipongi",
		"past": "ʻaho ʻe {0} kuoʻosi",
		"future": "ʻi he ʻaho ʻe {0}"
	],
	"hour": [
		"current": "this hour",
		"past": "houa ʻe {0} kuoʻosi",
		"future": "ʻi he houa ʻe {0}"
	],
	"minute": [
		"current": "this minute",
		"past": "miniti ʻe {0} kuoʻosi",
		"future": "ʻi he miniti ʻe {0}"
	],
	"second": [
		"current": "taimí ni",
		"past": "sekoni ʻe {0} kuoʻosi",
		"future": "ʻi he sekoni ʻe {0}"
	],
	"now": "taimí ni"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "taʻu kuoʻosi",
		"current": "taʻú ni",
		"next": "taʻu kahaʻu",
		"past": "taʻu ʻe {0} kuoʻosi",
		"future": "ʻi he taʻu ʻe {0}"
	],
	"quarter": [
		"previous": "kuata kuoʻosi",
		"current": "kuata koʻeni",
		"next": "kuata hoko",
		"past": "kuata ʻe {0} kuoʻosi",
		"future": "ʻi he kuata ʻe {0}"
	],
	"month": [
		"previous": "māhina kuoʻosi",
		"current": "māhiná ni",
		"next": "māhina kahaʻu",
		"past": "māhina ʻe {0} kuoʻosi",
		"future": "ʻi he māhina ʻe {0}"
	],
	"week": [
		"previous": "uike kuoʻosi",
		"current": "uiké ni",
		"next": "uike kahaʻu",
		"past": "uike ʻe {0} kuoʻosi",
		"future": "ʻi he uike ʻe {0}"
	],
	"day": [
		"previous": "ʻaneafi",
		"current": "ʻahó ni",
		"next": "ʻapongipongi",
		"past": "ʻaho ʻe {0} kuoʻosi",
		"future": "ʻi he ʻaho ʻe {0}"
	],
	"hour": [
		"current": "this hour",
		"past": "houa ʻe {0} kuoʻosi",
		"future": "ʻi he houa ʻe {0}"
	],
	"minute": [
		"current": "this minute",
		"past": "miniti ʻe {0} kuoʻosi",
		"future": "ʻi he miniti ʻe {0}"
	],
	"second": [
		"current": "taimí ni",
		"past": "sekoni ʻe {0} kuoʻosi",
		"future": "ʻi he sekoni ʻe {0}"
	],
	"now": "taimí ni"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "taʻu kuoʻosi",
		"current": "taʻú ni",
		"next": "taʻu kahaʻu",
		"past": "taʻu ʻe {0} kuoʻosi",
		"future": "ʻi he taʻu ʻe {0}"
	],
	"quarter": [
		"previous": "kuata kuoʻosi",
		"current": "kuata koʻeni",
		"next": "kuata hoko",
		"past": "kuata ʻe {0} kuoʻosi",
		"future": "ʻi he kuata ʻe {0}"
	],
	"month": [
		"previous": "māhina kuoʻosi",
		"current": "māhiná ni",
		"next": "māhina kahaʻu",
		"past": "māhina ʻe {0} kuoʻosi",
		"future": "ʻi he māhina ʻe {0}"
	],
	"week": [
		"previous": "uike kuoʻosi",
		"current": "uiké ni",
		"next": "uike kahaʻu",
		"past": "uike ʻe {0} kuoʻosi",
		"future": "ʻi he uike ʻe {0}"
	],
	"day": [
		"previous": "ʻaneafi",
		"current": "ʻahó ni",
		"next": "ʻapongipongi",
		"past": "ʻaho ʻe {0} kuoʻosi",
		"future": "ʻi he ʻaho ʻe {0}"
	],
	"hour": [
		"current": "this hour",
		"past": "houa ʻe {0} kuoʻosi",
		"future": "ʻi he houa ʻe {0}"
	],
	"minute": [
		"current": "this minute",
		"past": "miniti ʻe {0} kuoʻosi",
		"future": "ʻi he miniti ʻe {0}"
	],
	"second": [
		"current": "taimí ni",
		"past": "sekoni ʻe {0} kuoʻosi",
		"future": "ʻi he sekoni ʻe {0}"
	],
	"now": "taimí ni"
]
	}
}
