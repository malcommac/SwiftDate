import Foundation

// swiftlint:disable type_name
public class lang_ru: RelativeFormatterLang {

	/// Russian
	public static let identifier: String = "ru"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		let mod100 = Int(value) % 100

		switch mod100 {
		case 11...14:
			break

		default:
			switch mod10 {
			case 1:
				return .one
			case 2...4:
				return .few
			default:
				break
			}

		}

		return .many
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
		"previous": "в прошлом г.",
		"current": "в этом г.",
		"next": "в след. г.",
		"past": [
			"many": "{0} л. назад",
			"other": "{0} г. назад"
		],
		"future": [
			"many": "через {0} л.",
			"other": "через {0} г."
		]
	],
	"quarter": [
		"previous": "последний кв.",
		"current": "текущий кв.",
		"next": "следующий кв.",
		"past": "{0} кв. назад",
		"future": "через {0} кв."
	],
	"month": [
		"previous": "в прошлом мес.",
		"current": "в этом мес.",
		"next": "в следующем мес.",
		"past": "{0} мес. назад",
		"future": "через {0} мес."
	],
	"week": [
		"previous": "на прошлой нед.",
		"current": "на этой нед.",
		"next": "на следующей нед.",
		"past": "{0} нед. назад",
		"future": "через {0} нед."
	],
	"day": [
		"previous": "вчера",
		"current": "сегодня",
		"next": "завтра",
		"past": "{0} дн. назад",
		"future": "через {0} дн."
	],
	"hour": [
		"current": "в этот час",
		"past": [
			"one": "{0} ч. назад",
			"other": "{0} ч. назад"
		],
		"future": [
			"one": "через {0} ч.",
			"other": "через {0} ч."
		]
	],
	"minute": [
		"current": "в эту минуту",
		"past": "{0} мин. назад",
		"future": "через {0} мин."
	],
	"second": [
		"current": "сейчас",
		"past": "{0} сек. назад",
		"future": "через {0} сек."
	],
	"now": "сейчас"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "в пр. г.",
		"current": "в эт. г.",
		"next": "в сл. г.",
		"past": [
			"many": "-{0} л.",
			"other": "-{0} г."
		],
		"future": [
			"many": "+{0} л.",
			"other": "+{0} г."
		]
	],
	"quarter": [
		"previous": "посл. кв.",
		"current": "тек. кв.",
		"next": "след. кв.",
		"past": "-{0} кв.",
		"future": "+{0} кв."
	],
	"month": [
		"previous": "в пр. мес.",
		"current": "в эт. мес.",
		"next": "в след. мес.",
		"past": "-{0} мес.",
		"future": "+{0} мес."
	],
	"week": [
		"previous": "на пр. нед.",
		"current": "на эт. нед.",
		"next": "на след. неделе",
		"past": "-{0} нед.",
		"future": "+{0} нед."
	],
	"day": [
		"previous": "вчера",
		"current": "сегодня",
		"next": "завтра",
		"past": "-{0} дн.",
		"future": "+{0} дн."
	],
	"hour": [
		"current": "в этот час",
		"past": "-{0} ч.",
		"future": "+{0} ч."
	],
	"minute": [
		"current": "в эту минуту",
		"past": "-{0} мин.",
		"future": "+{0} мин."
	],
	"second": [
		"current": "сейчас",
		"past": "-{0} с",
		"future": "+{0} с"
	],
	"now": "сейчас"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "в прошлом году",
		"current": "в этом году",
		"next": "в следующем году",
		"past": [
			"one": "{0} год назад",
			"many": "{0} лет назад",
			"other": "{0} года назад"
		],
		"future": [
			"one": "через {0} год",
			"many": "через {0} лет",
			"other": "через {0} года"
		]
	],
	"quarter": [
		"previous": "в прошлом квартале",
		"current": "в текущем квартале",
		"next": "в следующем квартале",
		"past": [
			"one": "{0} квартал назад",
			"many": "{0} кварталов назад",
			"other": "{0} квартала назад"
		],
		"future": [
			"one": "через {0} квартал",
			"many": "через {0} кварталов",
			"other": "через {0} квартала"
		]
	],
	"month": [
		"previous": "в прошлом месяце",
		"current": "в этом месяце",
		"next": "в следующем месяце",
		"past": [
			"one": "{0} месяц назад",
			"many": "{0} месяцев назад",
			"other": "{0} месяца назад"
		],
		"future": [
			"one": "через {0} месяц",
			"many": "через {0} месяцев",
			"other": "через {0} месяца"
		]
	],
	"week": [
		"previous": "на прошлой неделе",
		"current": "на этой неделе",
		"next": "на следующей неделе",
		"past": [
			"one": "{0} неделю назад",
			"many": "{0} недель назад",
			"other": "{0} недели назад"
		],
		"future": [
			"one": "через {0} неделю",
			"many": "через {0} недель",
			"other": "через {0} недели"
		]
	],
	"day": [
		"previous": "вчера",
		"current": "сегодня",
		"next": "завтра",
		"past": [
			"one": "{0} день назад",
			"many": "{0} дней назад",
			"other": "{0} дня назад"
		],
		"future": [
			"one": "через {0} день",
			"many": "через {0} дней",
			"other": "через {0} дня"
		]
	],
	"hour": [
		"current": "в этот час",
		"past": [
			"one": "{0} час назад",
			"many": "{0} часов назад",
			"other": "{0} часа назад"
		],
		"future": [
			"one": "через {0} час",
			"many": "через {0} часов",
			"other": "через {0} часа"
		]
	],
	"minute": [
		"current": "в эту минуту",
		"past": [
			"one": "{0} минуту назад",
			"many": "{0} минут назад",
			"other": "{0} минуты назад"
		],
		"future": [
			"one": "через {0} минуту",
			"many": "через {0} минут",
			"other": "через {0} минуты"
		]
	],
	"second": [
		"current": "сейчас",
		"past": [
			"one": "{0} секунду назад",
			"many": "{0} секунд назад",
			"other": "{0} секунды назад"
		],
		"future": [
			"one": "через {0} секунду",
			"many": "через {0} секунд",
			"other": "через {0} секунды"
		]
	],
	"now": "сейчас"
]
	}
}
