import Foundation

// swiftlint:disable type_name
public class lang_ja: RelativeFormatterLang {

	/// Japanese
	public static let identifier: String = "ja"

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
		"previous": "昨年",
		"current": "今年",
		"next": "翌年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "前四半期",
		"current": "今四半期",
		"next": "翌四半期",
		"past": "{0} 四半期前",
		"future": "{0} 四半期後"
	],
	"month": [
		"previous": "先月",
		"current": "今月",
		"next": "翌月",
		"past": "{0} か月前",
		"future": "{0} か月後"
	],
	"week": [
		"previous": "先週",
		"current": "今週",
		"next": "翌週",
		"past": "{0} 週間前",
		"future": "{0} 週間後"
	],
	"day": [
		"previous": "昨日",
		"current": "今日",
		"next": "明日",
		"past": "{0} 日前",
		"future": "{0} 日後"
	],
	"hour": [
		"current": "1 時間以内",
		"past": "{0} 時間前",
		"future": "{0} 時間後"
	],
	"minute": [
		"current": "1 分以内",
		"past": "{0} 分前",
		"future": "{0} 分後"
	],
	"second": [
		"current": "今",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "今"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "昨年",
		"current": "今年",
		"next": "翌年",
		"past": "{0}年前",
		"future": "{0}年後"
	],
	"quarter": [
		"previous": "前四半期",
		"current": "今四半期",
		"next": "翌四半期",
		"past": "{0}四半期前",
		"future": "{0}四半期後"
	],
	"month": [
		"previous": "先月",
		"current": "今月",
		"next": "翌月",
		"past": "{0}か月前",
		"future": "{0}か月後"
	],
	"week": [
		"previous": "先週",
		"current": "今週",
		"next": "翌週",
		"past": "{0}週間前",
		"future": "{0}週間後"
	],
	"day": [
		"previous": "昨日",
		"current": "今日",
		"next": "明日",
		"past": "{0}日前",
		"future": "{0}日後"
	],
	"hour": [
		"current": "1 時間以内",
		"past": "{0}時間前",
		"future": "{0}時間後"
	],
	"minute": [
		"current": "1 分以内",
		"past": "{0}分前",
		"future": "{0}分後"
	],
	"second": [
		"current": "今",
		"past": "{0}秒前",
		"future": "{0}秒後"
	],
	"now": "今"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "昨年",
		"current": "今年",
		"next": "翌年",
		"past": "{0} 年前",
		"future": "{0} 年後"
	],
	"quarter": [
		"previous": "前四半期",
		"current": "今四半期",
		"next": "翌四半期",
		"past": "{0} 四半期前",
		"future": "{0} 四半期後"
	],
	"month": [
		"previous": "先月",
		"current": "今月",
		"next": "翌月",
		"past": "{0} か月前",
		"future": "{0} か月後"
	],
	"week": [
		"previous": "先週",
		"current": "今週",
		"next": "翌週",
		"past": "{0} 週間前",
		"future": "{0} 週間後"
	],
	"day": [
		"previous": "昨日",
		"current": "今日",
		"next": "明日",
		"past": "{0} 日前",
		"future": "{0} 日後"
	],
	"hour": [
		"current": "1 時間以内",
		"past": "{0} 時間前",
		"future": "{0} 時間後"
	],
	"minute": [
		"current": "1 分以内",
		"past": "{0} 分前",
		"future": "{0} 分後"
	],
	"second": [
		"current": "今",
		"past": "{0} 秒前",
		"future": "{0} 秒後"
	],
	"now": "今"
]
	}
}
