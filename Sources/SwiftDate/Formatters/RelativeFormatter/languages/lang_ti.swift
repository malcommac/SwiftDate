import Foundation

// swiftlint:disable type_name
public class lang_ti: RelativeFormatterLang {

	/// Tigrinya
	public static let identifier: String = "ti"

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
		"previous": "ዓሚ",
		"current": "ሎሚ ዓመት",
		"next": "ንዓመታ",
		"past": [
			"one": "ቅድሚ -{0} ዓ",
			"other": "ቅድሚ {0} ዓ"
		],
		"future": "ኣብ {0} ዓ"
	],
	"quarter": [
		"previous": "ዝሓለፈ ርብዒ",
		"current": "ህሉው ርብዒ",
		"next": "ዝመጽእ ርብዒ",
		"past": "ቅድሚ {0} ርብዒ",
		"future": "ኣብ {0} ርብዒ"
	],
	"month": [
		"previous": "last month",
		"current": "ህሉው ወርሒ",
		"next": "ዝመጽእ ወርሒ",
		"past": "ቅድሚ {0} ወርሒ",
		"future": "ኣብ {0} ወርሒ"
	],
	"week": [
		"previous": "ዝሓለፈ ሰሙን",
		"current": "ህሉው ሰሙን",
		"next": "ዝመጽእ ሰሙን",
		"past": "ቅድሚ {0} ሰሙን",
		"future": "ኣብ {0} ሰሙን"
	],
	"day": [
		"previous": "ትማሊ",
		"current": "ሎሚ",
		"next": "ጽባሕ",
		"past": "ቅድሚ {0} መዓልቲ",
		"future": "ኣብ {0} መዓልቲ"
	],
	"hour": [
		"current": "ኣብዚ ሰዓት",
		"past": "ቅድሚ {0} ሰዓት",
		"future": "ኣብ {0} ሰዓት"
	],
	"minute": [
		"current": "ኣብዚ ደቒቕ",
		"past": "ቅድሚ {0} ደቒቕ",
		"future": "ኣብ {0} ደቒቕ"
	],
	"second": [
		"current": "ሕጂ",
		"past": "ቅድሚ {0} ካልኢት",
		"future": "ኣብ {0} ካልኢት"
	],
	"now": "ሕጂ"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ዓሚ",
		"current": "ሎሚ ዓመት",
		"next": "ንዓመታ",
		"past": "ቅድሚ {0} ዓ",
		"future": "ኣብ {0} ዓ"
	],
	"quarter": [
		"previous": "ዝሓለፈ ርብዒ",
		"current": "ህሉው ርብዒ",
		"next": "ዝመጽእ ርብዒ",
		"past": "ቅድሚ {0} ርብዒ",
		"future": "ኣብ {0} ርብዒ"
	],
	"month": [
		"previous": "last month",
		"current": "ህሉው ወርሒ",
		"next": "ዝመጽእ ወርሒ",
		"past": "ቅድሚ {0} ወርሒ",
		"future": "ኣብ {0} ወርሒ"
	],
	"week": [
		"previous": "ዝሓለፈ ሰሙን",
		"current": "ህሉው ሰሙን",
		"next": "ዝመጽእ ሰሙን",
		"past": "ቅድሚ {0} ሰሙን",
		"future": "ኣብ {0} ሰሙን"
	],
	"day": [
		"previous": "ትማሊ",
		"current": "ሎሚ",
		"next": "ጽባሕ",
		"past": "ቅድሚ {0} መዓልቲ",
		"future": "ኣብ {0} መዓልቲ"
	],
	"hour": [
		"current": "ኣብዚ ሰዓት",
		"past": "ቅድሚ {0} ሰዓት",
		"future": "ኣብ {0} ሰዓት"
	],
	"minute": [
		"current": "ኣብዚ ደቒቕ",
		"past": "ቅድሚ {0} ደቒቕ",
		"future": "ኣብ {0} ደቒቕ"
	],
	"second": [
		"current": "ሕጂ",
		"past": "ቅድሚ {0} ካልኢት",
		"future": "ኣብ {0} ካልኢት"
	],
	"now": "ሕጂ"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ዓሚ",
		"current": "ሎሚ ዓመት",
		"next": "ንዓመታ",
		"past": "ቅድሚ {0} ዓ",
		"future": "ኣብ {0} ዓ"
	],
	"quarter": [
		"previous": "ዝሓለፈ ርብዒ",
		"current": "ህሉው ርብዒ",
		"next": "ዝመጽእ ርብዒ",
		"past": "ቅድሚ {0} ርብዒ",
		"future": "ኣብ {0} ርብዒ"
	],
	"month": [
		"previous": "last month",
		"current": "ህሉው ወርሒ",
		"next": "ዝመጽእ ወርሒ",
		"past": "ቅድሚ {0} ወርሒ",
		"future": "ኣብ {0} ወርሒ"
	],
	"week": [
		"previous": "ዝሓለፈ ሰሙን",
		"current": "ህሉው ሰሙን",
		"next": "ዝመጽእ ሰሙን",
		"past": "ቅድሚ {0} ሰሙን",
		"future": "ኣብ {0} ሰሙን"
	],
	"day": [
		"previous": "ትማሊ",
		"current": "ሎሚ",
		"next": "ጽባሕ",
		"past": [
			"one": "ቅድሚ {0} መዓልቲ",
			"other": "ኣብ {0} መዓልቲ"
		],
		"future": "ኣብ {0} መዓልቲ"
	],
	"hour": [
		"current": "ኣብዚ ሰዓት",
		"past": "ቅድሚ {0} ሰዓት",
		"future": "ኣብ {0} ሰዓት"
	],
	"minute": [
		"current": "ኣብዚ ደቒቕ",
		"past": "ቅድሚ {0} ደቒቕ",
		"future": "ኣብ {0} ደቒቕ"
	],
	"second": [
		"current": "ሕጂ",
		"past": "ቅድሚ {0} ካልኢት",
		"future": "ኣብ {0} ካልኢት"
	],
	"now": "ሕጂ"
]
	}
}
