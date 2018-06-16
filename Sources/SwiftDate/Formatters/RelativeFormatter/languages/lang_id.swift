import Foundation

// swiftlint:disable type_name
public class lang_id: RelativeFormatterLang {

	/// Indonesian
	public static let identifier: String = "id"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return .other
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
		"previous": "tahun lalu",
		"current": "tahun ini",
		"next": "tahun depan",
		"past": "{0} thn lalu",
		"future": "dlm {0} thn"
	],
	"quarter": [
		"previous": "Kuartal lalu",
		"current": "kuartal ini",
		"next": "kuartal berikutnya",
		"past": "{0} krtl. lalu",
		"future": "dlm {0} krtl."
	],
	"month": [
		"previous": "bulan lalu",
		"current": "bulan ini",
		"next": "bulan berikutnya",
		"past": "{0} bln lalu",
		"future": "dlm {0} bln"
	],
	"week": [
		"previous": "minggu lalu",
		"current": "minggu ini",
		"next": "minggu depan",
		"past": "{0} mgg lalu",
		"future": "dlm {0} mgg"
	],
	"day": [
		"previous": "kemarin",
		"current": "hari ini",
		"next": "besok",
		"past": "{0} h lalu",
		"future": "dalam {0} h"
	],
	"hour": [
		"current": "jam ini",
		"past": "{0} jam lalu",
		"future": "dalam {0} jam"
	],
	"minute": [
		"current": "menit ini",
		"past": "{0} mnt lalu",
		"future": "dlm {0} mnt"
	],
	"second": [
		"current": "sekarang",
		"past": "{0} dtk lalu",
		"future": "dlm {0} dtk"
	],
	"now": "sekarang"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "tahun lalu",
		"current": "tahun ini",
		"next": "tahun depan",
		"past": "{0} thn lalu",
		"future": "dlm {0} thn"
	],
	"quarter": [
		"previous": "Kuartal lalu",
		"current": "kuartal ini",
		"next": "kuartal berikutnya",
		"past": "{0} krtl. lalu",
		"future": "dlm {0} krtl."
	],
	"month": [
		"previous": "bulan lalu",
		"current": "bulan ini",
		"next": "bulan berikutnya",
		"past": "{0} bln lalu",
		"future": "dlm {0} bln"
	],
	"week": [
		"previous": "minggu lalu",
		"current": "minggu ini",
		"next": "minggu depan",
		"past": "{0} mgg lalu",
		"future": "dlm {0} mgg"
	],
	"day": [
		"previous": "kemarin",
		"current": "hari ini",
		"next": "besok",
		"past": "{0} h lalu",
		"future": "dalam {0} h"
	],
	"hour": [
		"current": "jam ini",
		"past": "{0} jam lalu",
		"future": "dalam {0} jam"
	],
	"minute": [
		"current": "menit ini",
		"past": "{0} mnt lalu",
		"future": "dlm {0} mnt"
	],
	"second": [
		"current": "sekarang",
		"past": "{0} dtk lalu",
		"future": "dlm {0} dtk"
	],
	"now": "sekarang"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "tahun lalu",
		"current": "tahun ini",
		"next": "tahun depan",
		"past": "{0} tahun yang lalu",
		"future": "dalam {0} tahun"
	],
	"quarter": [
		"previous": "Kuartal lalu",
		"current": "kuartal ini",
		"next": "kuartal berikutnya",
		"past": "{0} kuartal yang lalu",
		"future": "dalam {0} kuartal"
	],
	"month": [
		"previous": "bulan lalu",
		"current": "bulan ini",
		"next": "bulan berikutnya",
		"past": "{0} bulan yang lalu",
		"future": "dalam {0} bulan"
	],
	"week": [
		"previous": "minggu lalu",
		"current": "minggu ini",
		"next": "minggu depan",
		"past": "{0} minggu yang lalu",
		"future": "dalam {0} minggu"
	],
	"day": [
		"previous": "kemarin",
		"current": "hari ini",
		"next": "besok",
		"past": "{0} hari yang lalu",
		"future": "dalam {0} hari"
	],
	"hour": [
		"current": "jam ini",
		"past": "{0} jam yang lalu",
		"future": "dalam {0} jam"
	],
	"minute": [
		"current": "menit ini",
		"past": "{0} menit yang lalu",
		"future": "dalam {0} menit"
	],
	"second": [
		"current": "sekarang",
		"past": "{0} detik yang lalu",
		"future": "dalam {0} detik"
	],
	"now": "sekarang"
]
	}
}
