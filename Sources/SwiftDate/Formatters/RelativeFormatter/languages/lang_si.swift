import Foundation

// swiftlint:disable type_name
public class lang_si: RelativeFormatterLang {

	/// Sinhala
	public static let identifier: String = "si"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
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
		"previous": "පසුගිය වසර",
		"current": "මෙම වසර",
		"next": "ඊළඟ වසර",
		"past": "වසර {0}කට පෙර",
		"future": "වසර {0}කින්"
	],
	"quarter": [
		"previous": "පසුගිය කාර්.",
		"current": "මෙම කාර්.",
		"next": "ඊළඟ කාර්.",
		"past": "කාර්. {0}කට පෙර",
		"future": "කාර්. {0}කින්"
	],
	"month": [
		"previous": "පසුගිය මාස.",
		"current": "මෙම මාස.",
		"next": "ඊළඟ මාස.",
		"past": "මාස {0}කට පෙර",
		"future": "මාස {0}කින්"
	],
	"week": [
		"previous": "පසුගිය සති.",
		"current": "මෙම සති.",
		"next": "ඊළඟ සති.",
		"past": "සති {0}කට පෙර",
		"future": "සති {0}කින්"
	],
	"day": [
		"previous": "ඊයේ",
		"current": "අද",
		"next": "හෙට",
		"past": "දින {0}කට පෙර",
		"future": "දින {0}න්"
	],
	"hour": [
		"current": "මෙම පැය",
		"past": "පැය {0}කට පෙර",
		"future": "පැය {0}කින්"
	],
	"minute": [
		"current": "මෙම මිනිත්තුව",
		"past": "මිනිත්තු {0}කට පෙර",
		"future": "මිනිත්තු {0}කින්"
	],
	"second": [
		"current": "දැන්",
		"past": "තත්පර {0}කට පෙර",
		"future": "තත්පර {0}කින්"
	],
	"now": "දැන්"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "පසුගිය වසර",
		"current": "මෙම වසර",
		"next": "ඊළඟ වසර",
		"past": "වසර {0}කට පෙර",
		"future": "වසර {0}කින්"
	],
	"quarter": [
		"previous": "පසුගිය කාර්.",
		"current": "මෙම කාර්.",
		"next": "ඊළඟ කාර්.",
		"past": "කාර්. {0}කට පෙර",
		"future": "කාර්. {0}කින්"
	],
	"month": [
		"previous": "පසුගිය මාස.",
		"current": "මෙම මාස.",
		"next": "ඊළඟ මාස.",
		"past": "මාස {0}කට පෙර",
		"future": "මාස {0}කින්"
	],
	"week": [
		"previous": "පසුගිය සති.",
		"current": "මෙම සති.",
		"next": "ඊළඟ සති.",
		"past": "සති {0}කට පෙර",
		"future": "සති {0}කින්"
	],
	"day": [
		"previous": "ඊයේ",
		"current": "අද",
		"next": "හෙට",
		"past": "දින {0}කට පෙර",
		"future": "දින {0}න්"
	],
	"hour": [
		"current": "මෙම පැය",
		"past": "පැය {0}කට පෙර",
		"future": "පැය {0}කින්"
	],
	"minute": [
		"current": "මෙම මිනිත්තුව",
		"past": "මිනිත්තු {0}කට පෙර",
		"future": "මිනිත්තු {0}කින්"
	],
	"second": [
		"current": "දැන්",
		"past": "තත්පර {0}කට පෙර",
		"future": "තත්පර {0}කින්"
	],
	"now": "දැන්"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "පසුගිය වසර",
		"current": "මෙම වසර",
		"next": "ඊළඟ වසර",
		"past": "වසර {0}කට පෙර",
		"future": "වසර {0}කින්"
	],
	"quarter": [
		"previous": "පසුගිය කාර්තුව",
		"current": "මෙම කාර්තුව",
		"next": "ඊළඟ කාර්තුව",
		"past": "කාර්තු {0}කට පෙර",
		"future": "කාර්තු {0}කින්"
	],
	"month": [
		"previous": "පසුගිය මාසය",
		"current": "මෙම මාසය",
		"next": "ඊළඟ මාසය",
		"past": "මාස {0}කට පෙර",
		"future": "මාස {0}කින්"
	],
	"week": [
		"previous": "පසුගිය සතිය",
		"current": "මෙම සතිය",
		"next": "ඊළඟ සතිය",
		"past": "සති {0}කට පෙර",
		"future": "සති {0}කින්"
	],
	"day": [
		"previous": "ඊයේ",
		"current": "අද",
		"next": "හෙට",
		"past": "දින {0}කට පෙර",
		"future": "දින {0}න්"
	],
	"hour": [
		"current": "මෙම පැය",
		"past": "පැය {0}කට පෙර",
		"future": "පැය {0}කින්"
	],
	"minute": [
		"current": "මෙම මිනිත්තුව",
		"past": "මිනිත්තු {0}කට පෙර",
		"future": "මිනිත්තු {0}කින්"
	],
	"second": [
		"current": "දැන්",
		"past": "තත්පර {0}කට පෙර",
		"future": "තත්පර {0}කින්"
	],
	"now": "දැන්"
]
	}
}
