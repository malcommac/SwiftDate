import Foundation

// swiftlint:disable type_name
public class lang_uk: RelativeFormatterLang {

	/// Ukrainian
	public static let identifier: String = "uk"

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
			RelativeFormatter.Flavour.long.rawValue: self._long,
			RelativeFormatter.Flavour.narrow.rawValue: self._narrow,
			RelativeFormatter.Flavour.short.rawValue: self._short
		]
	}

	private var _short: [String: Any] {
		return [
	"year": [
		"previous": "торік",
		"current": "цього року",
		"next": "наступного року",
		"past": "{0} р. тому",
		"future": "через {0} р."
	],
	"quarter": [
		"previous": "минулого кв.",
		"current": "цього кв.",
		"next": "наступного кв.",
		"past": "{0} кв. тому",
		"future": "через {0} кв."
	],
	"month": [
		"previous": "минулого місяця",
		"current": "цього місяця",
		"next": "наступного місяця",
		"past": "{0} міс. тому",
		"future": "через {0} міс."
	],
	"week": [
		"previous": "минулого тижня",
		"current": "цього тижня",
		"next": "наступного тижня",
		"past": "{0} тиж. тому",
		"future": "через {0} тиж."
	],
	"day": [
		"previous": "учора",
		"current": "сьогодні",
		"next": "завтра",
		"past": "{0} дн. тому",
		"future": "через {0} дн."
	],
	"hour": [
		"current": "цієї години",
		"past": "{0} год тому",
		"future": "через {0} год"
	],
	"minute": [
		"current": "цієї хвилини",
		"past": "{0} хв тому",
		"future": "через {0} хв"
	],
	"second": [
		"current": "зараз",
		"past": "{0} с тому",
		"future": "через {0} с"
	],
	"now": "зараз"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "торік",
		"current": "цього року",
		"next": "наступного року",
		"past": "{0} р. тому",
		"future": "за {0} р."
	],
	"quarter": [
		"previous": "минулого кв.",
		"current": "цього кв.",
		"next": "наступного кв.",
		"past": "{0} кв. тому",
		"future": "за {0} кв."
	],
	"month": [
		"previous": "минулого місяця",
		"current": "цього місяця",
		"next": "наступного місяця",
		"past": "{0} міс. тому",
		"future": "за {0} міс."
	],
	"week": [
		"previous": "минулого тижня",
		"current": "цього тижня",
		"next": "наступного тижня",
		"past": "{0} тиж. тому",
		"future": "за {0} тиж."
	],
	"day": [
		"previous": "учора",
		"current": "сьогодні",
		"next": "завтра",
		"past": [
			"one": "{0} д. тому",
			"other": "-{0} дн."
		],
		"future": "за {0} д."
	],
	"hour": [
		"current": "цієї години",
		"past": "{0} год тому",
		"future": "за {0} год"
	],
	"minute": [
		"current": "цієї хвилини",
		"past": "{0} хв тому",
		"future": "за {0} хв"
	],
	"second": [
		"current": "зараз",
		"past": "{0} с тому",
		"future": "за {0} с"
	],
	"now": "зараз"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "торік",
		"current": "цього року",
		"next": "наступного року",
		"past": [
			"one": "{0} рік тому",
			"few": "{0} роки тому",
			"many": "{0} років тому",
			"other": "{0} року тому"
		],
		"future": [
			"one": "через {0} рік",
			"few": "через {0} роки",
			"many": "через {0} років",
			"other": "через {0} року"
		]
	],
	"quarter": [
		"previous": "минулого кварталу",
		"current": "цього кварталу",
		"next": "наступного кварталу",
		"past": [
			"one": "{0} квартал тому",
			"few": "{0} квартали тому",
			"many": "{0} кварталів тому",
			"other": "{0} кварталу тому"
		],
		"future": [
			"one": "через {0} квартал",
			"few": "через {0} квартали",
			"many": "через {0} кварталів",
			"other": "через {0} кварталу"
		]
	],
	"month": [
		"previous": "минулого місяця",
		"current": "цього місяця",
		"next": "наступного місяця",
		"past": [
			"one": "{0} місяць тому",
			"few": "{0} місяці тому",
			"many": "{0} місяців тому",
			"other": "{0} місяця тому"
		],
		"future": [
			"one": "через {0} місяць",
			"few": "через {0} місяці",
			"many": "через {0} місяців",
			"other": "через {0} місяця"
		]
	],
	"week": [
		"previous": "минулого тижня",
		"current": "цього тижня",
		"next": "наступного тижня",
		"past": [
			"one": "{0} тиждень тому",
			"few": "{0} тижні тому",
			"many": "{0} тижнів тому",
			"other": "{0} тижня тому"
		],
		"future": [
			"one": "через {0} тиждень",
			"few": "через {0} тижні",
			"many": "через {0} тижнів",
			"other": "через {0} тижня"
		]
	],
	"day": [
		"previous": "учора",
		"current": "сьогодні",
		"next": "завтра",
		"past": [
			"one": "{0} день тому",
			"few": "{0} дні тому",
			"many": "{0} днів тому",
			"other": "{0} дня тому"
		],
		"future": [
			"one": "через {0} день",
			"few": "через {0} дні",
			"many": "через {0} днів",
			"other": "через {0} дня"
		]
	],
	"hour": [
		"current": "цієї години",
		"past": [
			"one": "{0} годину тому",
			"many": "{0} годин тому",
			"other": "{0} години тому"
		],
		"future": [
			"one": "через {0} годину",
			"many": "через {0} годин",
			"other": "через {0} години"
		]
	],
	"minute": [
		"current": "цієї хвилини",
		"past": [
			"one": "{0} хвилину тому",
			"many": "{0} хвилин тому",
			"other": "{0} хвилини тому"
		],
		"future": [
			"one": "через {0} хвилину",
			"many": "через {0} хвилин",
			"other": "через {0} хвилини"
		]
	],
	"second": [
		"current": "зараз",
		"past": [
			"one": "{0} секунду тому",
			"many": "{0} секунд тому",
			"other": "{0} секунди тому"
		],
		"future": [
			"one": "через {0} секунду",
			"many": "через {0} секунд",
			"other": "через {0} секунди"
		]
	],
	"now": "зараз"
]
	}
}
