import Foundation

// swiftlint:disable type_name
public class lang_nn: RelativeFormatterLang {

	/// Norwegian Nynorsk
	public static let identifier: String = "nn"

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
		"previous": "i fjor",
		"current": "i år",
		"next": "neste år",
		"past": "for {0} år sidan",
		"future": "om {0} år"
	],
	"quarter": [
		"previous": "førre kvartal",
		"current": "dette kvartalet",
		"next": "neste kvartal",
		"past": "for {0} kv. sidan",
		"future": "om {0} kv."
	],
	"month": [
		"previous": "førre månad",
		"current": "denne månaden",
		"next": "neste månad",
		"past": "for {0} md. sidan",
		"future": "om {0} md."
	],
	"week": [
		"previous": "førre veke",
		"current": "denne veka",
		"next": "neste veke",
		"past": "for {0} v. sidan",
		"future": "om {0} v."
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgon",
		"past": "for {0} d. sidan",
		"future": "om {0} d."
	],
	"hour": [
		"current": "denne timen",
		"past": "for {0} t sidan",
		"future": "om {0} t"
	],
	"minute": [
		"current": "dette minuttet",
		"past": "for {0} min sidan",
		"future": "om {0} min"
	],
	"second": [
		"current": "no",
		"past": "for {0} sek sidan",
		"future": "om {0} sek"
	],
	"now": "no"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "i fjor",
		"current": "i år",
		"next": "neste år",
		"past": "for {0} år sidan",
		"future": "om {0} år"
	],
	"quarter": [
		"previous": "førre kvartal",
		"current": "dette kvartalet",
		"next": "neste kvartal",
		"past": "–{0} kv.",
		"future": "+{0} kv."
	],
	"month": [
		"previous": "førre månad",
		"current": "denne månaden",
		"next": "neste månad",
		"past": "–{0} md.",
		"future": "+{0} md."
	],
	"week": [
		"previous": "førre veke",
		"current": "denne veka",
		"next": "neste veke",
		"past": "–{0} v.",
		"future": "+{0} v."
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgon",
		"past": "–{0} d.",
		"future": "+{0} d."
	],
	"hour": [
		"current": "denne timen",
		"past": "–{0} t",
		"future": "+{0} t"
	],
	"minute": [
		"current": "dette minuttet",
		"past": "–{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "no",
		"past": [
			"one": "–{0} s",
			"other": "–{0} s"
		],
		"future": "+{0} s"
	],
	"now": "no"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "i fjor",
		"current": "i år",
		"next": "neste år",
		"past": "for {0} år sidan",
		"future": "om {0} år"
	],
	"quarter": [
		"previous": "førre kvartal",
		"current": "dette kvartalet",
		"next": "neste kvartal",
		"past": "for {0} kvartal sidan",
		"future": "om {0} kvartal"
	],
	"month": [
		"previous": "førre månad",
		"current": "denne månaden",
		"next": "neste månad",
		"past": [
			"one": "for {0} månad sidan",
			"other": "for {0} månadar sidan"
		],
		"future": [
			"one": "om {0} månad",
			"other": "om {0} månadar"
		]
	],
	"week": [
		"previous": "førre veke",
		"current": "denne veka",
		"next": "neste veke",
		"past": [
			"one": "for {0} veke sidan",
			"other": "for {0} veker sidan"
		],
		"future": [
			"one": "om {0} veke",
			"other": "om {0} veker"
		]
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgon",
		"past": "for {0} døgn sidan",
		"future": "om {0} døgn"
	],
	"hour": [
		"current": "denne timen",
		"past": [
			"one": "for {0} time sidan",
			"other": "for {0} timar sidan"
		],
		"future": [
			"one": "om {0} time",
			"other": "om {0} timar"
		]
	],
	"minute": [
		"current": "dette minuttet",
		"past": "for {0} minutt sidan",
		"future": "om {0} minutt"
	],
	"second": [
		"current": "no",
		"past": "for {0} sekund sidan",
		"future": [
			"one": "om {0} sekund",
			"other": "om {0} sekund"
		]
	],
	"now": "no"
]
	}
}
