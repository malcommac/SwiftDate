import Foundation

// swiftlint:disable type_name
public class lang_vi: RelativeFormatterLang {

	/// Vietnamese
	public static let identifier: String = "vi"

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
		"previous": "năm ngoái",
		"current": "năm nay",
		"next": "năm sau",
		"past": "{0} năm trước",
		"future": "sau {0} năm nữa"
	],
	"quarter": [
		"previous": "quý trước",
		"current": "quý này",
		"next": "quý sau",
		"past": "{0} quý trước",
		"future": "sau {0} quý nữa"
	],
	"month": [
		"previous": "tháng trước",
		"current": "tháng này",
		"next": "tháng sau",
		"past": "{0} tháng trước",
		"future": "sau {0} tháng nữa"
	],
	"week": [
		"previous": "tuần trước",
		"current": "tuần này",
		"next": "tuần sau",
		"past": "{0} tuần trước",
		"future": "sau {0} tuần nữa"
	],
	"day": [
		"previous": "Hôm qua",
		"current": "Hôm nay",
		"next": "Ngày mai",
		"past": "{0} ngày trước",
		"future": "sau {0} ngày nữa"
	],
	"hour": [
		"current": "giờ này",
		"past": "{0} giờ trước",
		"future": "sau {0} giờ nữa"
	],
	"minute": [
		"current": "phút này",
		"past": "{0} phút trước",
		"future": "sau {0} phút nữa"
	],
	"second": [
		"current": "bây giờ",
		"past": "{0} giây trước",
		"future": "sau {0} giây nữa"
	],
	"now": "bây giờ"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "năm ngoái",
		"current": "năm nay",
		"next": "năm sau",
		"past": "{0} năm trước",
		"future": "sau {0} năm nữa"
	],
	"quarter": [
		"previous": "quý trước",
		"current": "quý này",
		"next": "quý sau",
		"past": "{0} quý trước",
		"future": "sau {0} quý nữa"
	],
	"month": [
		"previous": "tháng trước",
		"current": "tháng này",
		"next": "tháng sau",
		"past": "{0} tháng trước",
		"future": "sau {0} tháng nữa"
	],
	"week": [
		"previous": "tuần trước",
		"current": "tuần này",
		"next": "tuần sau",
		"past": "{0} tuần trước",
		"future": "sau {0} tuần nữa"
	],
	"day": [
		"previous": "Hôm qua",
		"current": "Hôm nay",
		"next": "Ngày mai",
		"past": "{0} ngày trước",
		"future": "sau {0} ngày nữa"
	],
	"hour": [
		"current": "giờ này",
		"past": "{0} giờ trước",
		"future": "sau {0} giờ nữa"
	],
	"minute": [
		"current": "phút này",
		"past": "{0} phút trước",
		"future": "sau {0} phút nữa"
	],
	"second": [
		"current": "bây giờ",
		"past": "{0} giây trước",
		"future": "sau {0} giây nữa"
	],
	"now": "bây giờ"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "năm ngoái",
		"current": "năm nay",
		"next": "năm sau",
		"past": "{0} năm trước",
		"future": "sau {0} năm nữa"
	],
	"quarter": [
		"previous": "quý trước",
		"current": "quý này",
		"next": "quý sau",
		"past": "{0} quý trước",
		"future": "sau {0} quý nữa"
	],
	"month": [
		"previous": "tháng trước",
		"current": "tháng này",
		"next": "tháng sau",
		"past": "{0} tháng trước",
		"future": "sau {0} tháng nữa"
	],
	"week": [
		"previous": "tuần trước",
		"current": "tuần này",
		"next": "tuần sau",
		"past": "{0} tuần trước",
		"future": "sau {0} tuần nữa"
	],
	"day": [
		"previous": "Hôm qua",
		"current": "Hôm nay",
		"next": "Ngày mai",
		"past": "{0} ngày trước",
		"future": "sau {0} ngày nữa"
	],
	"hour": [
		"current": "giờ này",
		"past": "{0} giờ trước",
		"future": "sau {0} giờ nữa"
	],
	"minute": [
		"current": "phút này",
		"past": "{0} phút trước",
		"future": "sau {0} phút nữa"
	],
	"second": [
		"current": "bây giờ",
		"past": "{0} giây trước",
		"future": "sau {0} giây nữa"
	],
	"now": "bây giờ"
]
	}
}
