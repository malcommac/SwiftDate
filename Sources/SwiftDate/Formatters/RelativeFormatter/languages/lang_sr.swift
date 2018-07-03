import Foundation

// swiftlint:disable type_name
public class lang_sr: RelativeFormatterLang {

	/// Serbian
	public static let identifier: String = "sr"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		let mod100 = Int(value) % 100

		switch mod10 {
		case 1:
			switch mod100 {
			case 11:
				break
			default:
				return .one
			}
		case 2, 3, 4:
			switch mod100 {
			case 12, 13, 14:
				break
			default:
				return .few
			}
		default:
			break
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
		"previous": "прошле год.",
		"current": "ове год.",
		"next": "следеће год.",
		"past": "пре {0} год.",
		"future": "за {0} год."
	],
	"quarter": [
		"previous": "прошлог квартала",
		"current": "овог квартала",
		"next": "следећег квартала",
		"past": "пре {0} кв.",
		"future": "за {0} кв."
	],
	"month": [
		"previous": "прошлог мес.",
		"current": "овог мес.",
		"next": "следећег мес.",
		"past": "пре {0} мес.",
		"future": "за {0} мес."
	],
	"week": [
		"previous": "прошле нед.",
		"current": "ове нед.",
		"next": "следеће нед.",
		"past": "пре {0} нед.",
		"future": "за {0} нед."
	],
	"day": [
		"previous": "јуче",
		"current": "данас",
		"next": "сутра",
		"past": "пре {0} д.",
		"future": "за {0} д."
	],
	"hour": [
		"current": "овог сата",
		"past": "пре {0} ч.",
		"future": "за {0} ч."
	],
	"minute": [
		"current": "овог минута",
		"past": "пре {0} мин.",
		"future": "за {0} мин."
	],
	"second": [
		"current": "сада",
		"past": "пре {0} сек.",
		"future": "за {0} сек."
	],
	"now": "сада"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "прошле г.",
		"current": "ове г.",
		"next": "следеће г.",
		"past": "пре {0} г.",
		"future": "за {0} г."
	],
	"quarter": [
		"previous": "прошлог квартала",
		"current": "овог квартала",
		"next": "следећег квартала",
		"past": "пре {0} кв.",
		"future": "за {0} кв."
	],
	"month": [
		"previous": "прошлог м.",
		"current": "овог м.",
		"next": "следећег м.",
		"past": "пре {0} м.",
		"future": "за {0} м."
	],
	"week": [
		"previous": "прошле н.",
		"current": "ове н.",
		"next": "следеће н.",
		"past": "пре {0} н.",
		"future": "за {0} н."
	],
	"day": [
		"previous": "јуче",
		"current": "данас",
		"next": "сутра",
		"past": "пре {0} д.",
		"future": "за {0} д."
	],
	"hour": [
		"current": "овог сата",
		"past": "пре {0} ч.",
		"future": "за {0} ч."
	],
	"minute": [
		"current": "овог минута",
		"past": "пре {0} мин.",
		"future": "за {0} мин."
	],
	"second": [
		"current": "сада",
		"past": "пре {0} с.",
		"future": "за {0} с."
	],
	"now": "сада"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "прошле године",
		"current": "ове године",
		"next": "следеће године",
		"past": [
			"one": "пре {0} године",
			"few": "пре {0} године",
			"other": "пре {0} година"
		],
		"future": [
			"one": "за {0} годину",
			"few": "за {0} године",
			"other": "за {0} година"
		]
	],
	"quarter": [
		"previous": "прошлог квартала",
		"current": "овог квартала",
		"next": "следећег квартала",
		"past": "пре {0} квартала",
		"future": [
			"one": "за {0} квартал",
			"other": "за {0} квартала"
		]
	],
	"month": [
		"previous": "прошлог месеца",
		"current": "овог месеца",
		"next": "следећег месеца",
		"past": [
			"one": "пре {0} месеца",
			"few": "пре {0} месеца",
			"other": "пре {0} месеци"
		],
		"future": [
			"one": "за {0} месец",
			"few": "за {0} месеца",
			"other": "за {0} месеци"
		]
	],
	"week": [
		"previous": "прошле недеље",
		"current": "ове недеље",
		"next": "следеће недеље",
		"past": [
			"one": "пре {0} недеље",
			"few": "пре {0} недеље",
			"other": "пре {0} недеља"
		],
		"future": [
			"one": "за {0} недељу",
			"few": "за {0} недеље",
			"other": "за {0} недеља"
		]
	],
	"day": [
		"previous": "јуче",
		"current": "данас",
		"next": "сутра",
		"past": "пре {0} дана",
		"future": [
			"one": "за {0} дан",
			"other": "за {0} дана"
		]
	],
	"hour": [
		"current": "овог сата",
		"past": [
			"one": "пре {0} сата",
			"few": "пре {0} сата",
			"other": "пре {0} сати"
		],
		"future": [
			"one": "за {0} сат",
			"few": "за {0} сата",
			"other": "за {0} сати"
		]
	],
	"minute": [
		"current": "овог минута",
		"past": "пре {0} минута",
		"future": [
			"one": "за {0} минут",
			"other": "за {0} минута"
		]
	],
	"second": [
		"current": "сада",
		"past": [
			"one": "пре {0} секунде",
			"few": "пре {0} секунде",
			"other": "пре {0} секунди"
		],
		"future": [
			"one": "за {0} секунду",
			"few": "за {0} секунде",
			"other": "за {0} секунди"
		]
	],
	"now": "сада"
]
	}
}
