import Foundation

// swiftlint:disable type_name
public class lang_th: RelativeFormatterLang {

	/// Thai
	public static let identifier: String = "th"

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
		"previous": "ปีที่แล้ว",
		"current": "ปีนี้",
		"next": "ปีหน้า",
		"past": "{0} ปีที่แล้ว",
		"future": "ใน {0} ปี"
	],
	"quarter": [
		"previous": "ไตรมาสที่แล้ว",
		"current": "ไตรมาสนี้",
		"next": "ไตรมาสหน้า",
		"past": "{0} ไตรมาสที่แล้ว",
		"future": "ใน {0} ไตรมาส"
	],
	"month": [
		"previous": "เดือนที่แล้ว",
		"current": "เดือนนี้",
		"next": "เดือนหน้า",
		"past": "{0} เดือนที่แล้ว",
		"future": "ใน {0} เดือน"
	],
	"week": [
		"previous": "สัปดาห์ที่แล้ว",
		"current": "สัปดาห์นี้",
		"next": "สัปดาห์หน้า",
		"past": "{0} สัปดาห์ที่แล้ว",
		"future": "ใน {0} สัปดาห์"
	],
	"day": [
		"previous": "เมื่อวาน",
		"current": "วันนี้",
		"next": "พรุ่งนี้",
		"past": "{0} วันที่แล้ว",
		"future": "ใน {0} วัน"
	],
	"hour": [
		"current": "ชั่วโมงนี้",
		"past": "{0} ชม. ที่แล้ว",
		"future": "ใน {0} ชม."
	],
	"minute": [
		"current": "นาทีนี้",
		"past": "{0} นาทีที่แล้ว",
		"future": "ใน {0} นาที"
	],
	"second": [
		"current": "ขณะนี้",
		"past": "{0} วินาทีที่แล้ว",
		"future": "ใน {0} วินาที"
	],
	"now": "ขณะนี้"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ปีที่แล้ว",
		"current": "ปีนี้",
		"next": "ปีหน้า",
		"past": "{0} ปีที่แล้ว",
		"future": "ใน {0} ปี"
	],
	"quarter": [
		"previous": "ไตรมาสที่แล้ว",
		"current": "ไตรมาสนี้",
		"next": "ไตรมาสหน้า",
		"past": "{0} ไตรมาสที่แล้ว",
		"future": "ใน {0} ไตรมาส"
	],
	"month": [
		"previous": "เดือนที่แล้ว",
		"current": "เดือนนี้",
		"next": "เดือนหน้า",
		"past": "{0} เดือนที่แล้ว",
		"future": "ใน {0} เดือน"
	],
	"week": [
		"previous": "สัปดาห์ที่แล้ว",
		"current": "สัปดาห์นี้",
		"next": "สัปดาห์หน้า",
		"past": "{0} สัปดาห์ที่แล้ว",
		"future": "ใน {0} สัปดาห์"
	],
	"day": [
		"previous": "เมื่อวาน",
		"current": "วันนี้",
		"next": "พรุ่งนี้",
		"past": "{0} วันที่แล้ว",
		"future": "ใน {0} วัน"
	],
	"hour": [
		"current": "ชั่วโมงนี้",
		"past": "{0} ชม. ที่แล้ว",
		"future": "ใน {0} ชม."
	],
	"minute": [
		"current": "นาทีนี้",
		"past": "{0} นาทีที่แล้ว",
		"future": "ใน {0} นาที"
	],
	"second": [
		"current": "ขณะนี้",
		"past": "{0} วินาทีที่แล้ว",
		"future": "ใน {0} วินาที"
	],
	"now": "ขณะนี้"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ปีที่แล้ว",
		"current": "ปีนี้",
		"next": "ปีหน้า",
		"past": "{0} ปีที่แล้ว",
		"future": "ในอีก {0} ปี"
	],
	"quarter": [
		"previous": "ไตรมาสที่แล้ว",
		"current": "ไตรมาสนี้",
		"next": "ไตรมาสหน้า",
		"past": "{0} ไตรมาสที่แล้ว",
		"future": "ในอีก {0} ไตรมาส"
	],
	"month": [
		"previous": "เดือนที่แล้ว",
		"current": "เดือนนี้",
		"next": "เดือนหน้า",
		"past": "{0} เดือนที่ผ่านมา",
		"future": "ในอีก {0} เดือน"
	],
	"week": [
		"previous": "สัปดาห์ที่แล้ว",
		"current": "สัปดาห์นี้",
		"next": "สัปดาห์หน้า",
		"past": "{0} สัปดาห์ที่ผ่านมา",
		"future": "ในอีก {0} สัปดาห์"
	],
	"day": [
		"previous": "เมื่อวาน",
		"current": "วันนี้",
		"next": "พรุ่งนี้",
		"past": "{0} วันที่ผ่านมา",
		"future": "ในอีก {0} วัน"
	],
	"hour": [
		"current": "ชั่วโมงนี้",
		"past": "{0} ชั่วโมงที่ผ่านมา",
		"future": "ในอีก {0} ชั่วโมง"
	],
	"minute": [
		"current": "นาทีนี้",
		"past": "{0} นาทีที่ผ่านมา",
		"future": "ในอีก {0} นาที"
	],
	"second": [
		"current": "ขณะนี้",
		"past": "{0} วินาทีที่ผ่านมา",
		"future": "ในอีก {0} วินาที"
	],
	"now": "ขณะนี้"
]
	}
}
