import Foundation

// swiftlint:disable type_name
public class lang_pl: RelativeFormatterLang {

	/// Polish
	public static let identifier: String = "pl"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		let mod100 = Int(value) % 100

		if value == 1 {
			return .one
		}

		switch mod10 {
		case 2...4:
			switch mod100 {
			case 12...14:
				break
			default:
				return .few
			}
		default:
			return .many
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
		"previous": "w zeszłym roku",
		"current": "w tym roku",
		"next": "w przyszłym roku",
		"past": [
			"one": "{0} rok temu",
			"few": "{0} lata temu",
			"many": "{0} lat temu",
			"other": "{0} roku temu"
		],
		"future": [
			"one": "za {0} rok",
			"few": "za {0} lata",
			"many": "za {0} lat",
			"other": "za {0} roku"
		]
	],
	"quarter": [
		"previous": "w zeszłym kwartale",
		"current": "w tym kwartale",
		"next": "w przyszłym kwartale",
		"past": "{0} kw. temu",
		"future": "za {0} kw."
	],
	"month": [
		"previous": "w zeszłym miesiącu",
		"current": "w tym miesiącu",
		"next": "w przyszłym miesiącu",
		"past": "{0} mies. temu",
		"future": "za {0} mies."
	],
	"week": [
		"previous": "w zeszłym tygodniu",
		"current": "w tym tygodniu",
		"next": "w przyszłym tygodniu",
		"past": [
			"one": "{0} tydz. temu",
			"other": "{0} tyg. temu"
		],
		"future": [
			"one": "za {0} tydz.",
			"other": "za {0} tyg."
		]
	],
	"day": [
		"previous": "wczoraj",
		"current": "dzisiaj",
		"next": "jutro",
		"past": [
			"one": "{0} dzień temu",
			"few": "{0} dni temu",
			"many": "{0} dni temu",
			"other": "{0} dnia temu"
		],
		"future": [
			"one": "za {0} dzień",
			"few": "za {0} dni",
			"many": "za {0} dni",
			"other": "za {0} dnia"
		]
	],
	"hour": [
		"current": "ta godzina",
		"past": "{0} godz. temu",
		"future": "za {0} godz."
	],
	"minute": [
		"current": "ta minuta",
		"past": "{0} min temu",
		"future": "za {0} min"
	],
	"second": [
		"current": "teraz",
		"past": "{0} sek. temu",
		"future": "za {0} sek."
	],
	"now": "teraz"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "w zeszłym roku",
		"current": "w tym roku",
		"next": "w przyszłym roku",
		"past": [
			"one": "{0} rok temu",
			"few": "{0} lata temu",
			"many": "{0} lat temu",
			"other": "{0} roku temu"
		],
		"future": [
			"one": "za {0} rok",
			"few": "za {0} lata",
			"many": "za {0} lat",
			"other": "za {0} roku"
		]
	],
	"quarter": [
		"previous": "w zeszłym kwartale",
		"current": "w tym kwartale",
		"next": "w przyszłym kwartale",
		"past": "{0} kw. temu",
		"future": "za {0} kw."
	],
	"month": [
		"previous": "w zeszłym miesiącu",
		"current": "w tym miesiącu",
		"next": "w przyszłym miesiącu",
		"past": "{0} mies. temu",
		"future": "za {0} mies."
	],
	"week": [
		"previous": "w zeszłym tygodniu",
		"current": "w tym tygodniu",
		"next": "w przyszłym tygodniu",
		"past": [
			"one": "{0} tydz. temu",
			"other": "{0} tyg. temu"
		],
		"future": [
			"one": "za {0} tydz.",
			"other": "za {0} tyg."
		]
	],
	"day": [
		"previous": "wczoraj",
		"current": "dzisiaj",
		"next": "jutro",
		"past": [
			"one": "{0} dzień temu",
			"few": "{0} dni temu",
			"many": "{0} dni temu",
			"other": "{0} dnia temu"
		],
		"future": [
			"one": "za {0} dzień",
			"few": "za {0} dni",
			"many": "za {0} dni",
			"other": "za {0} dnia"
		]
	],
	"hour": [
		"current": "ta godzina",
		"past": "{0} g. temu",
		"future": "za {0} g."
	],
	"minute": [
		"current": "ta minuta",
		"past": "{0} min temu",
		"future": "za {0} min"
	],
	"second": [
		"current": "teraz",
		"past": "{0} s temu",
		"future": "za {0} s"
	],
	"now": "teraz"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "w zeszłym roku",
		"current": "w tym roku",
		"next": "w przyszłym roku",
		"past": [
			"one": "{0} rok temu",
			"few": "{0} lata temu",
			"many": "{0} lat temu",
			"other": "{0} roku temu"
		],
		"future": [
			"one": "za {0} rok",
			"few": "za {0} lata",
			"many": "za {0} lat",
			"other": "za {0} roku"
		]
	],
	"quarter": [
		"previous": "w zeszłym kwartale",
		"current": "w tym kwartale",
		"next": "w przyszłym kwartale",
		"past": [
			"one": "{0} kwartał temu",
			"few": "{0} kwartały temu",
			"many": "{0} kwartałów temu",
			"other": "{0} kwartału temu"
		],
		"future": [
			"one": "za {0} kwartał",
			"few": "za {0} kwartały",
			"many": "za {0} kwartałów",
			"other": "za {0} kwartału"
		]
	],
	"month": [
		"previous": "w zeszłym miesiącu",
		"current": "w tym miesiącu",
		"next": "w przyszłym miesiącu",
		"past": [
			"one": "{0} miesiąc temu",
			"few": "{0} miesiące temu",
			"many": "{0} miesięcy temu",
			"other": "{0} miesiąca temu"
		],
		"future": [
			"one": "za {0} miesiąc",
			"few": "za {0} miesiące",
			"many": "za {0} miesięcy",
			"other": "za {0} miesiąca"
		]
	],
	"week": [
		"previous": "w zeszłym tygodniu",
		"current": "w tym tygodniu",
		"next": "w przyszłym tygodniu",
		"past": [
			"one": "{0} tydzień temu",
			"few": "{0} tygodnie temu",
			"many": "{0} tygodni temu",
			"other": "{0} tygodnia temu"
		],
		"future": [
			"one": "za {0} tydzień",
			"few": "za {0} tygodnie",
			"many": "za {0} tygodni",
			"other": "za {0} tygodnia"
		]
	],
	"day": [
		"previous": "wczoraj",
		"current": "dzisiaj",
		"next": "jutro",
		"past": [
			"one": "{0} dzień temu",
			"few": "{0} dni temu",
			"many": "{0} dni temu",
			"other": "{0} dnia temu"
		],
		"future": [
			"one": "za {0} dzień",
			"few": "za {0} dni",
			"many": "za {0} dni",
			"other": "za {0} dnia"
		]
	],
	"hour": [
		"current": "ta godzina",
		"past": [
			"one": "{0} godzinę temu",
			"many": "{0} godzin temu",
			"other": "{0} godziny temu"
		],
		"future": [
			"one": "za {0} godzinę",
			"many": "za {0} godzin",
			"other": "za {0} godziny"
		]
	],
	"minute": [
		"current": "ta minuta",
		"past": [
			"one": "{0} minutę temu",
			"many": "{0} minut temu",
			"other": "{0} minuty temu"
		],
		"future": [
			"one": "za {0} minutę",
			"many": "za {0} minut",
			"other": "za {0} minuty"
		]
	],
	"second": [
		"current": "teraz",
		"past": [
			"one": "{0} sekundę temu",
			"many": "{0} sekund temu",
			"other": "{0} sekundy temu"
		],
		"future": [
			"one": "za {0} sekundę",
			"many": "za {0} sekund",
			"other": "za {0} sekundy"
		]
	],
	"now": "teraz"
]
	}
}
