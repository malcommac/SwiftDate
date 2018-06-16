import Foundation

// swiftlint:disable type_name
public class lang_kk: RelativeFormatterLang {

	/// Kazakh
	public static let identifier: String = "kk"

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
		"previous": "былтырғы жыл",
		"current": "биылғы жыл",
		"next": "келесі жыл",
		"past": "{0} ж. бұрын",
		"future": "{0} ж. кейін"
	],
	"quarter": [
		"previous": "өткен тоқсан",
		"current": "осы тоқсан",
		"next": "келесі тоқсан",
		"past": "{0} тқс. бұрын",
		"future": "{0} тқс. кейін"
	],
	"month": [
		"previous": "өткен ай",
		"current": "осы ай",
		"next": "келесі ай",
		"past": "{0} ай бұрын",
		"future": "{0} айдан кейін"
	],
	"week": [
		"previous": "өткен апта",
		"current": "осы апта",
		"next": "келесі апта",
		"past": "{0} ап. бұрын",
		"future": "{0} ап. кейін"
	],
	"day": [
		"previous": "кеше",
		"current": "бүгін",
		"next": "ертең",
		"past": "{0} күн бұрын",
		"future": "{0} күннен кейін"
	],
	"hour": [
		"current": "осы сағат",
		"past": "{0} сағ. бұрын",
		"future": "{0} сағ. кейін"
	],
	"minute": [
		"current": "осы минут",
		"past": "{0} мин. бұрын",
		"future": "{0} мин. кейін"
	],
	"second": [
		"current": "қазір",
		"past": "{0} сек. бұрын",
		"future": "{0} сек. кейін"
	],
	"now": "қазір"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "былтырғы жыл",
		"current": "биылғы жыл",
		"next": "келесі жыл",
		"past": "{0} ж. бұрын",
		"future": "{0} ж. кейін"
	],
	"quarter": [
		"previous": "өткен тоқсан",
		"current": "осы тоқсан",
		"next": "келесі тоқсан",
		"past": "{0} тқс. бұрын",
		"future": "{0} тқс. кейін"
	],
	"month": [
		"previous": "өткен ай",
		"current": "осы ай",
		"next": "келесі ай",
		"past": "{0} ай бұрын",
		"future": "{0} айдан кейін"
	],
	"week": [
		"previous": "өткен апта",
		"current": "осы апта",
		"next": "келесі апта",
		"past": "{0} ап. бұрын",
		"future": "{0} ап. кейін"
	],
	"day": [
		"previous": "кеше",
		"current": "бүгін",
		"next": "ертең",
		"past": "{0} күн бұрын",
		"future": "{0} күннен кейін"
	],
	"hour": [
		"current": "осы сағат",
		"past": "{0} сағ. бұрын",
		"future": "{0} сағ. кейін"
	],
	"minute": [
		"current": "осы минут",
		"past": "{0} мин. бұрын",
		"future": "{0} мин. кейін"
	],
	"second": [
		"current": "қазір",
		"past": "{0} сек. бұрын",
		"future": "{0} сек. кейін"
	],
	"now": "қазір"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "былтырғы жыл",
		"current": "биылғы жыл",
		"next": "келесі жыл",
		"past": "{0} жыл бұрын",
		"future": "{0} жылдан кейін"
	],
	"quarter": [
		"previous": "өткен тоқсан",
		"current": "осы тоқсан",
		"next": "келесі тоқсан",
		"past": "{0} тоқсан бұрын",
		"future": "{0} тоқсаннан кейін"
	],
	"month": [
		"previous": "өткен ай",
		"current": "осы ай",
		"next": "келесі ай",
		"past": "{0} ай бұрын",
		"future": "{0} айдан кейін"
	],
	"week": [
		"previous": "өткен апта",
		"current": "осы апта",
		"next": "келесі апта",
		"past": "{0} апта бұрын",
		"future": "{0} аптадан кейін"
	],
	"day": [
		"previous": "кеше",
		"current": "бүгін",
		"next": "ертең",
		"past": "{0} күн бұрын",
		"future": "{0} күннен кейін"
	],
	"hour": [
		"current": "осы сағат",
		"past": "{0} сағат бұрын",
		"future": "{0} сағаттан кейін"
	],
	"minute": [
		"current": "осы минут",
		"past": "{0} минут бұрын",
		"future": "{0} минуттан кейін"
	],
	"second": [
		"current": "қазір",
		"past": "{0} секунд бұрын",
		"future": "{0} секундтан кейін"
	],
	"now": "қазір"
]
	}
}
