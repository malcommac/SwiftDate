import Foundation

// swiftlint:disable type_name// swiftlint:disable type_name
public class lang_pa: RelativeFormatterLang {

	/// Punjabi
	public static let identifier: String = "pa"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
			// swiftlint:disable switch_case_alignment
			case 0, 1:	return .one
			default:	return .other
		}
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
		"previous": "ਪਿਛਲਾ ਸਾਲ",
		"current": "ਇਹ ਸਾਲ",
		"next": "ਅਗਲਾ ਸਾਲ",
		"past": "{0} ਸਾਲ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਸਾਲ ਵਿੱਚ",
			"other": "{0} ਸਾਲਾਂ ਵਿੱਚ"
		]
	],
	"quarter": [
		"previous": "ਪਿਛਲੀ ਤਿਮਾਹੀ",
		"current": "ਇਹ ਤਿਮਾਹੀ",
		"next": "ਅਗਲੀ ਤਿਮਾਹੀ",
		"past": [
			"one": "{0} ਤਿਮਾਹੀ ਪਹਿਲਾਂ",
			"other": "{0} ਤਿਮਾਹੀਆਂ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਤਿਮਾਹੀ ਵਿੱਚ",
			"other": "{0} ਤਿਮਾਹੀਆਂ ਵਿੱਚ"
		]
	],
	"month": [
		"previous": "ਪਿਛਲਾ ਮਹੀਨਾ",
		"current": "ਇਹ ਮਹੀਨਾ",
		"next": "ਅਗਲਾ ਮਹੀਨਾ",
		"past": [
			"one": "{0} ਮਹੀਨਾ ਪਹਿਲਾਂ",
			"other": "{0} ਮਹੀਨੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਮਹੀਨੇ ਵਿੱਚ",
			"other": "{0} ਮਹੀਨਿਆਂ ਵਿੱਚ"
		]
	],
	"week": [
		"previous": "ਪਿਛਲਾ ਹਫ਼ਤਾ",
		"current": "ਇਹ ਹਫ਼ਤਾ",
		"next": "ਅਗਲਾ ਹਫ਼ਤਾ",
		"past": [
			"one": "{0} ਹਫ਼ਤਾ ਪਹਿਲਾਂ",
			"other": "{0} ਹਫ਼ਤੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਹਫ਼ਤੇ ਵਿੱਚ",
			"other": "{0} ਹਫ਼ਤਿਆਂ ਵਿੱਚ"
		]
	],
	"day": [
		"previous": "ਬੀਤਿਆ ਕੱਲ੍ਹ",
		"current": "ਅੱਜ",
		"next": "ਭਲਕੇ",
		"past": "{0} ਦਿਨ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਦਿਨ ਵਿੱਚ",
			"other": "{0} ਦਿਨਾਂ ਵਿੱਚ"
		]
	],
	"hour": [
		"current": "ਇਸ ਘੰਟੇ",
		"past": [
			"one": "{0} ਘੰਟਾ ਪਹਿਲਾਂ",
			"other": "{0} ਘੰਟੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਘੰਟੇ ਵਿੱਚ",
			"other": "{0} ਘੰਟਿਆਂ ਵਿੱਚ"
		]
	],
	"minute": [
		"current": "ਇਸ ਮਿੰਟ",
		"past": "{0} ਮਿੰਟ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਮਿੰਟ ਵਿੱਚ",
			"other": "{0} ਮਿੰਟਾਂ ਵਿੱਚ"
		]
	],
	"second": [
		"current": "ਹੁਣ",
		"past": "{0} ਸਕਿੰਟ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਸਕਿੰਟ ਵਿੱਚ",
			"other": "{0} ਸਕਿੰਟਾਂ ਵਿੱਚ"
		]
	],
	"now": "ਹੁਣ"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ਪਿਛਲਾ ਸਾਲ",
		"current": "ਇਹ ਸਾਲ",
		"next": "ਅਗਲਾ ਸਾਲ",
		"past": "{0} ਸਾਲ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਸਾਲ ਵਿੱਚ",
			"other": "{0} ਸਾਲਾਂ ਵਿੱਚ"
		]
	],
	"quarter": [
		"previous": "ਪਿਛਲੀ ਤਿਮਾਹੀ",
		"current": "ਇਹ ਤਿਮਾਹੀ",
		"next": "ਅਗਲੀ ਤਿਮਾਹੀ",
		"past": "{0} ਤਿਮਾਹੀਆਂ ਪਹਿਲਾਂ",
		"future": "{0} ਤਿਮਾਹੀਆਂ ਵਿੱਚ"
	],
	"month": [
		"previous": "ਪਿਛਲਾ ਮਹੀਨਾ",
		"current": "ਇਹ ਮਹੀਨਾ",
		"next": "ਅਗਲਾ ਮਹੀਨਾ",
		"past": [
			"one": "{0} ਮਹੀਨਾ ਪਹਿਲਾਂ",
			"other": "{0} ਮਹੀਨੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਮਹੀਨੇ ਵਿੱਚ",
			"other": "{0} ਮਹੀਨਿਆਂ ਵਿੱਚ"
		]
	],
	"week": [
		"previous": "ਪਿਛਲਾ ਹਫ਼ਤਾ",
		"current": "ਇਹ ਹਫ਼ਤਾ",
		"next": "ਅਗਲਾ ਹਫ਼ਤਾ",
		"past": [
			"one": "{0} ਹਫ਼ਤਾ ਪਹਿਲਾਂ",
			"other": "{0} ਹਫ਼ਤੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਹਫ਼ਤੇ ਵਿੱਚ",
			"other": "{0} ਹਫ਼ਤਿਆਂ ਵਿੱਚ"
		]
	],
	"day": [
		"previous": "ਬੀਤਿਆ ਕੱਲ੍ਹ",
		"current": "ਅੱਜ",
		"next": "ਭਲਕੇ",
		"past": "{0} ਦਿਨ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਦਿਨ ਵਿੱਚ",
			"other": "{0} ਦਿਨਾਂ ਵਿੱਚ"
		]
	],
	"hour": [
		"current": "ਇਸ ਘੰਟੇ",
		"past": [
			"one": "{0} ਘੰਟਾ ਪਹਿਲਾਂ",
			"other": "{0} ਘੰਟੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਘੰਟੇ ਵਿੱਚ",
			"other": "{0} ਘੰਟਿਆਂ ਵਿੱਚ"
		]
	],
	"minute": [
		"current": "ਇਸ ਮਿੰਟ",
		"past": "{0} ਮਿੰਟ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਮਿੰਟ ਵਿੱਚ",
			"other": "{0} ਮਿੰਟਾਂ ਵਿੱਚ"
		]
	],
	"second": [
		"current": "ਹੁਣ",
		"past": "{0} ਸਕਿੰਟ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਸਕਿੰਟ ਵਿੱਚ",
			"other": "{0} ਸਕਿੰਟਾਂ ਵਿੱਚ"
		]
	],
	"now": "ਹੁਣ"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ਪਿਛਲਾ ਸਾਲ",
		"current": "ਇਹ ਸਾਲ",
		"next": "ਅਗਲਾ ਸਾਲ",
		"past": "{0} ਸਾਲ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਸਾਲ ਵਿੱਚ",
			"other": "{0} ਸਾਲਾਂ ਵਿੱਚ"
		]
	],
	"quarter": [
		"previous": "ਪਿਛਲੀ ਤਿਮਾਹੀ",
		"current": "ਇਸ ਤਿਮਾਹੀ",
		"next": "ਅਗਲੀ ਤਿਮਾਹੀ",
		"past": [
			"one": "{0} ਤਿਮਾਹੀ ਪਹਿਲਾਂ",
			"other": "{0} ਤਿਮਾਹੀਆਂ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਤਿਮਾਹੀ ਵਿੱਚ",
			"other": "{0} ਤਿਮਾਹੀਆਂ ਵਿੱਚ"
		]
	],
	"month": [
		"previous": "ਪਿਛਲਾ ਮਹੀਨਾ",
		"current": "ਇਹ ਮਹੀਨਾ",
		"next": "ਅਗਲਾ ਮਹੀਨਾ",
		"past": [
			"one": "{0} ਮਹੀਨਾ ਪਹਿਲਾਂ",
			"other": "{0} ਮਹੀਨੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਮਹੀਨੇ ਵਿੱਚ",
			"other": "{0} ਮਹੀਨਿਆਂ ਵਿੱਚ"
		]
	],
	"week": [
		"previous": "ਪਿਛਲਾ ਹਫ਼ਤਾ",
		"current": "ਇਹ ਹਫ਼ਤਾ",
		"next": "ਅਗਲਾ ਹਫ਼ਤਾ",
		"past": [
			"one": "{0} ਹਫ਼ਤਾ ਪਹਿਲਾਂ",
			"other": "{0} ਹਫ਼ਤੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਹਫ਼ਤੇ ਵਿੱਚ",
			"other": "{0} ਹਫ਼ਤਿਆਂ ਵਿੱਚ"
		]
	],
	"day": [
		"previous": "ਬੀਤਿਆ ਕੱਲ੍ਹ",
		"current": "ਅੱਜ",
		"next": "ਭਲਕੇ",
		"past": "{0} ਦਿਨ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਦਿਨ ਵਿੱਚ",
			"other": "{0} ਦਿਨਾਂ ਵਿੱਚ"
		]
	],
	"hour": [
		"current": "ਇਸ ਘੰਟੇ",
		"past": [
			"one": "{0} ਘੰਟਾ ਪਹਿਲਾਂ",
			"other": "{0} ਘੰਟੇ ਪਹਿਲਾਂ"
		],
		"future": [
			"one": "{0} ਘੰਟੇ ਵਿੱਚ",
			"other": "{0} ਘੰਟਿਆਂ ਵਿੱਚ"
		]
	],
	"minute": [
		"current": "ਇਸ ਮਿੰਟ",
		"past": "{0} ਮਿੰਟ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਮਿੰਟ ਵਿੱਚ",
			"other": "{0} ਮਿੰਟਾਂ ਵਿੱਚ"
		]
	],
	"second": [
		"current": "ਹੁਣ",
		"past": "{0} ਸਕਿੰਟ ਪਹਿਲਾਂ",
		"future": [
			"one": "{0} ਸਕਿੰਟ ਵਿੱਚ",
			"other": "{0} ਸਕਿੰਟਾਂ ਵਿੱਚ"
		]
	],
	"now": "ਹੁਣ"
]
	}
}
