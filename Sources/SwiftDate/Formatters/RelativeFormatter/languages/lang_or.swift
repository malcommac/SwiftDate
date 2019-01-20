import Foundation

// swiftlint:disable type_name
public class lang_or: RelativeFormatterLang {

	/// Odia
	public static let identifier: String = "or"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
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
		"previous": "ଗତ ବର୍ଷ",
		"current": "ଏହି ବର୍ଷ",
		"next": "ଆଗାମୀ ବର୍ଷ",
		"past": "{0} ବ. ପୂର୍ବେ",
		"future": "{0} ବ. ରେ"
	],
	"quarter": [
		"previous": "ଗତ ତ୍ରୟମାସ",
		"current": "ଗତ ତ୍ରୟମାସ",
		"next": "ଆଗାମୀ ତ୍ରୟମାସ",
		"past": "{0} ତ୍ରୟ. ପୂର୍ବେ",
		"future": "{0} ତ୍ରୟ. ରେ"
	],
	"month": [
		"previous": "ଗତ ମାସ",
		"current": "ଏହି ମାସ",
		"next": "ଆଗାମୀ ମାସ",
		"past": "{0} ମା. ପୂର୍ବେ",
		"future": "{0} ମା. ରେ"
	],
	"week": [
		"previous": "ଗତ ସପ୍ତାହ",
		"current": "ଏହି ସପ୍ତାହ",
		"next": "ଆଗାମୀ ସପ୍ତାହ",
		"past": "{0} ସପ୍ତା. ପୂର୍ବେ",
		"future": "{0} ସପ୍ତା. ରେ"
	],
	"day": [
		"previous": "ଗତକାଲି",
		"current": "ଆଜି",
		"next": "ଆସନ୍ତାକାଲି",
		"past": "{0} ଦିନ ପୂର୍ବେ",
		"future": "{0} ଦିନରେ"
	],
	"hour": [
		"current": "ଏହି ଘଣ୍ଟା",
		"past": "{0} ଘ. ପୂର୍ବେ",
		"future": "{0} ଘ. ରେ"
	],
	"minute": [
		"current": "ଏହି ମିନିଟ୍",
		"past": "{0} ମି. ପୂର୍ବେ",
		"future": "{0} ମି. ରେ"
	],
	"second": [
		"current": "ବର୍ତ୍ତମାନ",
		"past": "{0} ସେ. ପୂର୍ବେ",
		"future": "{0} ସେ. ରେ"
	],
	"now": "ବର୍ତ୍ତମାନ"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ଗତ ବର୍ଷ",
		"current": "ଏହି ବର୍ଷ",
		"next": "ଆଗାମୀ ବର୍ଷ",
		"past": "{0} ବ. ପୂର୍ବେ",
		"future": "{0} ବ. ରେ"
	],
	"quarter": [
		"previous": "ଗତ ତ୍ରୟମାସ",
		"current": "ଗତ ତ୍ରୟମାସ",
		"next": "ଆଗାମୀ ତ୍ରୟମାସ",
		"past": "{0} ତ୍ରୟ. ପୂର୍ବେ",
		"future": "{0} ତ୍ରୟ. ରେ"
	],
	"month": [
		"previous": "ଗତ ମାସ",
		"current": "ଏହି ମାସ",
		"next": "ଆଗାମୀ ମାସ",
		"past": "{0} ମା. ପୂର୍ବେ",
		"future": "{0} ମା. ରେ"
	],
	"week": [
		"previous": "ଗତ ସପ୍ତାହ",
		"current": "ଏହି ସପ୍ତାହ",
		"next": "ଆଗାମୀ ସପ୍ତାହ",
		"past": "{0} ସପ୍ତା. ପୂର୍ବେ",
		"future": "{0} ସପ୍ତା. ରେ"
	],
	"day": [
		"previous": "ଗତକାଲି",
		"current": "ଆଜି",
		"next": "ଆସନ୍ତାକାଲି",
		"past": "{0} ଦିନ ପୂର୍ବେ",
		"future": "{0} ଦିନରେ"
	],
	"hour": [
		"current": "ଏହି ଘଣ୍ଟା",
		"past": "{0} ଘ. ପୂର୍ବେ",
		"future": "{0} ଘ. ରେ"
	],
	"minute": [
		"current": "ଏହି ମିନିଟ୍",
		"past": "{0} ମି. ପୂର୍ବେ",
		"future": "{0} ମି. ରେ"
	],
	"second": [
		"current": "ବର୍ତ୍ତମାନ",
		"past": "{0} ସେ. ପୂର୍ବେ",
		"future": "{0} ସେ. ରେ"
	],
	"now": "ବର୍ତ୍ତମାନ"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ଗତ ବର୍ଷ",
		"current": "ଏହି ବର୍ଷ",
		"next": "ଆଗାମୀ ବର୍ଷ",
		"past": "{0} ବର୍ଷ ପୂର୍ବେ",
		"future": "{0} ବର୍ଷରେ"
	],
	"quarter": [
		"previous": "ଗତ ତ୍ରୟମାସ",
		"current": "ଗତ ତ୍ରୟମାସ",
		"next": "ଆଗାମୀ ତ୍ରୟମାସ",
		"past": "{0} ତ୍ରୟମାସ ପୂର୍ବେ",
		"future": "{0} ତ୍ରୟମାସରେ"
	],
	"month": [
		"previous": "ଗତ ମାସ",
		"current": "ଏହି ମାସ",
		"next": "ଆଗାମୀ ମାସ",
		"past": "{0} ମାସ ପୂର୍ବେ",
		"future": "{0} ମାସରେ"
	],
	"week": [
		"previous": "ଗତ ସପ୍ତାହ",
		"current": "ଏହି ସପ୍ତାହ",
		"next": "ଆଗାମୀ ସପ୍ତାହ",
		"past": [
			"one": "{0} ସପ୍ତାହରେ",
			"other": "{0} ସପ୍ତାହ ପୂର୍ବେ"
		],
		"future": "{0} ସପ୍ତାହରେ"
	],
	"day": [
		"previous": "ଗତକାଲି",
		"current": "ଆଜି",
		"next": "ଆସନ୍ତାକାଲି",
		"past": "{0} ଦିନ ପୂର୍ବେ",
		"future": "{0} ଦିନରେ"
	],
	"hour": [
		"current": "ଏହି ଘଣ୍ଟା",
		"past": "{0} ଘଣ୍ଟା ପୂର୍ବେ",
		"future": "{0} ଘଣ୍ଟାରେ"
	],
	"minute": [
		"current": "ଏହି ମିନିଟ୍",
		"past": "{0} ମିନିଟ୍ ପୂର୍ବେ",
		"future": "{0} ମିନିଟ୍‌‌ରେ"
	],
	"second": [
		"current": "ବର୍ତ୍ତମାନ",
		"past": "{0} ସେକେଣ୍ଡ ପୂର୍ବେ",
		"future": "{0} ସେକେଣ୍ଡରେ"
	],
	"now": "ବର୍ତ୍ତମାନ"
]
	}
}
