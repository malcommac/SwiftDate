import Foundation

// swiftlint:disable type_name
public class lang_tr: RelativeFormatterLang {

	/// Turkish
	public static let identifier: String = "tr"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
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
		"previous": "geçen yıl",
		"current": "bu yıl",
		"next": "gelecek yıl",
		"past": "{0} yıl önce",
		"future": "{0} yıl sonra"
	],
	"quarter": [
		"previous": "geçen çeyrek",
		"current": "bu çeyrek",
		"next": "gelecek çeyrek",
		"past": "{0} çyr. önce",
		"future": "{0} çyr. sonra"
	],
	"month": [
		"previous": "geçen ay",
		"current": "bu ay",
		"next": "gelecek ay",
		"past": "{0} ay önce",
		"future": "{0} ay sonra"
	],
	"week": [
		"previous": "geçen hafta",
		"current": "bu hafta",
		"next": "gelecek hafta",
		"past": "{0} hf. önce",
		"future": "{0} hf. sonra"
	],
	"day": [
		"previous": "dün",
		"current": "bugün",
		"next": "yarın",
		"past": "{0} gün önce",
		"future": "{0} gün sonra"
	],
	"hour": [
		"current": "bu saat",
		"past": "{0} sa. önce",
		"future": "{0} sa. sonra"
	],
	"minute": [
		"current": "bu dakika",
		"past": "{0} dk. önce",
		"future": "{0} dk. sonra"
	],
	"second": [
		"current": "şimdi",
		"past": "{0} sn. önce",
		"future": "{0} sn. sonra"
	],
	"now": "şimdi"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "geçen yıl",
		"current": "bu yıl",
		"next": "gelecek yıl",
		"past": "{0} yıl önce",
		"future": "{0} yıl sonra"
	],
	"quarter": [
		"previous": "geçen çeyrek",
		"current": "bu çeyrek",
		"next": "gelecek çeyrek",
		"past": "{0} çyr. önce",
		"future": "{0} çyr. sonra"
	],
	"month": [
		"previous": "geçen ay",
		"current": "bu ay",
		"next": "gelecek ay",
		"past": "{0} ay önce",
		"future": "{0} ay sonra"
	],
	"week": [
		"previous": "geçen hafta",
		"current": "bu hafta",
		"next": "gelecek hafta",
		"past": "{0} hf. önce",
		"future": "{0} hf. sonra"
	],
	"day": [
		"previous": "dün",
		"current": "bugün",
		"next": "yarın",
		"past": "{0} gün önce",
		"future": "{0} gün sonra"
	],
	"hour": [
		"current": "bu saat",
		"past": "{0} sa. önce",
		"future": "{0} sa. sonra"
	],
	"minute": [
		"current": "bu dakika",
		"past": "{0} dk. önce",
		"future": "{0} dk. sonra"
	],
	"second": [
		"current": "şimdi",
		"past": "{0} sn. önce",
		"future": "{0} sn. sonra"
	],
	"now": "şimdi"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "geçen yıl",
		"current": "bu yıl",
		"next": "gelecek yıl",
		"past": "{0} yıl önce",
		"future": "{0} yıl sonra"
	],
	"quarter": [
		"previous": "geçen çeyrek",
		"current": "bu çeyrek",
		"next": "gelecek çeyrek",
		"past": "{0} çeyrek önce",
		"future": "{0} çeyrek sonra"
	],
	"month": [
		"previous": "geçen ay",
		"current": "bu ay",
		"next": "gelecek ay",
		"past": "{0} ay önce",
		"future": "{0} ay sonra"
	],
	"week": [
		"previous": "geçen hafta",
		"current": "bu hafta",
		"next": "gelecek hafta",
		"past": "{0} hafta önce",
		"future": "{0} hafta sonra"
	],
	"day": [
		"previous": "dün",
		"current": "bugün",
		"next": "yarın",
		"past": "{0} gün önce",
		"future": "{0} gün sonra"
	],
	"hour": [
		"current": "bu saat",
		"past": "{0} saat önce",
		"future": "{0} saat sonra"
	],
	"minute": [
		"current": "bu dakika",
		"past": "{0} dakika önce",
		"future": "{0} dakika sonra"
	],
	"second": [
		"current": "şimdi",
		"past": "{0} saniye önce",
		"future": "{0} saniye sonra"
	],
	"now": "şimdi"
]
	}
}
