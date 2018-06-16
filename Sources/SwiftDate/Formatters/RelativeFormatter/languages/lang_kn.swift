import Foundation

// swiftlint:disable type_name
public class lang_kn: RelativeFormatterLang {

	/// Kannada
	public static let identifier: String = "kn"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value <= 1 ? .one : .other)
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
		"previous": "ಕಳೆದ ವರ್ಷ",
		"current": "ಈ ವರ್ಷ",
		"next": "ಮುಂದಿನ ವರ್ಷ",
		"past": [
			"one": "{0} ವರ್ಷದ ಹಿಂದೆ",
			"other": "{0} ವರ್ಷಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ವರ್ಷದಲ್ಲಿ",
			"other": "{0} ವರ್ಷಗಳಲ್ಲಿ"
		]
	],
	"quarter": [
		"previous": "ಕಳೆದ ತ್ರೈಮಾಸಿಕ",
		"current": "ಈ ತ್ರೈಮಾಸಿಕ",
		"next": "ಮುಂದಿನ ತ್ರೈಮಾಸಿಕ",
		"past": [
			"one": "{0} ತ್ರೈ.ಮಾ. ಹಿಂದೆ",
			"other": "{0} ತ್ರೈಮಾಸಿಕಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ತ್ರೈ.ಮಾ.ದಲ್ಲಿ",
			"other": "{0} ತ್ರೈಮಾಸಿಕಗಳಲ್ಲಿ"
		]
	],
	"month": [
		"previous": "ಕಳೆದ ತಿಂಗಳು",
		"current": "ಈ ತಿಂಗಳು",
		"next": "ಮುಂದಿನ ತಿಂಗಳು",
		"past": [
			"one": "{0} ತಿಂಗಳು ಹಿಂದೆ",
			"other": "{0} ತಿಂಗಳುಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ತಿಂಗಳಲ್ಲಿ",
			"other": "{0} ತಿಂಗಳುಗಳಲ್ಲಿ"
		]
	],
	"week": [
		"previous": "ಕಳೆದ ವಾರ",
		"current": "ಈ ವಾರ",
		"next": "ಮುಂದಿನ ವಾರ",
		"past": [
			"one": "{0} ವಾರದ ಹಿಂದೆ",
			"other": "{0} ವಾರಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ವಾರದಲ್ಲಿ",
			"other": "{0} ವಾರಗಳಲ್ಲಿ"
		]
	],
	"day": [
		"previous": "ನಿನ್ನೆ",
		"current": "ಇಂದು",
		"next": "ನಾಳೆ",
		"past": [
			"one": "{0} ದಿನದ ಹಿಂದೆ",
			"other": "{0} ದಿನಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ದಿನದಲ್ಲಿ",
			"other": "{0} ದಿನಗಳಲ್ಲಿ"
		]
	],
	"hour": [
		"current": "ಈ ಗಂಟೆ",
		"past": [
			"one": "{0} ಗಂಟೆ ಹಿಂದೆ",
			"other": "{0} ಗಂಟೆಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ಗಂಟೆಯಲ್ಲಿ",
			"other": "{0} ಗಂಟೆಗಳಲ್ಲಿ"
		]
	],
	"minute": [
		"current": "ಈ ನಿಮಿಷ",
		"past": [
			"one": "{0} ನಿಮಿಷದ ಹಿಂದೆ",
			"other": "{0} ನಿಮಿಷಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ನಿಮಿಷದಲ್ಲಿ",
			"other": "{0} ನಿಮಿಷಗಳಲ್ಲಿ"
		]
	],
	"second": [
		"current": "ಈಗ",
		"past": [
			"one": "{0} ಸೆಕೆಂಡ್ ಹಿಂದೆ",
			"other": "{0} ಸೆಕೆಂಡುಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ಸೆಕೆಂಡ್‌ನಲ್ಲಿ",
			"other": "{0} ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ"
		]
	],
	"now": "ಈಗ"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ಕಳೆದ ವರ್ಷ",
		"current": "ಈ ವರ್ಷ",
		"next": "ಮುಂದಿನ ವರ್ಷ",
		"past": [
			"one": "{0} ವರ್ಷದ ಹಿಂದೆ",
			"other": "{0} ವರ್ಷಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ವರ್ಷದಲ್ಲಿ",
			"other": "{0} ವರ್ಷಗಳಲ್ಲಿ"
		]
	],
	"quarter": [
		"previous": "ಕಳೆದ ತ್ರೈಮಾಸಿಕ",
		"current": "ಈ ತ್ರೈಮಾಸಿಕ",
		"next": "ಮುಂದಿನ ತ್ರೈಮಾಸಿಕ",
		"past": [
			"one": "{0} ತ್ರೈ.ಮಾ. ಹಿಂದೆ",
			"other": "{0} ತ್ರೈಮಾಸಿಕಗಳ ಹಿಂದೆ"
		],
		"future": "{0} ತ್ರೈಮಾಸಿಕಗಳಲ್ಲಿ"
	],
	"month": [
		"previous": "ಕಳೆದ ತಿಂಗಳು",
		"current": "ಈ ತಿಂಗಳು",
		"next": "ಮುಂದಿನ ತಿಂಗಳು",
		"past": [
			"one": "{0} ತಿಂಗಳ ಹಿಂದೆ",
			"other": "{0} ತಿಂಗಳುಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ತಿಂಗಳಲ್ಲಿ",
			"other": "{0} ತಿಂಗಳುಗಳಲ್ಲಿ"
		]
	],
	"week": [
		"previous": "ಕಳೆದ ವಾರ",
		"current": "ಈ ವಾರ",
		"next": "ಮುಂದಿನ ವಾರ",
		"past": [
			"one": "{0} ವಾರದ ಹಿಂದೆ",
			"other": "{0} ವಾರಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ವಾರದಲ್ಲಿ",
			"other": "{0} ವಾರಗಳಲ್ಲಿ"
		]
	],
	"day": [
		"previous": "ನಿನ್ನೆ",
		"current": "ಇಂದು",
		"next": "ನಾಳೆ",
		"past": [
			"one": "{0} ದಿನದ ಹಿಂದೆ",
			"other": "{0} ದಿನಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ದಿನದಲ್ಲಿ",
			"other": "{0} ದಿನಗಳಲ್ಲಿ"
		]
	],
	"hour": [
		"current": "ಈ ಗಂಟೆ",
		"past": [
			"one": "{0} ಗಂಟೆ ಹಿಂದೆ",
			"other": "{0} ಗಂಟೆಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ಗಂಟೆಯಲ್ಲಿ",
			"other": "{0} ಗಂಟೆಗಳಲ್ಲಿ"
		]
	],
	"minute": [
		"current": "ಈ ನಿಮಿಷ",
		"past": [
			"one": "{0} ನಿಮಿಷದ ಹಿಂದೆ",
			"other": "{0} ನಿಮಿಷಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ನಿಮಿಷದಲ್ಲಿ",
			"other": "{0} ನಿಮಿಷಗಳಲ್ಲಿ"
		]
	],
	"second": [
		"current": "ಈಗ",
		"past": [
			"one": "{0} ಸೆಕೆಂಡ್ ಹಿಂದೆ",
			"other": "{0} ಸೆಕೆಂಡುಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ಸೆಕೆಂಡ್‌ನಲ್ಲಿ",
			"other": "{0} ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ"
		]
	],
	"now": "ಈಗ"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ಹಿಂದಿನ ವರ್ಷ",
		"current": "ಈ ವರ್ಷ",
		"next": "ಮುಂದಿನ ವರ್ಷ",
		"past": [
			"one": "{0} ವರ್ಷದ ಹಿಂದೆ",
			"other": "{0} ವರ್ಷಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ವರ್ಷದಲ್ಲಿ",
			"other": "{0} ವರ್ಷಗಳಲ್ಲಿ"
		]
	],
	"quarter": [
		"previous": "ಹಿಂದಿನ ತ್ರೈಮಾಸಿಕ",
		"current": "ಈ ತ್ರೈಮಾಸಿಕ",
		"next": "ಮುಂದಿನ ತ್ರೈಮಾಸಿಕ",
		"past": [
			"one": "{0} ತ್ರೈಮಾಸಿಕದ ಹಿಂದೆ",
			"other": "{0} ತ್ರೈಮಾಸಿಕಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ತ್ರೈಮಾಸಿಕದಲ್ಲಿ",
			"other": "{0} ತ್ರೈಮಾಸಿಕಗಳಲ್ಲಿ"
		]
	],
	"month": [
		"previous": "ಕಳೆದ ತಿಂಗಳು",
		"current": "ಈ ತಿಂಗಳು",
		"next": "ಮುಂದಿನ ತಿಂಗಳು",
		"past": [
			"one": "{0} ತಿಂಗಳ ಹಿಂದೆ",
			"other": "{0} ತಿಂಗಳುಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ತಿಂಗಳಲ್ಲಿ",
			"other": "{0} ತಿಂಗಳುಗಳಲ್ಲಿ"
		]
	],
	"week": [
		"previous": "ಕಳೆದ ವಾರ",
		"current": "ಈ ವಾರ",
		"next": "ಮುಂದಿನ ವಾರ",
		"past": [
			"one": "{0} ವಾರದ ಹಿಂದೆ",
			"other": "{0} ವಾರಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ವಾರದಲ್ಲಿ",
			"other": "{0} ವಾರಗಳಲ್ಲಿ"
		]
	],
	"day": [
		"previous": "ನಿನ್ನೆ",
		"current": "ಇಂದು",
		"next": "ನಾಳೆ",
		"past": [
			"one": "{0} ದಿನದ ಹಿಂದೆ",
			"other": "{0} ದಿನಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ದಿನದಲ್ಲಿ",
			"other": "{0} ದಿನಗಳಲ್ಲಿ"
		]
	],
	"hour": [
		"current": "ಈ ಗಂಟೆ",
		"past": [
			"one": "{0} ಗಂಟೆ ಹಿಂದೆ",
			"other": "{0} ಗಂಟೆಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ಗಂಟೆಯಲ್ಲಿ",
			"other": "{0} ಗಂಟೆಗಳಲ್ಲಿ"
		]
	],
	"minute": [
		"current": "ಈ ನಿಮಿಷ",
		"past": [
			"one": "{0} ನಿಮಿಷದ ಹಿಂದೆ",
			"other": "{0} ನಿಮಿಷಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ನಿಮಿಷದಲ್ಲಿ",
			"other": "{0} ನಿಮಿಷಗಳಲ್ಲಿ"
		]
	],
	"second": [
		"current": "ಈಗ",
		"past": [
			"one": "{0} ಸೆಕೆಂಡ್ ಹಿಂದೆ",
			"other": "{0} ಸೆಕೆಂಡುಗಳ ಹಿಂದೆ"
		],
		"future": [
			"one": "{0} ಸೆಕೆಂಡ್‌ನಲ್ಲಿ",
			"other": "{0} ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ"
		]
	],
	"now": "ಈಗ"
]
	}
}
