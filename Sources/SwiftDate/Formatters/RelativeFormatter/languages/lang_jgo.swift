import Foundation

// swiftlint:disable type_name
public class lang_jgo: RelativeFormatterLang {

	/// Ngomba
	public static let identifier: String = "jgo"

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
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": "Ɛ́gɛ́ mɔ́ ŋguꞋ {0}",
		"future": "Nǔu ŋguꞋ {0}"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "ɛ́ gɛ́ mɔ́ pɛsaŋ {0}",
		"future": "Nǔu {0} saŋ"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "Ɛ́ gɛ́ mɔ {0} ŋgap-mbi",
		"future": "Nǔu ŋgap-mbi {0}"
	],
	"day": [
		"previous": "yesterday",
		"current": "lɔꞋɔ",
		"next": "tomorrow",
		"past": "Ɛ́ gɛ́ mɔ́ lɛ́Ꞌ {0}",
		"future": "Nǔu lɛ́Ꞌ {0}"
	],
	"hour": [
		"current": "this hour",
		"past": "ɛ́ gɛ mɔ́ {0} háwa",
		"future": "nǔu háwa {0}"
	],
	"minute": [
		"current": "this minute",
		"past": "ɛ́ gɛ́ mɔ́ minút {0}",
		"future": "nǔu {0} minút"
	],
	"second": [
		"current": "now",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": "Ɛ́gɛ́ mɔ́ ŋguꞋ {0}",
		"future": "Nǔu ŋguꞋ {0}"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "ɛ́ gɛ́ mɔ́ pɛsaŋ {0}",
		"future": "Nǔu {0} saŋ"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "Ɛ́ gɛ́ mɔ {0} ŋgap-mbi",
		"future": "Nǔu ŋgap-mbi {0}"
	],
	"day": [
		"previous": "yesterday",
		"current": "lɔꞋɔ",
		"next": "tomorrow",
		"past": "Ɛ́ gɛ́ mɔ́ lɛ́Ꞌ {0}",
		"future": "Nǔu lɛ́Ꞌ {0}"
	],
	"hour": [
		"current": "this hour",
		"past": "ɛ́ gɛ mɔ́ {0} háwa",
		"future": "nǔu háwa {0}"
	],
	"minute": [
		"current": "this minute",
		"past": "ɛ́ gɛ́ mɔ́ minút {0}",
		"future": "nǔu {0} minút"
	],
	"second": [
		"current": "now",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "last year",
		"current": "this year",
		"next": "next year",
		"past": "Ɛ́gɛ́ mɔ́ ŋguꞋ {0}",
		"future": "Nǔu ŋguꞋ {0}"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "last month",
		"current": "this month",
		"next": "next month",
		"past": "ɛ́ gɛ́ mɔ́ pɛsaŋ {0}",
		"future": "Nǔu {0} saŋ"
	],
	"week": [
		"previous": "last week",
		"current": "this week",
		"next": "next week",
		"past": "Ɛ́ gɛ́ mɔ {0} ŋgap-mbi",
		"future": "Nǔu ŋgap-mbi {0}"
	],
	"day": [
		"previous": "yesterday",
		"current": "lɔꞋɔ",
		"next": "tomorrow",
		"past": "Ɛ́ gɛ́ mɔ́ lɛ́Ꞌ {0}",
		"future": "Nǔu lɛ́Ꞌ {0}"
	],
	"hour": [
		"current": "this hour",
		"past": "ɛ́ gɛ mɔ́ {0} háwa",
		"future": "nǔu háwa {0}"
	],
	"minute": [
		"current": "this minute",
		"past": "ɛ́ gɛ́ mɔ́ minút {0}",
		"future": "nǔu {0} minút"
	],
	"second": [
		"current": "now",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "now"
]
	}
}
