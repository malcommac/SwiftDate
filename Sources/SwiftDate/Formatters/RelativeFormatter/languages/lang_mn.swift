import Foundation

// swiftlint:disable type_name
public class lang_mn: RelativeFormatterLang {

	/// Mongolian
	public static let identifier: String = "mn"

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
		"previous": "өнгөрсөн жил",
		"current": "энэ жил",
		"next": "ирэх жил",
		"past": "{0} жилийн өмнө",
		"future": "{0} жилийн дотор"
	],
	"quarter": [
		"previous": "өнгөрсөн улирал",
		"current": "энэ улирал",
		"next": "дараагийн улирал",
		"past": "{0} улирлын өмнө",
		"future": "{0} улиралд"
	],
	"month": [
		"previous": "өнгөрсөн сар",
		"current": "энэ сар",
		"next": "ирэх сар",
		"past": "{0} сарын өмнө",
		"future": "{0} сард"
	],
	"week": [
		"previous": "өнгөрсөн долоо хоног",
		"current": "энэ долоо хоног",
		"next": "ирэх долоо хоног",
		"past": "{0} 7 хоногийн өмнө",
		"future": "{0} 7 хоногт"
	],
	"day": [
		"previous": "өчигдөр",
		"current": "өнөөдөр",
		"next": "маргааш",
		"past": "{0} өдрийн өмнө",
		"future": "{0} өдөрт"
	],
	"hour": [
		"current": "энэ цаг",
		"past": "{0} ц. өмнө",
		"future": "{0} цагт"
	],
	"minute": [
		"current": "энэ минут",
		"past": "{0} мин. өмнө",
		"future": "{0} мин. дотор"
	],
	"second": [
		"current": "одоо",
		"past": "{0} сек. өмнө",
		"future": "{0} сек. дотор"
	],
	"now": "одоо"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "өнгөрсөн жил",
		"current": "энэ жил",
		"next": "ирэх жил",
		"past": "-{0} жил.н өмнө",
		"future": "+{0} жилд"
	],
	"quarter": [
		"previous": "өнгөрсөн улирал",
		"current": "энэ улирал",
		"next": "дараагийн улирал",
		"past": "{0} улирлын өмнө",
		"future": "{0} улиралд"
	],
	"month": [
		"previous": "өнгөрсөн сар",
		"current": "энэ сар",
		"next": "ирэх сар",
		"past": "{0} сарын өмнө",
		"future": "+{0} сард"
	],
	"week": [
		"previous": "өнгөрсөн долоо хоног",
		"current": "энэ долоо хоног",
		"next": "ирэх долоо хоног",
		"past": "{0} 7 хоногийн өмнө",
		"future": "{0} 7 хоногт"
	],
	"day": [
		"previous": "өчигдөр",
		"current": "өнөөдөр",
		"next": "маргааш",
		"past": "{0} өдрийн өмнө",
		"future": "{0} өдөрт"
	],
	"hour": [
		"current": "энэ цаг",
		"past": "{0} ц. өмнө",
		"future": "{0} цагт"
	],
	"minute": [
		"current": "энэ минут",
		"past": "{0} мин. өмнө",
		"future": "{0} мин. дотор"
	],
	"second": [
		"current": "одоо",
		"past": "{0} сек. өмнө",
		"future": "{0} сек. дотор"
	],
	"now": "одоо"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "өнгөрсөн жил",
		"current": "энэ жил",
		"next": "ирэх жил",
		"past": "{0} жилийн өмнө",
		"future": "{0} жилийн дотор"
	],
	"quarter": [
		"previous": "өнгөрсөн улирал",
		"current": "энэ улирал",
		"next": "дараагийн улирал",
		"past": "{0} улирлын өмнө",
		"future": "{0} улиралд"
	],
	"month": [
		"previous": "өнгөрсөн сар",
		"current": "энэ сар",
		"next": "ирэх сар",
		"past": "{0} сарын өмнө",
		"future": "{0} сард"
	],
	"week": [
		"previous": "өнгөрсөн долоо хоног",
		"current": "энэ долоо хоног",
		"next": "ирэх долоо хоног",
		"past": "{0} 7 хоногийн өмнө",
		"future": "{0} 7 хоногт"
	],
	"day": [
		"previous": "өчигдөр",
		"current": "өнөөдөр",
		"next": "маргааш",
		"past": "{0} өдрийн өмнө",
		"future": "{0} өдөрт"
	],
	"hour": [
		"current": "энэ цаг",
		"past": "{0} цагийн өмнө",
		"future": "{0} цагт"
	],
	"minute": [
		"current": "энэ минут",
		"past": "{0} минутын өмнө",
		"future": "{0} минутын дотор"
	],
	"second": [
		"current": "одоо",
		"past": "{0} секундын өмнө",
		"future": "{0} секундын дотор"
	],
	"now": "одоо"
]
	}
}
