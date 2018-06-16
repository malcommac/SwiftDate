import Foundation

// swiftlint:disable type_name
public class lang_ko: RelativeFormatterLang {

	/// Korean
	public static let identifier: String = "ko"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return nil
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
		"previous": "작년",
		"current": "올해",
		"next": "내년",
		"past": "{0}년 전",
		"future": "{0}년 후"
	],
	"quarter": [
		"previous": "지난 분기",
		"current": "이번 분기",
		"next": "다음 분기",
		"past": "{0}분기 전",
		"future": "{0}분기 후"
	],
	"month": [
		"previous": "지난달",
		"current": "이번 달",
		"next": "다음 달",
		"past": "{0}개월 전",
		"future": "{0}개월 후"
	],
	"week": [
		"previous": "지난주",
		"current": "이번 주",
		"next": "다음 주",
		"past": "{0}주 전",
		"future": "{0}주 후"
	],
	"day": [
		"previous": "어제",
		"current": "오늘",
		"next": "내일",
		"past": "{0}일 전",
		"future": "{0}일 후"
	],
	"hour": [
		"current": "현재 시간",
		"past": "{0}시간 전",
		"future": "{0}시간 후"
	],
	"minute": [
		"current": "현재 분",
		"past": "{0}분 전",
		"future": "{0}분 후"
	],
	"second": [
		"current": "지금",
		"past": "{0}초 전",
		"future": "{0}초 후"
	],
	"now": "지금"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "작년",
		"current": "올해",
		"next": "내년",
		"past": "{0}년 전",
		"future": "{0}년 후"
	],
	"quarter": [
		"previous": "지난 분기",
		"current": "이번 분기",
		"next": "다음 분기",
		"past": "{0}분기 전",
		"future": "{0}분기 후"
	],
	"month": [
		"previous": "지난달",
		"current": "이번 달",
		"next": "다음 달",
		"past": "{0}개월 전",
		"future": "{0}개월 후"
	],
	"week": [
		"previous": "지난주",
		"current": "이번 주",
		"next": "다음 주",
		"past": "{0}주 전",
		"future": "{0}주 후"
	],
	"day": [
		"previous": "어제",
		"current": "오늘",
		"next": "내일",
		"past": "{0}일 전",
		"future": "{0}일 후"
	],
	"hour": [
		"current": "현재 시간",
		"past": "{0}시간 전",
		"future": "{0}시간 후"
	],
	"minute": [
		"current": "현재 분",
		"past": "{0}분 전",
		"future": "{0}분 후"
	],
	"second": [
		"current": "지금",
		"past": "{0}초 전",
		"future": "{0}초 후"
	],
	"now": "지금"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "작년",
		"current": "올해",
		"next": "내년",
		"past": "{0}년 전",
		"future": "{0}년 후"
	],
	"quarter": [
		"previous": "지난 분기",
		"current": "이번 분기",
		"next": "다음 분기",
		"past": "{0}분기 전",
		"future": "{0}분기 후"
	],
	"month": [
		"previous": "지난달",
		"current": "이번 달",
		"next": "다음 달",
		"past": "{0}개월 전",
		"future": "{0}개월 후"
	],
	"week": [
		"previous": "지난주",
		"current": "이번 주",
		"next": "다음 주",
		"past": "{0}주 전",
		"future": "{0}주 후"
	],
	"day": [
		"previous": "어제",
		"current": "오늘",
		"next": "내일",
		"past": "{0}일 전",
		"future": "{0}일 후"
	],
	"hour": [
		"current": "현재 시간",
		"past": "{0}시간 전",
		"future": "{0}시간 후"
	],
	"minute": [
		"current": "현재 분",
		"past": "{0}분 전",
		"future": "{0}분 후"
	],
	"second": [
		"current": "지금",
		"past": "{0}초 전",
		"future": "{0}초 후"
	],
	"now": "지금"
]
	}
}
