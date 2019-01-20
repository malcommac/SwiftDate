import Foundation

// swiftlint:disable type_name
public class lang_yueHant: RelativeFormatterLang {

	/// Cantonese (Traditional)
	public static let identifier: String = "yue_Hant"

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
		"previous": "舊年",
		"current": "今年",
		"next": "下年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "上季",
		"current": "今季",
		"next": "下季",
		"past": "{0} 季前",
		"future": "{0} 季後"
	],
	"month": [
		"previous": "上個月",
		"current": "今個月",
		"next": "下個月",
		"past": "{0} 個月前",
		"future": "{0} 個月後"
	],
	"week": [
		"previous": "上星期",
		"current": "今個星期",
		"next": "下星期",
		"past": "{0} 個星期前",
		"future": "{0} 個星期後"
	],
	"day": [
		"previous": "尋日",
		"current": "今日",
		"next": "聽日",
		"past": "{0} 日前",
		"future": "{0} 日後"
	],
	"hour": [
		"current": "呢個小時",
		"past": "{0} 小時前",
		"future": "{0} 小時後"
	],
	"minute": [
		"current": "呢分鐘",
		"past": "{0} 分鐘前",
		"future": "{0} 分鐘後"
	],
	"second": [
		"current": "宜家",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "宜家"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "舊年",
		"current": "今年",
		"next": "下年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "上季",
		"current": "今季",
		"next": "下季",
		"past": "{0} 季前",
		"future": "{0} 季後"
	],
	"month": [
		"previous": "上個月",
		"current": "今個月",
		"next": "下個月",
		"past": "{0} 個月前",
		"future": "{0} 個月後"
	],
	"week": [
		"previous": "上星期",
		"current": "今個星期",
		"next": "下星期",
		"past": "{0} 個星期前",
		"future": "{0} 個星期後"
	],
	"day": [
		"previous": "尋日",
		"current": "今日",
		"next": "聽日",
		"past": "{0} 日前",
		"future": "{0} 日後"
	],
	"hour": [
		"current": "呢個小時",
		"past": "{0} 小時前",
		"future": "{0} 小時後"
	],
	"minute": [
		"current": "呢分鐘",
		"past": "{0} 分鐘前",
		"future": "{0} 分鐘後"
	],
	"second": [
		"current": "宜家",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "宜家"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "舊年",
		"current": "今年",
		"next": "下年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "上一季",
		"current": "今季",
		"next": "下一季",
		"past": "{0} 季前",
		"future": "{0} 季後"
	],
	"month": [
		"previous": "上個月",
		"current": "今個月",
		"next": "下個月",
		"past": "{0} 個月前",
		"future": "{0} 個月後"
	],
	"week": [
		"previous": "上星期",
		"current": "今個星期",
		"next": "下星期",
		"past": "{0} 個星期前",
		"future": "{0} 個星期後"
	],
	"day": [
		"previous": "尋日",
		"current": "今日",
		"next": "聽日",
		"past": "{0} 日前",
		"future": "{0} 日後"
	],
	"hour": [
		"current": "呢個小時",
		"past": "{0} 小時前",
		"future": "{0} 小時後"
	],
	"minute": [
		"current": "呢分鐘",
		"past": "{0} 分鐘前",
		"future": "{0} 分鐘後"
	],
	"second": [
		"current": "宜家",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "宜家"
]
	}
}
