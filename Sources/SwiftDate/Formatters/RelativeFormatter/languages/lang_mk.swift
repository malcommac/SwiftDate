import Foundation

// swiftlint:disable type_name
public class lang_mk: RelativeFormatterLang {

	/// Macedonian
	public static let identifier: String = "mk"

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
		"previous": "минатата година",
		"current": "оваа година",
		"next": "следната година",
		"past": "пред {0} год.",
		"future": "за {0} год."
	],
	"quarter": [
		"previous": "последното тромесечје",
		"current": "ова тромесечје",
		"next": "следното тромесечје",
		"past": "пред {0} тромес.",
		"future": "за {0} тромес."
	],
	"month": [
		"previous": "минатиот месец",
		"current": "овој месец",
		"next": "следниот месец",
		"past": [
			"one": "пред {0} месец",
			"other": "пред {0} месеци"
		],
		"future": [
			"one": "за {0} месец",
			"other": "за {0} месеци"
		]
	],
	"week": [
		"previous": "минатата седмица",
		"current": "оваа седмица",
		"next": "следната седмица",
		"past": [
			"one": "пред {0} седмица",
			"other": "пред {0} седмици"
		],
		"future": [
			"one": "за {0} седмица",
			"other": "за {0} седмици"
		]
	],
	"day": [
		"previous": "вчера",
		"current": "денес",
		"next": "утре",
		"past": [
			"one": "пред {0} ден",
			"other": "пред {0} дена"
		],
		"future": [
			"one": "за {0} ден",
			"other": "за {0} дена"
		]
	],
	"hour": [
		"current": "часов",
		"past": [
			"one": "пред {0} час",
			"other": "пред {0} часа"
		],
		"future": [
			"one": "за {0} час",
			"other": "за {0} часа"
		]
	],
	"minute": [
		"current": "оваа минута",
		"past": "пред {0} мин.",
		"future": "за {0} мин."
	],
	"second": [
		"current": "сега",
		"past": "пред {0} сек.",
		"future": "за {0} сек."
	],
	"now": "сега"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "минатата година",
		"current": "оваа година",
		"next": "следната година",
		"past": "пред {0} год.",
		"future": "за {0} год."
	],
	"quarter": [
		"previous": "последното тромесечје",
		"current": "ова тромесечје",
		"next": "следното тромесечје",
		"past": "пред {0} тромес.",
		"future": "за {0} тромес."
	],
	"month": [
		"previous": "минатиот месец",
		"current": "овој месец",
		"next": "следниот месец",
		"past": [
			"one": "пред {0} месец",
			"other": "пред {0} месеци"
		],
		"future": [
			"one": "за {0} месец",
			"other": "за {0} месеци"
		]
	],
	"week": [
		"previous": "минатата седмица",
		"current": "оваа седмица",
		"next": "следната седмица",
		"past": [
			"one": "пред {0} седмица",
			"other": "пред {0} седмици"
		],
		"future": [
			"one": "за {0} седмица",
			"other": "за {0} седмици"
		]
	],
	"day": [
		"previous": "вчера",
		"current": "денес",
		"next": "утре",
		"past": [
			"one": "пред {0} ден",
			"other": "пред {0} дена"
		],
		"future": [
			"one": "за {0} ден",
			"other": "за {0} дена"
		]
	],
	"hour": [
		"current": "часов",
		"past": [
			"one": "пред {0} час",
			"other": "пред {0} часа"
		],
		"future": [
			"one": "за {0} час",
			"other": "за {0} часа"
		]
	],
	"minute": [
		"current": "оваа минута",
		"past": "пред {0} мин.",
		"future": "за {0} мин."
	],
	"second": [
		"current": "сега",
		"past": "пред {0} сек.",
		"future": "за {0} сек."
	],
	"now": "сега"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "минатата година",
		"current": "оваа година",
		"next": "следната година",
		"past": [
			"one": "пред {0} година",
			"other": "пред {0} години"
		],
		"future": [
			"one": "за {0} година",
			"other": "за {0} години"
		]
	],
	"quarter": [
		"previous": "последното тромесечје",
		"current": "ова тромесечје",
		"next": "следното тромесечје",
		"past": [
			"one": "пред {0} тромесечје",
			"other": "пред {0} тромесечја"
		],
		"future": [
			"one": "за {0} тромесечје",
			"other": "за {0} тромесечја"
		]
	],
	"month": [
		"previous": "минатиот месец",
		"current": "овој месец",
		"next": "следниот месец",
		"past": [
			"one": "пред {0} месец",
			"other": "пред {0} месеци"
		],
		"future": [
			"one": "за {0} месец",
			"other": "за {0} месеци"
		]
	],
	"week": [
		"previous": "минатата седмица",
		"current": "оваа седмица",
		"next": "следната седмица",
		"past": [
			"one": "пред {0} седмица",
			"other": "пред {0} седмици"
		],
		"future": [
			"one": "за {0} седмица",
			"other": "за {0} седмици"
		]
	],
	"day": [
		"previous": "вчера",
		"current": "денес",
		"next": "утре",
		"past": [
			"one": "пред {0} ден",
			"other": "пред {0} дена"
		],
		"future": [
			"one": "за {0} ден",
			"other": "за {0} дена"
		]
	],
	"hour": [
		"current": "часов",
		"past": [
			"one": "пред {0} час",
			"other": "пред {0} часа"
		],
		"future": [
			"one": "за {0} час",
			"other": "за {0} часа"
		]
	],
	"minute": [
		"current": "оваа минута",
		"past": [
			"one": "пред {0} минута",
			"other": "пред {0} минути"
		],
		"future": [
			"one": "за {0} минута",
			"other": "за {0} минути"
		]
	],
	"second": [
		"current": "сега",
		"past": [
			"one": "пред {0} секунда",
			"other": "пред {0} секунди"
		],
		"future": [
			"one": "за {0} секунда",
			"other": "за {0} секунди"
		]
	],
	"now": "сега"
]
	}
}
