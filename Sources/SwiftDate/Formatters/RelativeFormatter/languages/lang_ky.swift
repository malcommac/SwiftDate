import Foundation

// swiftlint:disable type_name
public class lang_ky: RelativeFormatterLang {

	/// Kyrgyz
	public static let identifier: String = "ky"

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
		"previous": "былтыр",
		"current": "быйыл",
		"next": "эмдиги жылы",
		"past": "{0} жыл мурун",
		"future": "{0} жыл. кийин"
	],
	"quarter": [
		"previous": "акыркы чейр.",
		"current": "бул чейр.",
		"next": "кийинки чейр.",
		"past": "{0} чейр. мурун",
		"future": "{0} чейректен кийин"
	],
	"month": [
		"previous": "өткөн айда",
		"current": "бул айда",
		"next": "эмдиги айда",
		"past": "{0} ай мурун",
		"future": "{0} айд. кийин"
	],
	"week": [
		"previous": "өткөн апт.",
		"current": "ушул апт.",
		"next": "келерки апт.",
		"past": "{0} апт. мурун",
		"future": "{0} апт. кийин"
	],
	"day": [
		"previous": "кечээ",
		"current": "бүгүн",
		"next": "эртеӊ",
		"past": "{0} күн мурун",
		"future": "{0} күн. кийин"
	],
	"hour": [
		"current": "ушул саатта",
		"past": "{0} саат. мурун",
		"future": "{0} саат. кийин"
	],
	"minute": [
		"current": "ушул мүнөттө",
		"past": "{0} мүн. мурун",
		"future": "{0} мүн. кийин"
	],
	"second": [
		"current": "азыр",
		"past": "{0} сек. мурун",
		"future": "{0} сек. кийин"
	],
	"now": "азыр"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "былтыр",
		"current": "быйыл",
		"next": "эмдиги жылы",
		"past": "{0} жыл мурун",
		"future": "{0} жыл. кийин"
	],
	"quarter": [
		"previous": "акыркы чейр.",
		"current": "бул чейр.",
		"next": "кийинки чейр.",
		"past": "{0} чейр. мурун",
		"future": "{0} чейр. кийин"
	],
	"month": [
		"previous": "өткөн айда",
		"current": "бул айда",
		"next": "эмдиги айда",
		"past": "{0} ай мурн",
		"future": "{0} айд. кийн"
	],
	"week": [
		"previous": "өткөн апт.",
		"current": "ушул апт.",
		"next": "келерки апт.",
		"past": "{0} апт. мурун",
		"future": "{0} апт. кийин"
	],
	"day": [
		"previous": "кечээ",
		"current": "бүгүн",
		"next": "эртеӊ",
		"past": "{0} күн мурун",
		"future": "{0} күн. кийин"
	],
	"hour": [
		"current": "ушул саатта",
		"past": "{0} с. мурн",
		"future": "{0} с. кийн"
	],
	"minute": [
		"current": "ушул мүнөттө",
		"past": "{0} мүн. мурн",
		"future": "{0} мүн. кийн"
	],
	"second": [
		"current": "азыр",
		"past": "{0} сек. мурн",
		"future": "{0} сек. кийн"
	],
	"now": "азыр"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "былтыр",
		"current": "быйыл",
		"next": "эмдиги жылы",
		"past": "{0} жыл мурун",
		"future": "{0} жылдан кийин"
	],
	"quarter": [
		"previous": "акыркы чейрек",
		"current": "бул чейрек",
		"next": "кийинки чейрек",
		"past": "{0} чейрек мурун",
		"future": "{0} чейректен кийин"
	],
	"month": [
		"previous": "өткөн айда",
		"current": "бул айда",
		"next": "эмдиги айда",
		"past": "{0} ай мурун",
		"future": "{0} айдан кийин"
	],
	"week": [
		"previous": "өткөн аптада",
		"current": "ушул аптада",
		"next": "келерки аптада",
		"past": "{0} апта мурун",
		"future": "{0} аптадан кийин"
	],
	"day": [
		"previous": "кечээ",
		"current": "бүгүн",
		"next": "эртеӊ",
		"past": "{0} күн мурун",
		"future": "{0} күндөн кийин"
	],
	"hour": [
		"current": "ушул саатта",
		"past": "{0} саат мурун",
		"future": "{0} сааттан кийин"
	],
	"minute": [
		"current": "ушул мүнөттө",
		"past": "{0} мүнөт мурун",
		"future": "{0} мүнөттөн кийин"
	],
	"second": [
		"current": "азыр",
		"past": "{0} секунд мурун",
		"future": "{0} секунддан кийин"
	],
	"now": "азыр"
]
	}
}
