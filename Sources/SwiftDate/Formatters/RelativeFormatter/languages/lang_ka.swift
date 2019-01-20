import Foundation

// swiftlint:disable type_name
public class lang_ka: RelativeFormatterLang {

	/// Georgian
	public static let identifier: String = "ka"

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
		"previous": "გასულ წელს",
		"current": "ამ წელს",
		"next": "მომავალ წელს",
		"past": "{0} წლის წინ",
		"future": "{0} წელში"
	],
	"quarter": [
		"previous": "გასულ კვარტალში",
		"current": "ამ კვარტალში",
		"next": "შემდეგ კვარტალში",
		"past": "{0} კვარტ. წინ",
		"future": "{0} კვარტალში"
	],
	"month": [
		"previous": "გასულ თვეს",
		"current": "ამ თვეში",
		"next": "მომავალ თვეს",
		"past": "{0} თვის წინ",
		"future": "{0} თვეში"
	],
	"week": [
		"previous": "გასულ კვირაში",
		"current": "ამ კვირაში",
		"next": "მომავალ კვირაში",
		"past": "{0} კვ. წინ",
		"future": "{0} კვირაში"
	],
	"day": [
		"previous": "გუშინ",
		"current": "დღეს",
		"next": "ხვალ",
		"past": "{0} დღის წინ",
		"future": "{0} დღეში"
	],
	"hour": [
		"current": "ამ საათში",
		"past": "{0} სთ წინ",
		"future": "{0} საათში"
	],
	"minute": [
		"current": "ამ წუთში",
		"past": "{0} წთ წინ",
		"future": "{0} წუთში"
	],
	"second": [
		"current": "ახლა",
		"past": "{0} წმ წინ",
		"future": "{0} წამში"
	],
	"now": "ახლა"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "გასულ წელს",
		"current": "ამ წელს",
		"next": "მომავალ წელს",
		"past": "{0} წლის წინ",
		"future": "{0} წელში"
	],
	"quarter": [
		"previous": "გასულ კვარტალში",
		"current": "ამ კვარტალში",
		"next": "შემდეგ კვარტალში",
		"past": "{0} კვარტ. წინ",
		"future": "{0} კვარტალში"
	],
	"month": [
		"previous": "გასულ თვეს",
		"current": "ამ თვეში",
		"next": "მომავალ თვეს",
		"past": "{0} თვის წინ",
		"future": "{0} თვეში"
	],
	"week": [
		"previous": "გასულ კვირაში",
		"current": "ამ კვირაში",
		"next": "მომავალ კვირაში",
		"past": "{0} კვირის წინ",
		"future": "{0} კვირაში"
	],
	"day": [
		"previous": "გუშინ",
		"current": "დღეს",
		"next": "ხვალ",
		"past": "{0} დღის წინ",
		"future": "{0} დღეში"
	],
	"hour": [
		"current": "ამ საათში",
		"past": "{0} სთ წინ",
		"future": "{0} საათში"
	],
	"minute": [
		"current": "ამ წუთში",
		"past": "{0} წთ წინ",
		"future": "{0} წუთში"
	],
	"second": [
		"current": "ახლა",
		"past": "{0} წმ წინ",
		"future": "{0} წამში"
	],
	"now": "ახლა"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "გასულ წელს",
		"current": "ამ წელს",
		"next": "მომავალ წელს",
		"past": "{0} წლის წინ",
		"future": "{0} წელიწადში"
	],
	"quarter": [
		"previous": "გასულ კვარტალში",
		"current": "ამ კვარტალში",
		"next": "შემდეგ კვარტალში",
		"past": "{0} კვარტალის წინ",
		"future": "{0} კვარტალში"
	],
	"month": [
		"previous": "გასულ თვეს",
		"current": "ამ თვეში",
		"next": "მომავალ თვეს",
		"past": "{0} თვის წინ",
		"future": "{0} თვეში"
	],
	"week": [
		"previous": "გასულ კვირაში",
		"current": "ამ კვირაში",
		"next": "მომავალ კვირაში",
		"past": "{0} კვირის წინ",
		"future": "{0} კვირაში"
	],
	"day": [
		"previous": "გუშინ",
		"current": "დღეს",
		"next": "ხვალ",
		"past": "{0} დღის წინ",
		"future": "{0} დღეში"
	],
	"hour": [
		"current": "ამ საათში",
		"past": "{0} საათის წინ",
		"future": "{0} საათში"
	],
	"minute": [
		"current": "ამ წუთში",
		"past": "{0} წუთის წინ",
		"future": "{0} წუთში"
	],
	"second": [
		"current": "ახლა",
		"past": "{0} წამის წინ",
		"future": "{0} წამში"
	],
	"now": "ახლა"
]
	}
}
