import Foundation

// swiftlint:disable type_name
public class lang_yueHans: RelativeFormatterLang {

	/// Cantonese (Simplified)
	public static let identifier: String = "yue_Hans"

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
		"previous": "旧年",
		"current": "今年",
		"next": "下年",
		"past": "{0} 年前",
		"future": "{0} 年后"
	],
	"quarter": [
		"previous": "上季",
		"current": "今季",
		"next": "下季",
		"past": "{0} 季前",
		"future": "{0} 季后"
	],
	"month": [
		"previous": "上个月",
		"current": "今个月",
		"next": "下个月",
		"past": "{0} 个月前",
		"future": "{0} 个月后"
	],
	"week": [
		"previous": "上星期",
		"current": "今个星期",
		"next": "下星期",
		"past": "{0} 个星期前",
		"future": "{0} 个星期后"
	],
	"day": [
		"previous": "寻日",
		"current": "今日",
		"next": "听日",
		"past": "{0} 日前",
		"future": "{0} 日后"
	],
	"hour": [
		"current": "呢个小时",
		"past": "{0} 小时前",
		"future": "{0} 小时后"
	],
	"minute": [
		"current": "呢分钟",
		"past": "{0} 分钟前",
		"future": "{0} 分钟后"
	],
	"second": [
		"current": "宜家",
		"past": "{0} 秒前",
		"future": "{0} 秒后"
	],
	"now": "宜家"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "旧年",
		"current": "今年",
		"next": "下年",
		"past": "{0} 年前",
		"future": "{0} 年后"
	],
	"quarter": [
		"previous": "上季",
		"current": "今季",
		"next": "下季",
		"past": "{0} 季前",
		"future": "{0} 季后"
	],
	"month": [
		"previous": "上个月",
		"current": "今个月",
		"next": "下个月",
		"past": "{0} 个月前",
		"future": "{0} 个月后"
	],
	"week": [
		"previous": "上星期",
		"current": "今个星期",
		"next": "下星期",
		"past": "{0} 个星期前",
		"future": "{0} 个星期后"
	],
	"day": [
		"previous": "寻日",
		"current": "今日",
		"next": "听日",
		"past": "{0} 日前",
		"future": "{0} 日后"
	],
	"hour": [
		"current": "呢个小时",
		"past": "{0} 小时前",
		"future": "{0} 小时后"
	],
	"minute": [
		"current": "呢分钟",
		"past": "{0} 分钟前",
		"future": "{0} 分钟后"
	],
	"second": [
		"current": "宜家",
		"past": "{0} 秒前",
		"future": "{0} 秒后"
	],
	"now": "宜家"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "旧年",
		"current": "今年",
		"next": "下年",
		"past": "{0} 年前",
		"future": "{0} 年后"
	],
	"quarter": [
		"previous": "上一季",
		"current": "今季",
		"next": "下一季",
		"past": "{0} 季前",
		"future": "{0} 季后"
	],
	"month": [
		"previous": "上个月",
		"current": "今个月",
		"next": "下个月",
		"past": "{0} 个月前",
		"future": "{0} 个月后"
	],
	"week": [
		"previous": "上星期",
		"current": "今个星期",
		"next": "下星期",
		"past": "{0} 个星期前",
		"future": "{0} 个星期后"
	],
	"day": [
		"previous": "寻日",
		"current": "今日",
		"next": "听日",
		"past": "{0} 日前",
		"future": "{0} 日后"
	],
	"hour": [
		"current": "呢个小时",
		"past": "{0} 小时前",
		"future": "{0} 小时后"
	],
	"minute": [
		"current": "呢分钟",
		"past": "{0} 分钟前",
		"future": "{0} 分钟后"
	],
	"second": [
		"current": "宜家",
		"past": "{0} 秒前",
		"future": "{0} 秒后"
	],
	"now": "宜家"
]
	}
}
