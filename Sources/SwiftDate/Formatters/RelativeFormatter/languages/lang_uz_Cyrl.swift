import Foundation

// swiftlint:disable type_name
public class lang_uzCyrl: RelativeFormatterLang {

	/// Uzbek (Cyrillic)
	public static let identifier: String = "uz_Cyrl"

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
		"previous": "ўтган йил",
		"current": "бу йил",
		"next": "кейинги йил",
		"past": "{0} йил аввал",
		"future": "{0} йилдан сўнг"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "ўтган ой",
		"current": "бу ой",
		"next": "кейинги ой",
		"past": "{0} ой аввал",
		"future": "{0} ойдан сўнг"
	],
	"week": [
		"previous": "ўтган ҳафта",
		"current": "бу ҳафта",
		"next": "кейинги ҳафта",
		"past": "{0} ҳафта олдин",
		"future": "{0} ҳафтадан сўнг"
	],
	"day": [
		"previous": "кеча",
		"current": "бугун",
		"next": "эртага",
		"past": "{0} кун олдин",
		"future": "{0} кундан сўнг"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} соат олдин",
		"future": "{0} соатдан сўнг"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} дақиқа олдин",
		"future": "{0} дақиқадан сўнг"
	],
	"second": [
		"current": "ҳозир",
		"past": "{0} сония олдин",
		"future": "{0} сониядан сўнг"
	],
	"now": "ҳозир"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ўтган йил",
		"current": "бу йил",
		"next": "кейинги йил",
		"past": "{0} йил аввал",
		"future": "{0} йилдан сўнг"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "ўтган ой",
		"current": "бу ой",
		"next": "кейинги ой",
		"past": "{0} ой аввал",
		"future": "{0} ойдан сўнг"
	],
	"week": [
		"previous": "ўтган ҳафта",
		"current": "бу ҳафта",
		"next": "кейинги ҳафта",
		"past": "{0} ҳафта олдин",
		"future": "{0} ҳафтадан сўнг"
	],
	"day": [
		"previous": "кеча",
		"current": "бугун",
		"next": "эртага",
		"past": "{0} кун олдин",
		"future": "{0} кундан сўнг"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} соат олдин",
		"future": "{0} соатдан сўнг"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} дақиқа олдин",
		"future": "{0} дақиқадан сўнг"
	],
	"second": [
		"current": "ҳозир",
		"past": "{0} сония олдин",
		"future": "{0} сониядан сўнг"
	],
	"now": "ҳозир"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ўтган йил",
		"current": "бу йил",
		"next": "кейинги йил",
		"past": "{0} йил аввал",
		"future": "{0} йилдан сўнг"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "ўтган ой",
		"current": "бу ой",
		"next": "кейинги ой",
		"past": "{0} ой аввал",
		"future": "{0} ойдан сўнг"
	],
	"week": [
		"previous": "ўтган ҳафта",
		"current": "бу ҳафта",
		"next": "кейинги ҳафта",
		"past": "{0} ҳафта олдин",
		"future": "{0} ҳафтадан сўнг"
	],
	"day": [
		"previous": "кеча",
		"current": "бугун",
		"next": "эртага",
		"past": "{0} кун олдин",
		"future": "{0} кундан сўнг"
	],
	"hour": [
		"current": "this hour",
		"past": "{0} соат олдин",
		"future": "{0} соатдан сўнг"
	],
	"minute": [
		"current": "this minute",
		"past": "{0} дақиқа олдин",
		"future": "{0} дақиқадан сўнг"
	],
	"second": [
		"current": "ҳозир",
		"past": "{0} сония олдин",
		"future": "{0} сониядан сўнг"
	],
	"now": "ҳозир"
]
	}
}
