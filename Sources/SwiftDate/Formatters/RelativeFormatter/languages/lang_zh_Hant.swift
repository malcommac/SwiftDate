import Foundation

// swiftlint:disable type_name
public class lang_zhHant: RelativeFormatterLang {

	/// Chinese (Traditional)
	public static let identifier: String = "zh_Hant"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return .other
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
		"previous": "去年",
		"current": "今年",
		"next": "明年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "上一季",
		"current": "這一季",
		"next": "下一季",
		"past": "{0} 季前",
		"future": "{0} 季後"
	],
	"month": [
		"previous": "上個月",
		"current": "本月",
		"next": "下個月",
		"past": "{0} 個月前",
		"future": "{0} 個月後"
	],
	"week": [
		"previous": "上週",
		"current": "本週",
		"next": "下週",
		"past": "{0} 週前",
		"future": "{0} 週後"
	],
	"day": [
		"previous": "昨天",
		"current": "今天",
		"next": "明天",
		"past": "{0} 天前",
		"future": "{0} 天後"
	],
	"hour": [
		"current": "這一小時",
		"past": "{0} 小時前",
		"future": "{0} 小時後"
	],
	"minute": [
		"current": "這一分鐘",
		"past": "{0} 分鐘前",
		"future": "{0} 分鐘後"
	],
	"second": [
		"current": "現在",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "現在"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "去年",
		"current": "今年",
		"next": "明年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "上一季",
		"current": "這一季",
		"next": "下一季",
		"past": "{0} 季前",
		"future": "{0} 季後"
	],
	"month": [
		"previous": "上個月",
		"current": "本月",
		"next": "下個月",
		"past": "{0} 個月前",
		"future": "{0} 個月後"
	],
	"week": [
		"previous": "上週",
		"current": "本週",
		"next": "下週",
		"past": "{0} 週前",
		"future": "{0} 週後"
	],
	"day": [
		"previous": "昨天",
		"current": "今天",
		"next": "明天",
		"past": "{0} 天前",
		"future": "{0} 天後"
	],
	"hour": [
		"current": "這一小時",
		"past": "{0} 小時前",
		"future": "{0} 小時後"
	],
	"minute": [
		"current": "這一分鐘",
		"past": "{0} 分鐘前",
		"future": "{0} 分鐘後"
	],
	"second": [
		"current": "現在",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "現在"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "去年",
		"current": "今年",
		"next": "明年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "上一季",
		"current": "這一季",
		"next": "下一季",
		"past": "{0} 季前",
		"future": "{0} 季後"
	],
	"month": [
		"previous": "上個月",
		"current": "本月",
		"next": "下個月",
		"past": "{0} 個月前",
		"future": "{0} 個月後"
	],
	"week": [
		"previous": "上週",
		"current": "本週",
		"next": "下週",
		"past": "{0} 週前",
		"future": "{0} 週後"
	],
	"day": [
		"previous": "昨天",
		"current": "今天",
		"next": "明天",
		"past": "{0} 天前",
		"future": "{0} 天後"
	],
	"hour": [
		"current": "這一小時",
		"past": "{0} 小時前",
		"future": "{0} 小時後"
	],
	"minute": [
		"current": "這一分鐘",
		"past": "{0} 分鐘前",
		"future": "{0} 分鐘後"
	],
	"second": [
		"current": "現在",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "現在"
]
	}
}
