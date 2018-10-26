import Foundation

// swiftlint:disable type_name
public class lang_hy: RelativeFormatterLang {

	/// Armenian
	public static let identifier: String = "hy"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value < 2 ? .one : .other)
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
		"previous": "նախորդ տարի",
		"current": "այս տարի",
		"next": "հաջորդ տարի",
		"past": "{0} տ առաջ",
		"future": "{0} տարուց"
	],
	"quarter": [
		"previous": "նախորդ եռամսյակ",
		"current": "այս եռամսյակ",
		"next": "հաջորդ եռամսյակ",
		"past": "{0} եռմս առաջ",
		"future": "{0} եռմս-ից"
	],
	"month": [
		"previous": "անցյալ ամիս",
		"current": "այս ամիս",
		"next": "հաջորդ ամիս",
		"past": "{0} ամիս առաջ",
		"future": "{0} ամսից"
	],
	"week": [
		"previous": "նախորդ շաբաթ",
		"current": "այս շաբաթ",
		"next": "հաջորդ շաբաթ",
		"past": "{0} շաբ առաջ",
		"future": "{0} շաբ-ից"
	],
	"day": [
		"previous": "երեկ",
		"current": "այսօր",
		"next": "վաղը",
		"past": "{0} օր առաջ",
		"future": "{0} օրից"
	],
	"hour": [
		"current": "այս ժամին",
		"past": "{0} ժ առաջ",
		"future": "{0} ժ-ից"
	],
	"minute": [
		"current": "այս րոպեին",
		"past": "{0} ր առաջ",
		"future": "{0} ր-ից"
	],
	"second": [
		"current": "հիմա",
		"past": "{0} վրկ առաջ",
		"future": "{0} վրկ-ից"
	],
	"now": "հիմա"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "նախորդ տարի",
		"current": "այս տարի",
		"next": "հաջորդ տարի",
		"past": "{0} տ առաջ",
		"future": "{0} տարուց"
	],
	"quarter": [
		"previous": "նախորդ եռամսյակ",
		"current": "այս եռամսյակ",
		"next": "հաջորդ եռամսյակ",
		"past": "{0} եռմս առաջ",
		"future": "{0} եռմս-ից"
	],
	"month": [
		"previous": "անցյալ ամիս",
		"current": "այս ամիս",
		"next": "հաջորդ ամիս",
		"past": "{0} ամիս առաջ",
		"future": "{0} ամսից"
	],
	"week": [
		"previous": "նախորդ շաբաթ",
		"current": "այս շաբաթ",
		"next": "հաջորդ շաբաթ",
		"past": "{0} շաբ առաջ",
		"future": "{0} շաբ անց"
	],
	"day": [
		"previous": "երեկ",
		"current": "այսօր",
		"next": "վաղը",
		"past": "{0} օր առաջ",
		"future": "{0} օրից"
	],
	"hour": [
		"current": "այս ժամին",
		"past": "{0} ժ առաջ",
		"future": "{0} ժ-ից"
	],
	"minute": [
		"current": "այս րոպեին",
		"past": "{0} ր առաջ",
		"future": "{0} ր-ից"
	],
	"second": [
		"current": "հիմա",
		"past": "{0} վ առաջ",
		"future": "{0} վ-ից"
	],
	"now": "հիմա"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "նախորդ տարի",
		"current": "այս տարի",
		"next": "հաջորդ տարի",
		"past": "{0} տարի առաջ",
		"future": "{0} տարուց"
	],
	"quarter": [
		"previous": "նախորդ եռամսյակ",
		"current": "այս եռամսյակ",
		"next": "հաջորդ եռամսյակ",
		"past": "{0} եռամսյակ առաջ",
		"future": "{0} եռամսյակից"
	],
	"month": [
		"previous": "նախորդ ամիս",
		"current": "այս ամիս",
		"next": "հաջորդ ամիս",
		"past": "{0} ամիս առաջ",
		"future": "{0} ամսից"
	],
	"week": [
		"previous": "նախորդ շաբաթ",
		"current": "այս շաբաթ",
		"next": "հաջորդ շաբաթ",
		"past": "{0} շաբաթ առաջ",
		"future": "{0} շաբաթից"
	],
	"day": [
		"previous": "երեկ",
		"current": "այսօր",
		"next": "վաղը",
		"past": "{0} օր առաջ",
		"future": "{0} օրից"
	],
	"hour": [
		"current": "այս ժամին",
		"past": "{0} ժամ առաջ",
		"future": "{0} ժամից"
	],
	"minute": [
		"current": "այս րոպեին",
		"past": "{0} րոպե առաջ",
		"future": "{0} րոպեից"
	],
	"second": [
		"current": "հիմա",
		"past": "{0} վայրկյան առաջ",
		"future": "{0} վայրկյանից"
	],
	"now": "հիմա"
]
	}
}
