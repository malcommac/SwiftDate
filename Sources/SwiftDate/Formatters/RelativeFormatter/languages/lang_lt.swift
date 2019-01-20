import Foundation

// swiftlint:disable type_name
public class lang_lt: RelativeFormatterLang {

	/// Lithuanian
	public static let identifier: String = "lt"

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
			return .many
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
		"previous": "praėjusiais metais",
		"current": "šiais metais",
		"next": "kitais metais",
		"past": "prieš {0} m.",
		"future": "po {0} m."
	],
	"quarter": [
		"previous": "praėjęs ketvirtis",
		"current": "šis ketvirtis",
		"next": "kitas ketvirtis",
		"past": "prieš {0} ketv.",
		"future": "po {0} ketv."
	],
	"month": [
		"previous": "praėjusį mėnesį",
		"current": "šį mėnesį",
		"next": "kitą mėnesį",
		"past": "prieš {0} mėn.",
		"future": "po {0} mėn."
	],
	"week": [
		"previous": "praėjusią savaitę",
		"current": "šią savaitę",
		"next": "kitą savaitę",
		"past": "prieš {0} sav.",
		"future": "po {0} sav."
	],
	"day": [
		"previous": "vakar",
		"current": "šiandien",
		"next": "rytoj",
		"past": "prieš {0} d.",
		"future": "po {0} d."
	],
	"hour": [
		"current": "šią valandą",
		"past": "prieš {0} val.",
		"future": "po {0} val."
	],
	"minute": [
		"current": "šią minutę",
		"past": "prieš {0} min.",
		"future": "po {0} min."
	],
	"second": [
		"current": "dabar",
		"past": "prieš {0} sek.",
		"future": "po {0} sek."
	],
	"now": "dabar"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "praėjusiais metais",
		"current": "šiais metais",
		"next": "kitais metais",
		"past": "prieš {0} m.",
		"future": "po {0} m."
	],
	"quarter": [
		"previous": "praėjęs ketvirtis",
		"current": "šis ketvirtis",
		"next": "kitas ketvirtis",
		"past": "prieš {0} ketv.",
		"future": "po {0} ketv."
	],
	"month": [
		"previous": "praėjusį mėnesį",
		"current": "šį mėnesį",
		"next": "kitą mėnesį",
		"past": "prieš {0} mėn.",
		"future": "po {0} mėn."
	],
	"week": [
		"previous": "praėjusią savaitę",
		"current": "šią savaitę",
		"next": "kitą savaitę",
		"past": "prieš {0} sav.",
		"future": "po {0} sav."
	],
	"day": [
		"previous": "vakar",
		"current": "šiandien",
		"next": "rytoj",
		"past": "prieš {0} d.",
		"future": "po {0} d."
	],
	"hour": [
		"current": "šią valandą",
		"past": "prieš {0} val.",
		"future": "po {0} val."
	],
	"minute": [
		"current": "šią minutę",
		"past": "prieš {0} min.",
		"future": "po {0} min."
	],
	"second": [
		"current": "dabar",
		"past": "prieš {0} s",
		"future": "po {0} s"
	],
	"now": "dabar"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "praėjusiais metais",
		"current": "šiais metais",
		"next": "kitais metais",
		"past": [
			"one": "prieš {0} metus",
			"few": "prieš {0} metus",
			"other": "prieš {0} metų"
		],
		"future": "po {0} metų"
	],
	"quarter": [
		"previous": "praėjęs ketvirtis",
		"current": "šis ketvirtis",
		"next": "kitas ketvirtis",
		"past": [
			"one": "prieš {0} ketvirtį",
			"few": "prieš {0} ketvirčius",
			"many": "prieš {0} ketvirčio",
			"other": "prieš {0} ketvirčių"
		],
		"future": [
			"one": "po {0} ketvirčio",
			"many": "po {0} ketvirčio",
			"other": "po {0} ketvirčių"
		]
	],
	"month": [
		"previous": "praėjusį mėnesį",
		"current": "šį mėnesį",
		"next": "kitą mėnesį",
		"past": [
			"one": "prieš {0} mėnesį",
			"few": "prieš {0} mėnesius",
			"many": "prieš {0} mėnesio",
			"other": "prieš {0} mėnesių"
		],
		"future": [
			"one": "po {0} mėnesio",
			"many": "po {0} mėnesio",
			"other": "po {0} mėnesių"
		]
	],
	"week": [
		"previous": "praėjusią savaitę",
		"current": "šią savaitę",
		"next": "kitą savaitę",
		"past": [
			"one": "prieš {0} savaitę",
			"few": "prieš {0} savaites",
			"many": "prieš {0} savaitės",
			"other": "prieš {0} savaičių"
		],
		"future": [
			"one": "po {0} savaitės",
			"many": "po {0} savaitės",
			"other": "po {0} savaičių"
		]
	],
	"day": [
		"previous": "vakar",
		"current": "šiandien",
		"next": "rytoj",
		"past": [
			"one": "prieš {0} dieną",
			"few": "prieš {0} dienas",
			"many": "prieš {0} dienos",
			"other": "prieš {0} dienų"
		],
		"future": [
			"one": "po {0} dienos",
			"many": "po {0} dienos",
			"other": "po {0} dienų"
		]
	],
	"hour": [
		"current": "šią valandą",
		"past": [
			"one": "prieš {0} valandą",
			"few": "prieš {0} valandas",
			"many": "prieš {0} valandos",
			"other": "prieš {0} valandų"
		],
		"future": [
			"one": "po {0} valandos",
			"many": "po {0} valandos",
			"other": "po {0} valandų"
		]
	],
	"minute": [
		"current": "šią minutę",
		"past": [
			"one": "prieš {0} minutę",
			"few": "prieš {0} minutes",
			"many": "prieš {0} minutės",
			"other": "prieš {0} minučių"
		],
		"future": [
			"one": "po {0} minutės",
			"many": "po {0} minutės",
			"other": "po {0} minučių"
		]
	],
	"second": [
		"current": "dabar",
		"past": [
			"one": "prieš {0} sekundę",
			"few": "prieš {0} sekundes",
			"many": "prieš {0} sekundės",
			"other": "prieš {0} sekundžių"
		],
		"future": [
			"one": "po {0} sekundės",
			"many": "po {0} sekundės",
			"other": "po {0} sekundžių"
		]
	],
	"now": "dabar"
]
	}
}
