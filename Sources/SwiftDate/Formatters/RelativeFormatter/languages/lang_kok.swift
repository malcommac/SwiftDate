import Foundation

// swiftlint:disable type_name
public class lang_kok: RelativeFormatterLang {

	/// Konkani
	public static let identifier: String = "kok"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return nil
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
		"previous": "फाटलें वर्स",
		"current": "हें वर्स",
		"next": "फुडलें वर्स",
		"past": "{0} वर्स आदीं",
		"future": "{0} वर्सांनीं"
	],
	"quarter": [
		"previous": "फाटलो त्रैमासीक",
		"current": "हो त्रैमासीक",
		"next": "फुडलो त्रैमासीक",
		"past": "{0} त्रैमासीकां आदीं",
		"future": "{0} त्रैमासीकांत"
	],
	"month": [
		"previous": "फाटलो म्हयनो",
		"current": "हो म्हयनो",
		"next": "फुडलो म्हयनो",
		"past": "{0} म्हयन्यां आदीं",
		"future": "{0} म्हयन्यानीं"
	],
	"week": [
		"previous": "निमाणो सप्तक",
		"current": "हो सप्तक",
		"next": "फुडलो सप्तक",
		"past": "{0} सप्तकां आदीं",
		"future": "{0} सप्त."
	],
	"day": [
		"previous": "काल",
		"current": "आयज",
		"next": "फाल्यां",
		"past": "{0} दीस आदीं",
		"future": "{0} दिसानीं"
	],
	"hour": [
		"current": "हें वर",
		"past": "{0} वरा आदीं",
		"future": "{0} वरांनीं"
	],
	"minute": [
		"current": "हें मिनीट",
		"past": "{0} मिन्टां आदीं",
		"future": "{0} मिन्टां"
	],
	"second": [
		"current": "आतां",
		"past": "{0} से. आदीं",
		"future": "{0} सेकंदानीं"
	],
	"now": "आतां"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "फाटलें वर्स",
		"current": "हें वर्स",
		"next": "फुडलें वर्स",
		"past": "{0} वर्स आदीं",
		"future": "{0} वर्सांनीं"
	],
	"quarter": [
		"previous": "फाटलो त्रैमासीक",
		"current": "हो त्रैमासीक",
		"next": "फुडलो त्रैमासीक",
		"past": "{0} त्रैमासीकां आदीं",
		"future": "{0} त्रैमासीकांत"
	],
	"month": [
		"previous": "फाटलो म्हयनो",
		"current": "हो म्हयनो",
		"next": "फुडलो म्हयनो",
		"past": "{0} म्हयन्यां आदीं",
		"future": "{0} म्हयन्यानीं"
	],
	"week": [
		"previous": "निमाणो सप्तक",
		"current": "हो सप्तक",
		"next": "फुडलो सप्तक",
		"past": "{0} सप्त. आदीं",
		"future": "{0} सप्तकांनीं"
	],
	"day": [
		"previous": "काल",
		"current": "आयज",
		"next": "फाल्यां",
		"past": "{0} दीस आदीं",
		"future": "{0} दिसानीं"
	],
	"hour": [
		"current": "हें वर",
		"past": "{0} वरा आदीं",
		"future": "{0} वरांनीं"
	],
	"minute": [
		"current": "हें मिनीट",
		"past": "{0} मिन्टां आदीं",
		"future": "{0} मिन्टां"
	],
	"second": [
		"current": "आतां",
		"past": "{0} से. आदीं",
		"future": "{0} सेकंदानीं"
	],
	"now": "आतां"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "फाटलें वर्स",
		"current": "हें वर्स",
		"next": "फुडलें वर्स",
		"past": "{0} वर्सां आदीं",
		"future": "{0} वर्सांनीं"
	],
	"quarter": [
		"previous": "फाटलो त्रैमासीक",
		"current": "हो त्रैमासीक",
		"next": "फुडलो त्रैमासीक",
		"past": "{0} त्रैमासीकां आदीं",
		"future": "{0} त्रैमासीकांत"
	],
	"month": [
		"previous": "फाटलो म्हयनो",
		"current": "हो म्हयनो",
		"next": "फुडलो म्हयनो",
		"past": "{0} म्हयन्यां आदीं",
		"future": "{0} म्हयन्यानीं"
	],
	"week": [
		"previous": "निमाणो सप्तक",
		"current": "हो सप्तक",
		"next": "फुडलो सप्तक",
		"past": "{0} सप्तकां आदीं",
		"future": "{0} सप्तकांनीं"
	],
	"day": [
		"previous": "काल",
		"current": "आयज",
		"next": "फाल्यां",
		"past": "{0} दीस आदीं",
		"future": "{0} दिसानीं"
	],
	"hour": [
		"current": "हें वर",
		"past": "{0} वरा आदीं",
		"future": "{0} वरांनीं"
	],
	"minute": [
		"current": "हें मिनीट",
		"past": "{0} मिन्टां आदीं",
		"future": "{0} मिन्टां"
	],
	"second": [
		"current": "आतां",
		"past": "{0} सेकंद आदीं",
		"future": "{0} सेकंदानीं"
	],
	"now": "आतां"
]
	}
}
