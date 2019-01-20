import Foundation

// swiftlint:disable type_name
public class lang_lv: RelativeFormatterLang {

	/// Latvian
	public static let identifier: String = "lv"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		let mod100 = Int(value) % 100

		if value == 0 {
			return .zero
		}

		if value == 1 {
			return .one
		}

		switch mod10 {
		case 1:
			if mod100 != 11 {
				return .one
			}
			return .other
		default:
			return .many
		}
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
		"previous": "pagājušajā gadā",
		"current": "šajā gadā",
		"next": "nākamajā gadā",
		"past": "pirms {0} g.",
		"future": "pēc {0} g."
	],
	"quarter": [
		"previous": "pēdējais ceturksnis",
		"current": "šis ceturksnis",
		"next": "nākamais ceturksnis",
		"past": "pirms {0} cet.",
		"future": "pēc {0} cet."
	],
	"month": [
		"previous": "pagājušajā mēnesī",
		"current": "šajā mēnesī",
		"next": "nākamajā mēnesī",
		"past": "pirms {0} mēn.",
		"future": "pēc {0} mēn."
	],
	"week": [
		"previous": "pagājušajā nedēļā",
		"current": "šajā nedēļā",
		"next": "nākamajā nedēļā",
		"past": "pirms {0} ned.",
		"future": "pēc {0} ned."
	],
	"day": [
		"previous": "vakar",
		"current": "šodien",
		"next": "rīt",
		"past": [
			"one": "pirms {0} d.",
			"other": "pirms {0} d."
		],
		"future": [
			"one": "pēc {0} d.",
			"other": "pēc {0} d."
		]
	],
	"hour": [
		"current": "šajā stundā",
		"past": "pirms {0} st.",
		"future": "pēc {0} st."
	],
	"minute": [
		"current": "šajā minūtē",
		"past": "pirms {0} min.",
		"future": "pēc {0} min."
	],
	"second": [
		"current": "tagad",
		"past": "pirms {0} sek.",
		"future": "pēc {0} sek."
	],
	"now": "tagad"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "pagājušajā gadā",
		"current": "šajā gadā",
		"next": "nākamajā gadā",
		"past": "pirms {0} g.",
		"future": "pēc {0} g."
	],
	"quarter": [
		"previous": "pēdējais ceturksnis",
		"current": "šis ceturksnis",
		"next": "nākamais ceturksnis",
		"past": "pirms {0} cet.",
		"future": "pēc {0} cet."
	],
	"month": [
		"previous": "pagājušajā mēnesī",
		"current": "šajā mēnesī",
		"next": "nākamajā mēnesī",
		"past": "pirms {0} mēn.",
		"future": "pēc {0} mēn."
	],
	"week": [
		"previous": "pagājušajā nedēļā",
		"current": "šajā nedēļā",
		"next": "nākamajā nedēļā",
		"past": "pirms {0} ned.",
		"future": "pēc {0} ned."
	],
	"day": [
		"previous": "vakar",
		"current": "šodien",
		"next": "rīt",
		"past": [
			"one": "pirms {0} d.",
			"other": "pirms {0} d."
		],
		"future": [
			"one": "pēc {0} d.",
			"other": "pēc {0} d."
		]
	],
	"hour": [
		"current": "šajā stundā",
		"past": "pirms {0} h",
		"future": "pēc {0} h"
	],
	"minute": [
		"current": "šajā minūtē",
		"past": "pirms {0} min",
		"future": [
			"one": "pēc {0} min",
			"other": "pēc {0} min"
		]
	],
	"second": [
		"current": "tagad",
		"past": [
			"one": "pirms {0} s",
			"other": "pirms {0} s"
		],
		"future": "pēc {0} s"
	],
	"now": "tagad"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "pagājušajā gadā",
		"current": "šajā gadā",
		"next": "nākamajā gadā",
		"past": [
			"one": "pirms {0} gada",
			"other": "pirms {0} gadiem"
		],
		"future": [
			"one": "pēc {0} gada",
			"other": "pēc {0} gadiem"
		]
	],
	"quarter": [
		"previous": "pēdējais ceturksnis",
		"current": "šis ceturksnis",
		"next": "nākamais ceturksnis",
		"past": [
			"one": "pirms {0} ceturkšņa",
			"other": "pirms {0} ceturkšņiem"
		],
		"future": [
			"one": "pēc {0} ceturkšņa",
			"other": "pēc {0} ceturkšņiem"
		]
	],
	"month": [
		"previous": "pagājušajā mēnesī",
		"current": "šajā mēnesī",
		"next": "nākamajā mēnesī",
		"past": [
			"one": "pirms {0} mēneša",
			"other": "pirms {0} mēnešiem"
		],
		"future": [
			"one": "pēc {0} mēneša",
			"other": "pēc {0} mēnešiem"
		]
	],
	"week": [
		"previous": "pagājušajā nedēļā",
		"current": "šajā nedēļā",
		"next": "nākamajā nedēļā",
		"past": [
			"one": "pirms {0} nedēļas",
			"other": "pirms {0} nedēļām"
		],
		"future": [
			"one": "pēc {0} nedēļas",
			"other": "pēc {0} nedēļām"
		]
	],
	"day": [
		"previous": "vakar",
		"current": "šodien",
		"next": "rīt",
		"past": [
			"one": "pirms {0} dienas",
			"other": "pirms {0} dienām"
		],
		"future": [
			"one": "pēc {0} dienas",
			"other": "pēc {0} dienām"
		]
	],
	"hour": [
		"current": "šajā stundā",
		"past": [
			"one": "pirms {0} stundas",
			"other": "pirms {0} stundām"
		],
		"future": [
			"one": "pēc {0} stundas",
			"other": "pēc {0} stundām"
		]
	],
	"minute": [
		"current": "šajā minūtē",
		"past": [
			"one": "pirms {0} minūtes",
			"other": "pirms {0} minūtēm"
		],
		"future": [
			"one": "pēc {0} minūtes",
			"other": "pēc {0} minūtēm"
		]
	],
	"second": [
		"current": "tagad",
		"past": [
			"one": "pirms {0} sekundes",
			"other": "pirms {0} sekundēm"
		],
		"future": [
			"one": "pēc {0} sekundes",
			"other": "pēc {0} sekundēm"
		]
	],
	"now": "tagad"
]
	}
}
