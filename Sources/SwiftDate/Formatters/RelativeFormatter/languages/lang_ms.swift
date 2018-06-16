import Foundation

// swiftlint:disable type_name
public class lang_ms: RelativeFormatterLang {

	/// Malay
	public static let identifier: String = "ms"

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
		"previous": "thn lepas",
		"current": "thn ini",
		"next": "thn depan",
		"past": "{0} thn lalu",
		"future": "dalam {0} thn"
	],
	"quarter": [
		"previous": "suku lepas",
		"current": "suku ini",
		"next": "suku seterusnya",
		"past": "{0} suku thn lalu",
		"future": "dlm {0} suku thn"
	],
	"month": [
		"previous": "bln lalu",
		"current": "bln ini",
		"next": "bln depan",
		"past": "{0} bln lalu",
		"future": "dlm {0} bln"
	],
	"week": [
		"previous": "mng lepas",
		"current": "mng ini",
		"next": "mng depan",
		"past": "{0} mgu lalu",
		"future": "dlm {0} mgu"
	],
	"day": [
		"previous": "semlm",
		"current": "hari ini",
		"next": "esok",
		"past": "{0} hari lalu",
		"future": "dlm {0} hari"
	],
	"hour": [
		"current": "jam ini",
		"past": "{0} jam lalu",
		"future": "dlm {0} jam"
	],
	"minute": [
		"current": "pada minit ini",
		"past": "{0} min lalu",
		"future": "dlm {0} min"
	],
	"second": [
		"current": "sekarang",
		"past": "{0} saat lalu",
		"future": "dlm {0} saat"
	],
	"now": "sekarang"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "thn lepas",
		"current": "thn ini",
		"next": "thn depan",
		"past": "{0} thn lalu",
		"future": "dalam {0} thn"
	],
	"quarter": [
		"previous": "suku lepas",
		"current": "suku ini",
		"next": "suku seterusnya",
		"past": "{0} suku thn lalu",
		"future": "dlm {0} suku thn"
	],
	"month": [
		"previous": "bln lalu",
		"current": "bln ini",
		"next": "bln depan",
		"past": "{0} bulan lalu",
		"future": "dlm {0} bln"
	],
	"week": [
		"previous": "mng lepas",
		"current": "mng ini",
		"next": "mng depan",
		"past": "{0} mgu lalu",
		"future": "dlm {0} mgu"
	],
	"day": [
		"previous": "semlm",
		"current": "hari ini",
		"next": "esok",
		"past": "{0} hari lalu",
		"future": "dlm {0} hari"
	],
	"hour": [
		"current": "jam ini",
		"past": "{0} jam lalu",
		"future": "dlm {0} jam"
	],
	"minute": [
		"current": "pada minit ini",
		"past": "{0} min lalu",
		"future": "dlm {0} min"
	],
	"second": [
		"current": "sekarang",
		"past": "{0} saat lalu",
		"future": "dlm {0} saat"
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
		"past": "{0} tahun lalu",
		"future": "dalam {0} tahun"
	],
	"quarter": [
		"previous": "suku tahun lalu",
		"current": "suku tahun ini",
		"next": "suku tahun seterusnya",
		"past": "{0} suku tahun lalu",
		"future": "dalam {0} suku tahun"
	],
	"month": [
		"previous": "bulan lalu",
		"current": "bulan ini",
		"next": "bulan depan",
		"past": "{0} bulan lalu",
		"future": "dalam {0} bulan"
	],
	"week": [
		"previous": "minggu lalu",
		"current": "minggu ini",
		"next": "minggu depan",
		"past": "{0} minggu lalu",
		"future": "dalam {0} minggu"
	],
	"day": [
		"previous": "semalam",
		"current": "hari ini",
		"next": "esok",
		"past": "{0} hari lalu",
		"future": "dalam {0} hari"
	],
	"hour": [
		"current": "jam ini",
		"past": "{0} jam lalu",
		"future": "dalam {0} jam"
	],
	"minute": [
		"current": "pada minit ini",
		"past": "{0} minit lalu",
		"future": "dalam {0} minit"
	],
	"second": [
		"current": "sekarang",
		"past": "{0} saat lalu",
		"future": "dalam {0} saat"
	],
	"now": "sekarang"
]
	}
}
