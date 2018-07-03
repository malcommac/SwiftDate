import Foundation

// swiftlint:disable type_name
public class lang_nb: RelativeFormatterLang {

	/// Norwegian Bokmål
	public static let identifier: String = "nb"

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
		"previous": "i fjor",
		"current": "i år",
		"next": "neste år",
		"past": "for {0} år siden",
		"future": "om {0} år"
	],
	"quarter": [
		"previous": "forrige kv.",
		"current": "dette kv.",
		"next": "neste kv.",
		"past": "for {0} kv. siden",
		"future": "om {0} kv."
	],
	"month": [
		"previous": "forrige md.",
		"current": "denne md.",
		"next": "neste md.",
		"past": "for {0} md. siden",
		"future": "om {0} md."
	],
	"week": [
		"previous": "forrige uke",
		"current": "denne uken",
		"next": "neste uke",
		"past": "for {0} u. siden",
		"future": "om {0} u."
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgen",
		"past": "for {0} d. siden",
		"future": "om {0} d."
	],
	"hour": [
		"current": "denne timen",
		"past": "for {0} t siden",
		"future": "om {0} t"
	],
	"minute": [
		"current": "dette minuttet",
		"past": "for {0} min siden",
		"future": "om {0} min"
	],
	"second": [
		"current": "nå",
		"past": "for {0} sek siden",
		"future": "om {0} sek"
	],
	"now": "nå"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "i fjor",
		"current": "i år",
		"next": "neste år",
		"past": "–{0} år",
		"future": "+{0} år"
	],
	"quarter": [
		"previous": "forrige kv.",
		"current": "dette kv.",
		"next": "neste kv.",
		"past": "–{0} kv.",
		"future": "+{0} kv."
	],
	"month": [
		"previous": "forrige md.",
		"current": "denne md.",
		"next": "neste md.",
		"past": "-{0} md.",
		"future": "+{0} md."
	],
	"week": [
		"previous": "forrige uke",
		"current": "denne uken",
		"next": "neste uke",
		"past": "-{0} u.",
		"future": "+{0} u."
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgen",
		"past": "-{0} d.",
		"future": "+{0} d."
	],
	"hour": [
		"current": "denne timen",
		"past": "-{0} t",
		"future": "+{0} t"
	],
	"minute": [
		"current": "dette minuttet",
		"past": "-{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "nå",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "nå"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "i fjor",
		"current": "i år",
		"next": "neste år",
		"past": "for {0} år siden",
		"future": "om {0} år"
	],
	"quarter": [
		"previous": "forrige kvartal",
		"current": "dette kvartalet",
		"next": "neste kvartal",
		"past": [
			"one": "for {0} kvartal siden",
			"other": "for {0} kvartaler siden"
		],
		"future": [
			"one": "om {0} kvartal",
			"other": "om {0} kvartaler"
		]
	],
	"month": [
		"previous": "forrige måned",
		"current": "denne måneden",
		"next": "neste måned",
		"past": [
			"one": "for {0} måned siden",
			"other": "for {0} måneder siden"
		],
		"future": [
			"one": "om {0} måned",
			"other": "om {0} måneder"
		]
	],
	"week": [
		"previous": "forrige uke",
		"current": "denne uken",
		"next": "neste uke",
		"past": [
			"one": "for {0} uke siden",
			"other": "for {0} uker siden"
		],
		"future": [
			"one": "om {0} uke",
			"other": "om {0} uker"
		]
	],
	"day": [
		"previous": "i går",
		"current": "i dag",
		"next": "i morgen",
		"past": "for {0} døgn siden",
		"future": "om {0} døgn"
	],
	"hour": [
		"current": "denne timen",
		"past": [
			"one": "for {0} time siden",
			"other": "for {0} timer siden"
		],
		"future": [
			"one": "om {0} time",
			"other": "om {0} timer"
		]
	],
	"minute": [
		"current": "dette minuttet",
		"past": [
			"one": "for {0} minutt siden",
			"other": "for {0} minutter siden"
		],
		"future": [
			"one": "om {0} minutt",
			"other": "om {0} minutter"
		]
	],
	"second": [
		"current": "nå",
		"past": [
			"one": "for {0} sekund siden",
			"other": "for {0} sekunder siden"
		],
		"future": [
			"one": "om {0} sekund",
			"other": "om {0} sekunder"
		]
	],
	"now": "nå"
]
	}
}
