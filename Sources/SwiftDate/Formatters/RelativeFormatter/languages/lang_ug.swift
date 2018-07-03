import Foundation

// swiftlint:disable type_name
public class lang_ug: RelativeFormatterLang {

	/// Uyghur
	public static let identifier: String = "ug"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
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
		"previous": "ئۆتكەن يىل",
		"current": "بۇ يىل",
		"next": "كېلەر يىل",
		"past": "{0} يىل ئىلگىرى",
		"future": "{0} يىلدىن كېيىن"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "ئۆتكەن ئاي",
		"current": "بۇ ئاي",
		"next": "كېلەر ئاي",
		"past": "{0} ئاي ئىلگىرى",
		"future": "{0} ئايدىن كېيىن"
	],
	"week": [
		"previous": "ئۆتكەن ھەپتە",
		"current": "بۇ ھەپتە",
		"next": "كېلەر ھەپتە",
		"past": "{0} ھەپتە ئىلگىرى",
		"future": "{0} ھەپتىدىن كېيىن"
	],
	"day": [
		"previous": "تۈنۈگۈن",
		"current": "بۈگۈن",
		"next": "ئەتە",
		"past": "{0} كۈن ئىلگىرى",
		"future": "{0} كۈندىن كېيىن"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} سائەت ئىلگىرى",
		"future": "{0} سائەتتىن كېيىن"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} مىنۇت ئىلگىرى",
		"future": "{0} مىنۇتتىن كېيىن"
	],
	"second": [
		"current": "now",
		"past": "{0} سېكۇنت ئىلگىرى",
		"future": "{0} سېكۇنتتىن كېيىن"
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ئۆتكەن يىل",
		"current": "بۇ يىل",
		"next": "كېلەر يىل",
		"past": "{0} يىل ئىلگىرى",
		"future": "{0} يىلدىن كېيىن"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "ئۆتكەن ئاي",
		"current": "بۇ ئاي",
		"next": "كېلەر ئاي",
		"past": "{0} ئاي ئىلگىرى",
		"future": "{0} ئايدىن كېيىن"
	],
	"week": [
		"previous": "ئۆتكەن ھەپتە",
		"current": "بۇ ھەپتە",
		"next": "كېلەر ھەپتە",
		"past": "{0} ھەپتە ئىلگىرى",
		"future": "{0} ھەپتىدىن كېيىن"
	],
	"day": [
		"previous": "تۈنۈگۈن",
		"current": "بۈگۈن",
		"next": "ئەتە",
		"past": "{0} كۈن ئىلگىرى",
		"future": "{0} كۈندىن كېيىن"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} سائەت ئىلگىرى",
		"future": "{0} سائەتتىن كېيىن"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} مىنۇت ئىلگىرى",
		"future": "{0} مىنۇتتىن كېيىن"
	],
	"second": [
		"current": "now",
		"past": "{0} سېكۇنت ئىلگىرى",
		"future": "{0} سېكۇنتتىن كېيىن"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ئۆتكەن يىل",
		"current": "بۇ يىل",
		"next": "كېلەر يىل",
		"past": "{0} يىل ئىلگىرى",
		"future": "{0} يىلدىن كېيىن"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "ئۆتكەن ئاي",
		"current": "بۇ ئاي",
		"next": "كېلەر ئاي",
		"past": "{0} ئاي ئىلگىرى",
		"future": "{0} ئايدىن كېيىن"
	],
	"week": [
		"previous": "ئۆتكەن ھەپتە",
		"current": "بۇ ھەپتە",
		"next": "كېلەر ھەپتە",
		"past": "{0} ھەپتە ئىلگىرى",
		"future": "{0} ھەپتىدىن كېيىن"
	],
	"day": [
		"previous": "تۈنۈگۈن",
		"current": "بۈگۈن",
		"next": "ئەتە",
		"past": "{0} كۈن ئىلگىرى",
		"future": "{0} كۈندىن كېيىن"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} سائەت ئىلگىرى",
		"future": "{0} سائەتتىن كېيىن"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} مىنۇت ئىلگىرى",
		"future": "{0} مىنۇتتىن كېيىن"
	],
	"second": [
		"current": "now",
		"past": "{0} سېكۇنت ئىلگىرى",
		"future": "{0} سېكۇنتتىن كېيىن"
	],
	"now": "now"
]
	}
}
