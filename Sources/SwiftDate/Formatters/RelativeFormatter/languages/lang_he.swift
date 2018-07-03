import Foundation

// swiftlint:disable type_name
public class lang_he: RelativeFormatterLang {

	/// Hebrew
	public static let identifier: String = "he"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		switch value {
		case 1:
			return .one
		case 2:
			return .two
		case 3...10:
			break
		default:
			switch mod10 {
			case 0:
				return .many
			default:
				break
			}
		}
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
		"previous": "השנה שעברה",
		"current": "השנה",
		"next": "השנה הבאה",
		"past": [
			"one": "לפני שנה",
			"two": "לפני שנתיים",
			"many": "לפני {0} שנה",
			"other": "לפני {0} שנים"
		],
		"future": [
			"one": "בעוד שנה",
			"two": "בעוד שנתיים",
			"many": "בעוד {0} שנה",
			"other": "בעוד {0} שנים"
		]
	],
	"quarter": [
		"previous": "הרבעון הקודם",
		"current": "רבעון זה",
		"next": "הרבעון הבא",
		"past": [
			"one": "ברבע׳ הקודם",
			"two": "לפני שני רבע׳",
			"other": "לפני {0} רבע׳"
		],
		"future": [
			"one": "ברבע׳ הבא",
			"two": "בעוד שני רבע׳",
			"other": "בעוד {0} רבע׳"
		]
	],
	"month": [
		"previous": "החודש שעבר",
		"current": "החודש",
		"next": "החודש הבא",
		"past": [
			"one": "לפני חודש",
			"two": "לפני חודשיים",
			"other": "לפני {0} חודשים"
		],
		"future": [
			"one": "בעוד חודש",
			"two": "בעוד חודשיים",
			"other": "בעוד {0} חודשים"
		]
	],
	"week": [
		"previous": "השבוע שעבר",
		"current": "השבוע",
		"next": "השבוע הבא",
		"past": [
			"one": "לפני שב׳",
			"two": "לפני שבועיים",
			"other": "לפני {0} שב׳"
		],
		"future": [
			"one": "בעוד שב׳",
			"two": "בעוד שבועיים",
			"other": "בעוד {0} שב׳"
		]
	],
	"day": [
		"previous": "אתמול",
		"current": "היום",
		"next": "מחר",
		"past": [
			"one": "אתמול",
			"two": "לפני יומיים",
			"other": "לפני {0} ימים"
		],
		"future": [
			"one": "מחר",
			"two": "בעוד יומיים",
			"other": "בעוד {0} ימים"
		]
	],
	"hour": [
		"current": "בשעה זו",
		"past": [
			"one": "לפני שעה",
			"two": "לפני שעתיים",
			"other": "לפני {0} שע׳"
		],
		"future": [
			"one": "בעוד שעה",
			"two": "בעוד שעתיים",
			"other": "בעוד {0} שע׳"
		]
	],
	"minute": [
		"current": "בדקה זו",
		"past": [
			"one": "לפני דקה",
			"other": "לפני {0} דק׳"
		],
		"future": [
			"one": "בעוד דקה",
			"two": "בעוד שתי דק׳",
			"other": "בעוד {0} דק׳"
		]
	],
	"second": [
		"current": "עכשיו",
		"past": [
			"one": "לפני שנ׳",
			"two": "לפני שתי שנ׳",
			"other": "לפני {0} שנ׳"
		],
		"future": [
			"one": "בעוד שנ׳",
			"two": "בעוד שתי שנ׳",
			"other": "בעוד {0} שנ׳"
		]
	],
	"now": "עכשיו"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "השנה שעברה",
		"current": "השנה",
		"next": "השנה הבאה",
		"past": [
			"one": "לפני שנה",
			"two": "לפני שנתיים",
			"many": "לפני {0} שנה",
			"other": "לפני {0} שנים"
		],
		"future": [
			"one": "בעוד שנה",
			"two": "בעוד שנתיים",
			"many": "בעוד {0} שנה",
			"other": "בעוד {0} שנים"
		]
	],
	"quarter": [
		"previous": "הרבעון הקודם",
		"current": "רבעון זה",
		"next": "הרבעון הבא",
		"past": [
			"one": "ברבע׳ הקודם",
			"two": "לפני שני רבע׳",
			"other": "לפני {0} רבע׳"
		],
		"future": [
			"one": "ברבע׳ הבא",
			"two": "בעוד שני רבע׳",
			"other": "בעוד {0} רבע׳"
		]
	],
	"month": [
		"previous": "החודש שעבר",
		"current": "החודש",
		"next": "החודש הבא",
		"past": [
			"one": "לפני חו׳",
			"two": "לפני חודשיים",
			"other": "לפני {0} חו׳"
		],
		"future": [
			"one": "בעוד חו׳",
			"two": "בעוד חודשיים",
			"other": "בעוד {0} חו׳"
		]
	],
	"week": [
		"previous": "השבוע שעבר",
		"current": "השבוע",
		"next": "השבוע הבא",
		"past": [
			"one": "לפני שבוע",
			"two": "לפני שבועיים",
			"other": "לפני {0} שב׳"
		],
		"future": [
			"one": "בעוד שב׳",
			"two": "בעוד שבועיים",
			"other": "בעוד {0} שב׳"
		]
	],
	"day": [
		"previous": "אתמול",
		"current": "היום",
		"next": "מחר",
		"past": [
			"one": "אתמול",
			"two": "לפני יומיים",
			"other": "לפני {0} ימים"
		],
		"future": [
			"one": "מחר",
			"two": "בעוד יומיים",
			"other": "בעוד {0} ימים"
		]
	],
	"hour": [
		"current": "בשעה זו",
		"past": [
			"one": "לפני שעה",
			"two": "לפני שעתיים",
			"other": "לפני {0} שע׳"
		],
		"future": [
			"one": "בעוד שעה",
			"two": "בעוד שעתיים",
			"other": "בעוד {0} שע׳"
		]
	],
	"minute": [
		"current": "בדקה זו",
		"past": [
			"one": "לפני דקה",
			"two": "לפני שתי דק׳",
			"other": "לפני {0} דק׳"
		],
		"future": [
			"one": "בעוד דקה",
			"two": "בעוד שתי דק׳",
			"other": "בעוד {0} דק׳"
		]
	],
	"second": [
		"current": "עכשיו",
		"past": [
			"one": "לפני שנ׳",
			"two": "לפני שתי שנ׳",
			"other": "לפני {0} שנ׳"
		],
		"future": [
			"one": "בעוד שנ׳",
			"two": "בעוד שתי שנ׳",
			"other": "בעוד {0} שנ׳"
		]
	],
	"now": "עכשיו"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "השנה שעברה",
		"current": "השנה",
		"next": "השנה הבאה",
		"past": [
			"one": "לפני שנה",
			"two": "לפני שנתיים",
			"many": "לפני {0} שנה",
			"other": "לפני {0} שנים"
		],
		"future": [
			"one": "בעוד שנה",
			"two": "בעוד שנתיים",
			"many": "בעוד {0} שנה",
			"other": "בעוד {0} שנים"
		]
	],
	"quarter": [
		"previous": "הרבעון הקודם",
		"current": "רבעון זה",
		"next": "הרבעון הבא",
		"past": [
			"one": "ברבעון הקודם",
			"two": "לפני שני רבעונים",
			"other": "לפני {0} רבעונים"
		],
		"future": [
			"one": "ברבעון הבא",
			"two": "בעוד שני רבעונים",
			"other": "בעוד {0} רבעונים"
		]
	],
	"month": [
		"previous": "החודש שעבר",
		"current": "החודש",
		"next": "החודש הבא",
		"past": [
			"one": "לפני חודש",
			"two": "לפני חודשיים",
			"other": "לפני {0} חודשים"
		],
		"future": [
			"one": "בעוד חודש",
			"two": "בעוד חודשיים",
			"other": "בעוד {0} חודשים"
		]
	],
	"week": [
		"previous": "השבוע שעבר",
		"current": "השבוע",
		"next": "השבוע הבא",
		"past": [
			"one": "לפני שבוע",
			"two": "לפני שבועיים",
			"other": "לפני {0} שבועות"
		],
		"future": [
			"one": "בעוד שבוע",
			"two": "בעוד שבועיים",
			"other": "בעוד {0} שבועות"
		]
	],
	"day": [
		"previous": "אתמול",
		"current": "היום",
		"next": "מחר",
		"past": [
			"one": "לפני יום {0}",
			"two": "לפני יומיים",
			"other": "לפני {0} ימים"
		],
		"future": [
			"one": "בעוד יום {0}",
			"two": "בעוד יומיים",
			"other": "בעוד {0} ימים"
		]
	],
	"hour": [
		"current": "בשעה זו",
		"past": [
			"one": "לפני שעה",
			"two": "לפני שעתיים",
			"other": "לפני {0} שעות"
		],
		"future": [
			"one": "בעוד שעה",
			"two": "בעוד שעתיים",
			"other": "בעוד {0} שעות"
		]
	],
	"minute": [
		"current": "בדקה זו",
		"past": [
			"one": "לפני דקה",
			"two": "לפני שתי דקות",
			"other": "לפני {0} דקות"
		],
		"future": [
			"one": "בעוד דקה",
			"two": "בעוד שתי דקות",
			"other": "בעוד {0} דקות"
		]
	],
	"second": [
		"current": "עכשיו",
		"past": [
			"one": "לפני שנייה",
			"two": "לפני שתי שניות",
			"other": "לפני {0} שניות"
		],
		"future": [
			"one": "בעוד שנייה",
			"two": "בעוד שתי שניות",
			"other": "בעוד {0} שניות"
		]
	],
	"now": "עכשיו"
]
	}
}
