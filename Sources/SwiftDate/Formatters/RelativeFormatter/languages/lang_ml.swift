import Foundation

// swiftlint:disable type_name
public class lang_ml: RelativeFormatterLang {

	/// Malayalam
	public static let identifier: String = "ml"

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
		"previous": "കഴിഞ്ഞ വർഷം",
		"current": "ഈ വർ‌ഷം",
		"next": "അടുത്തവർഷം",
		"past": "{0} വർഷം മുമ്പ്",
		"future": "{0} വർഷത്തിൽ"
	],
	"quarter": [
		"previous": "കഴിഞ്ഞ പാദം",
		"current": "ഈ പാദം",
		"next": "അടുത്ത പാദം",
		"past": "{0} പാദം മുമ്പ്",
		"future": "{0} പാദത്തിൽ"
	],
	"month": [
		"previous": "കഴിഞ്ഞ മാസം",
		"current": "ഈ മാസം",
		"next": "അടുത്ത മാസം",
		"past": "{0} മാസം മുമ്പ്",
		"future": "{0} മാസത്തിൽ"
	],
	"week": [
		"previous": "കഴിഞ്ഞ ആഴ്‌ച",
		"current": "ഈ ആഴ്ച",
		"next": "അടുത്ത ആഴ്ച",
		"past": "{0} ആഴ്ച മുമ്പ്",
		"future": "{0} ആഴ്ചയിൽ"
	],
	"day": [
		"previous": "ഇന്നലെ",
		"current": "ഇന്ന്",
		"next": "നാളെ",
		"past": "{0} ദിവസം മുമ്പ്",
		"future": "{0} ദിവസത്തിൽ"
	],
	"hour": [
		"current": "ഈ മണിക്കൂറിൽ",
		"past": "{0} മണിക്കൂർ മുമ്പ്",
		"future": "{0} മണിക്കൂറിൽ"
	],
	"minute": [
		"current": "ഈ മിനിറ്റിൽ",
		"past": "{0} മിനിറ്റ് മുമ്പ്",
		"future": "{0} മിനിറ്റിൽ"
	],
	"second": [
		"current": "ഇപ്പോൾ",
		"past": "{0} സെക്കൻഡ് മുമ്പ്",
		"future": "{0} സെക്കൻഡിൽ"
	],
	"now": "ഇപ്പോൾ"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "കഴിഞ്ഞ വർഷം",
		"current": "ഈ വർ‌ഷം",
		"next": "അടുത്തവർഷം",
		"past": "{0} വർഷം മുമ്പ്",
		"future": "{0} വർഷത്തിൽ"
	],
	"quarter": [
		"previous": "കഴിഞ്ഞ പാദം",
		"current": "ഈ പാദം",
		"next": "അടുത്ത പാദം",
		"past": "{0} പാദം മുമ്പ്",
		"future": "{0} പാദത്തിൽ"
	],
	"month": [
		"previous": "കഴിഞ്ഞ മാസം",
		"current": "ഈ മാസം",
		"next": "അടുത്ത മാസം",
		"past": "{0} മാസം മുമ്പ്",
		"future": "{0} മാസത്തിൽ"
	],
	"week": [
		"previous": "കഴിഞ്ഞ ആഴ്‌ച",
		"current": "ഈ ആഴ്ച",
		"next": "അടുത്ത ആഴ്ച",
		"past": "{0} ആഴ്ച മുമ്പ്",
		"future": "{0} ആഴ്ചയിൽ"
	],
	"day": [
		"previous": "ഇന്നലെ",
		"current": "ഇന്ന്",
		"next": "നാളെ",
		"past": "{0} ദിവസം മുമ്പ്",
		"future": "{0} ദിവസത്തിൽ"
	],
	"hour": [
		"current": "ഈ മണിക്കൂറിൽ",
		"past": "{0} മണിക്കൂർ മുമ്പ്",
		"future": "{0} മണിക്കൂറിൽ"
	],
	"minute": [
		"current": "ഈ മിനിറ്റിൽ",
		"past": "{0} മിനിറ്റ് മുമ്പ്",
		"future": "{0} മിനിറ്റിൽ"
	],
	"second": [
		"current": "ഇപ്പോൾ",
		"past": "{0} സെക്കൻഡ് മുമ്പ്",
		"future": "{0} സെക്കൻഡിൽ"
	],
	"now": "ഇപ്പോൾ"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "കഴിഞ്ഞ വർഷം",
		"current": "ഈ വർ‌ഷം",
		"next": "അടുത്തവർഷം",
		"past": "{0} വർഷം മുമ്പ്",
		"future": "{0} വർഷത്തിൽ"
	],
	"quarter": [
		"previous": "കഴിഞ്ഞ പാദം",
		"current": "ഈ പാദം",
		"next": "അടുത്ത പാദം",
		"past": "{0} പാദം മുമ്പ്",
		"future": "{0} പാദത്തിൽ"
	],
	"month": [
		"previous": "കഴിഞ്ഞ മാസം",
		"current": "ഈ മാസം",
		"next": "അടുത്ത മാസം",
		"past": "{0} മാസം മുമ്പ്",
		"future": "{0} മാസത്തിൽ"
	],
	"week": [
		"previous": "കഴിഞ്ഞ ആഴ്‌ച",
		"current": "ഈ ആഴ്ച",
		"next": "അടുത്ത ആഴ്ച",
		"past": "{0} ആഴ്ച മുമ്പ്",
		"future": "{0} ആഴ്ചയിൽ"
	],
	"day": [
		"previous": "ഇന്നലെ",
		"current": "ഇന്ന്",
		"next": "നാളെ",
		"past": "{0} ദിവസം മുമ്പ്",
		"future": "{0} ദിവസത്തിൽ"
	],
	"hour": [
		"current": "ഈ മണിക്കൂറിൽ",
		"past": "{0} മണിക്കൂർ മുമ്പ്",
		"future": "{0} മണിക്കൂറിൽ"
	],
	"minute": [
		"current": "ഈ മിനിറ്റിൽ",
		"past": "{0} മിനിറ്റ് മുമ്പ്",
		"future": "{0} മിനിറ്റിൽ"
	],
	"second": [
		"current": "ഇപ്പോൾ",
		"past": "{0} സെക്കൻഡ് മുമ്പ്",
		"future": "{0} സെക്കൻഡിൽ"
	],
	"now": "ഇപ്പോൾ"
]
	}
}
