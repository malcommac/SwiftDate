import Foundation

// swiftlint:disable type_name
public class lang_sah: RelativeFormatterLang {

	/// Sakha
	public static let identifier: String = "sah"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return .other
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
		"previous": "Былырыын",
		"current": "быйыл",
		"next": "эһиил",
		"past": "{0} сыл ынараа өттүгэр",
		"future": "{0} сылынан"
	],
	"quarter": [
		"previous": "ааспыт кыбаартал",
		"current": "бу кыбаартал",
		"next": "кэлэр кыбаартал",
		"past": "{0} кыб. анараа өттүгэр",
		"future": "{0} кыбаарталынан"
	],
	"month": [
		"previous": "ааспыт ый",
		"current": "бу ый",
		"next": "аныгыскы ый",
		"past": "{0} ый ынараа өттүгэр",
		"future": "{0} ыйынан"
	],
	"week": [
		"previous": "ааспыт нэдиэлэ",
		"current": "бу нэдиэлэ",
		"next": "кэлэр нэдиэлэ",
		"past": "{0} нэдиэлэ анараа өттүгэр",
		"future": "{0} нэдиэлэннэн"
	],
	"day": [
		"previous": "Бэҕэһээ",
		"current": "Бүгүн",
		"next": "Сарсын",
		"past": "{0} күн ынараа өттүгэр",
		"future": "{0} күнүнэн"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} чаас ынараа өттүгэр",
		"future": "{0} чааһынан"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} мүнүүтэ ынараа өттүгэр",
		"future": "{0} мүнүүтэннэн"
	],
	"second": [
		"current": "билигин",
		"past": "{0} сөк. анараа өттүгэр",
		"future": "{0} сөкүүндэннэн"
	],
	"now": "билигин"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "Былырыын",
		"current": "быйыл",
		"next": "эһиил",
		"past": "{0} сыл ынараа өттүгэр",
		"future": "{0} сылынан"
	],
	"quarter": [
		"previous": "ааспыт кыбаартал",
		"current": "бу кыбаартал",
		"next": "кэлэр кыбаартал",
		"past": "{0} кыб. анараа өттүгэр",
		"future": "{0} кыбаарталынан"
	],
	"month": [
		"previous": "ааспыт ый",
		"current": "бу ый",
		"next": "аныгыскы ый",
		"past": "{0} ый ынараа өттүгэр",
		"future": "{0} ыйынан"
	],
	"week": [
		"previous": "ааспыт нэдиэлэ",
		"current": "бу нэдиэлэ",
		"next": "кэлэр нэдиэлэ",
		"past": "{0} нэдиэлэ анараа өттүгэр",
		"future": "{0} нэдиэлэннэн"
	],
	"day": [
		"previous": "Бэҕэһээ",
		"current": "Бүгүн",
		"next": "Сарсын",
		"past": "{0} күн ынараа өттүгэр",
		"future": "{0} күнүнэн"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} чаас ынараа өттүгэр",
		"future": "{0} чааһынан"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} мүнүүтэ ынараа өттүгэр",
		"future": "{0} мүнүүтэннэн"
	],
	"second": [
		"current": "билигин",
		"past": "{0} сөк. анараа өттүгэр",
		"future": "{0} сөкүүндэннэн"
	],
	"now": "билигин"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "Былырыын",
		"current": "быйыл",
		"next": "эһиил",
		"past": "{0} сыл ынараа өттүгэр",
		"future": "{0} сылынан"
	],
	"quarter": [
		"previous": "ааспыт кыбаартал",
		"current": "бу кыбаартал",
		"next": "кэлэр кыбаартал",
		"past": "{0} кыбаартал анараа өттүгэр",
		"future": "{0} кыбаарталынан"
	],
	"month": [
		"previous": "ааспыт ый",
		"current": "бу ый",
		"next": "аныгыскы ый",
		"past": "{0} ый ынараа өттүгэр",
		"future": "{0} ыйынан"
	],
	"week": [
		"previous": "ааспыт нэдиэлэ",
		"current": "бу нэдиэлэ",
		"next": "кэлэр нэдиэлэ",
		"past": "{0} нэдиэлэ анараа өттүгэр",
		"future": "{0} нэдиэлэннэн"
	],
	"day": [
		"previous": "Бэҕэһээ",
		"current": "Бүгүн",
		"next": "Сарсын",
		"past": "{0} күн ынараа өттүгэр",
		"future": "{0} күнүнэн"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} чаас ынараа өттүгэр",
		"future": "{0} чааһынан"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} мүнүүтэ ынараа өттүгэр",
		"future": "{0} мүнүүтэннэн"
	],
	"second": [
		"current": "билигин",
		"past": "{0} сөкүүндэ ынараа өттүгэр",
		"future": "{0} сөкүүндэннэн"
	],
	"now": "билигин"
]
	}
}
