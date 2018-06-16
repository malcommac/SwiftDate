import Foundation

// swiftlint:disable type_name
public class lang_gu: RelativeFormatterLang {

	/// Gujarati
	public static let identifier: String = "gu"

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
		"previous": "ગયા વર્ષે",
		"current": "આ વર્ષે",
		"next": "આવતા વર્ષે",
		"past": "{0} વર્ષ પહેલાં",
		"future": "{0} વર્ષમાં"
	],
	"quarter": [
		"previous": "છેલ્લું ત્રિમાસિક",
		"current": "આ ત્રિમાસિક",
		"next": "પછીનું ત્રિમાસિક",
		"past": "{0} ત્રિમાસિક પહેલાં",
		"future": "{0} ત્રિમાસિકમાં"
	],
	"month": [
		"previous": "ગયા મહિને",
		"current": "આ મહિને",
		"next": "આવતા મહિને",
		"past": "{0} મહિના પહેલાં",
		"future": "{0} મહિનામાં"
	],
	"week": [
		"previous": "ગયા અઠવાડિયે",
		"current": "આ અઠવાડિયે",
		"next": "આવતા અઠવાડિયે",
		"past": "{0} અઠ. પહેલાં",
		"future": "{0} અઠ. માં"
	],
	"day": [
		"previous": "ગઈકાલે",
		"current": "આજે",
		"next": "આવતીકાલે",
		"past": "{0} દિવસ પહેલાં",
		"future": "{0} દિવસમાં"
	],
	"hour": [
		"current": "આ કલાક",
		"past": "{0} કલાક પહેલાં",
		"future": "{0} કલાકમાં"
	],
	"minute": [
		"current": "આ મિનિટ",
		"past": "{0} મિનિટ પહેલાં",
		"future": "{0} મિનિટમાં"
	],
	"second": [
		"current": "હમણાં",
		"past": "{0} સેકંડ પહેલાં",
		"future": "{0} સેકંડમાં"
	],
	"now": "હમણાં"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ગયા વર્ષે",
		"current": "આ વર્ષે",
		"next": "આવતા વર્ષે",
		"past": "{0} વર્ષ પહેલાં",
		"future": "{0} વર્ષમાં"
	],
	"quarter": [
		"previous": "છેલ્લું ત્રિમાસિક",
		"current": "આ ત્રિમાસિક",
		"next": "પછીનું ત્રિમાસિક",
		"past": "{0} ત્રિમાસિક પહેલાં",
		"future": "{0} ત્રિમાસિકમાં"
	],
	"month": [
		"previous": "ગયા મહિને",
		"current": "આ મહિને",
		"next": "આવતા મહિને",
		"past": "{0} મહિના પહેલાં",
		"future": "{0} મહિનામાં"
	],
	"week": [
		"previous": "ગયા અઠવાડિયે",
		"current": "આ અઠવાડિયે",
		"next": "આવતા અઠવાડિયે",
		"past": "{0} અઠ. પહેલાં",
		"future": "{0} અઠ. માં"
	],
	"day": [
		"previous": "ગઈકાલે",
		"current": "આજે",
		"next": "આવતીકાલે",
		"past": "{0} દિવસ પહેલાં",
		"future": "{0} દિવસમાં"
	],
	"hour": [
		"current": "આ કલાક",
		"past": "{0} કલાક પહેલાં",
		"future": "{0} કલાકમાં"
	],
	"minute": [
		"current": "આ મિનિટ",
		"past": "{0} મિનિટ પહેલાં",
		"future": "{0} મિનિટમાં"
	],
	"second": [
		"current": "હમણાં",
		"past": "{0} સેકંડ પહેલાં",
		"future": "{0} સેકંડમાં"
	],
	"now": "હમણાં"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ગયા વર્ષે",
		"current": "આ વર્ષે",
		"next": "આવતા વર્ષે",
		"past": "{0} વર્ષ પહેલાં",
		"future": "{0} વર્ષમાં"
	],
	"quarter": [
		"previous": "છેલ્લું ત્રિમાસિક",
		"current": "આ ત્રિમાસિક",
		"next": "પછીનું ત્રિમાસિક",
		"past": "{0} ત્રિમાસિક પહેલાં",
		"future": "{0} ત્રિમાસિકમાં"
	],
	"month": [
		"previous": "ગયા મહિને",
		"current": "આ મહિને",
		"next": "આવતા મહિને",
		"past": "{0} મહિના પહેલાં",
		"future": "{0} મહિનામાં"
	],
	"week": [
		"previous": "ગયા અઠવાડિયે",
		"current": "આ અઠવાડિયે",
		"next": "આવતા અઠવાડિયે",
		"past": "{0} અઠવાડિયા પહેલાં",
		"future": "{0} અઠવાડિયામાં"
	],
	"day": [
		"previous": "ગઈકાલે",
		"current": "આજે",
		"next": "આવતીકાલે",
		"past": "{0} દિવસ પહેલાં",
		"future": "{0} દિવસમાં"
	],
	"hour": [
		"current": "આ કલાક",
		"past": "{0} કલાક પહેલાં",
		"future": "{0} કલાકમાં"
	],
	"minute": [
		"current": "આ મિનિટ",
		"past": "{0} મિનિટ પહેલાં",
		"future": "{0} મિનિટમાં"
	],
	"second": [
		"current": "હમણાં",
		"past": "{0} સેકંડ પહેલાં",
		"future": "{0} સેકંડમાં"
	],
	"now": "હમણાં"
]
	}
}
