import Foundation

// swiftlint:disable type_name
public class lang_tk: RelativeFormatterLang {

	/// Turkmen
	public static let identifier: String = "tk"

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
		"previous": "geçen ýyl",
		"current": "şu ýyl",
		"next": "indiki ýyl",
		"past": "{0}ý. öň",
		"future": "{0}ý.-dan"
	],
	"quarter": [
		"previous": "geçen çärýek",
		"current": "şu çärýek",
		"next": "indiki çärýek",
		"past": "{0} çär. öň",
		"future": "{0} çär.-den"
	],
	"month": [
		"previous": "geçen aý",
		"current": "şu aý",
		"next": "indiki aý",
		"past": "{0} aý öň",
		"future": "{0} aýdan"
	],
	"week": [
		"previous": "geçen hepde",
		"current": "şu hepde",
		"next": "indiki hepde",
		"past": "{0} hep. öň",
		"future": "{0} hep-den"
	],
	"day": [
		"previous": "düýn",
		"current": "şu gün",
		"next": "ertir",
		"past": "{0} g. öň",
		"future": "{0} g-den"
	],
	"hour": [
		"current": "şu sagat",
		"past": "{0} sag. öň",
		"future": "{0} sag-dan"
	],
	"minute": [
		"current": "şu minut",
		"past": "{0} min. öň",
		"future": "{0} min-dan"
	],
	"second": [
		"current": "häzir",
		"past": "{0} sek. öň",
		"future": "{0} sek-dan"
	],
	"now": "häzir"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "geçen ýyl",
		"current": "şu ýyl",
		"next": "indiki ýyl",
		"past": "{0}ý. öň",
		"future": "{0}ý.-dan"
	],
	"quarter": [
		"previous": "geçen çärýek",
		"current": "şu çärýek",
		"next": "indiki çärýek",
		"past": "{0} ç. öň",
		"future": "{0} ç.-den"
	],
	"month": [
		"previous": "geçen aý",
		"current": "şu aý",
		"next": "indiki aý",
		"past": "{0} aý öň",
		"future": "{0} aýdan"
	],
	"week": [
		"previous": "geçen hepde",
		"current": "şu hepde",
		"next": "indiki hepde",
		"past": "{0} h. öň",
		"future": "{0} h-den"
	],
	"day": [
		"previous": "düýn",
		"current": "şu gün",
		"next": "ertir",
		"past": "{0} g. öň",
		"future": "{0} g-den"
	],
	"hour": [
		"current": "şu sagat",
		"past": "{0} sag. öň",
		"future": "{0} sag-dan"
	],
	"minute": [
		"current": "şu minut",
		"past": "{0} min. öň",
		"future": "{0} min-dan"
	],
	"second": [
		"current": "häzir",
		"past": "{0} sek. öň",
		"future": "{0} sek-dan"
	],
	"now": "häzir"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "geçen ýyl",
		"current": "şu ýyl",
		"next": "indiki ýyl",
		"past": "{0} ýyl öň",
		"future": "{0} ýyldan"
	],
	"quarter": [
		"previous": "geçen çärýek",
		"current": "şu çärýek",
		"next": "indiki çärýek",
		"past": "{0} çärýek öň",
		"future": "{0} çärýekden"
	],
	"month": [
		"previous": "geçen aý",
		"current": "şu aý",
		"next": "indiki aý",
		"past": "{0} aý öň",
		"future": "{0} aýdan"
	],
	"week": [
		"previous": "geçen hepde",
		"current": "şu hepde",
		"next": "indiki hepde",
		"past": "{0} hepde öň",
		"future": "{0} hepdeden"
	],
	"day": [
		"previous": "düýn",
		"current": "şu gün",
		"next": "ertir",
		"past": "{0} gün öň",
		"future": "{0} günden"
	],
	"hour": [
		"current": "şu sagat",
		"past": "{0} sagat öň",
		"future": "{0} sagatdan"
	],
	"minute": [
		"current": "şu minut",
		"past": "{0} minut öň",
		"future": "{0} minutdan"
	],
	"second": [
		"current": "häzir",
		"past": "{0} sekunt öň",
		"future": "{0} sekuntdan"
	],
	"now": "häzir"
]
	}
}
