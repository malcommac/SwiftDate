import Foundation

// swiftlint:disable type_name
public class lang_zhHansHK: RelativeFormatterLang {

	/// Chinese (Simplified, Hong Kong [China])
	public static let identifier: String = "zh_Hans_HK"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return .other
	}

	public var flavours: [String: Any] {
		return [
			RelativeFormatter.Flavour.long.rawValue: self._long
		]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "去年",
		"current": "今年",
		"next": "明年",
		"past": "{0}年前",
		"future": "{0}年后"
	],
	"quarter": [
		"previous": "上季度",
		"current": "本季度",
		"next": "下季度",
		"past": "{0}个季度前",
		"future": "{0}个季度后"
	],
	"month": [
		"previous": "上个月",
		"current": "本月",
		"next": "下个月",
		"past": "{0}个月前",
		"future": "{0}个月后"
	],
	"week": [
		"previous": "上周",
		"current": "本周",
		"next": "下周",
		"past": "{0}周前",
		"future": "{0}周后"
	],
	"day": [
		"previous": "昨天",
		"current": "今天",
		"next": "明天",
		"past": "{0}天前",
		"future": "{0}天后"
	],
	"hour": [
		"current": "这一时间 / 此时",
		"past": "{0}小时前",
		"future": "{0}小时后"
	],
	"minute": [
		"current": "此刻",
		"past": "{0}分钟前",
		"future": "{0}分钟后"
	],
	"second": [
		"current": "现在",
		"past": "{0}秒前",
		"future": "{0}秒后"
	],
	"now": "现在"
]
	}
}
