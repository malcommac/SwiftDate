import Foundation

// swiftlint:disable type_name
public class lang_lkt: RelativeFormatterLang {

	/// Lakota
	public static let identifier: String = "lkt"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return nil
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
		"previous": "Ómakȟa kʼuŋ héhaŋ",
		"current": "Lé ómakȟa kiŋ",
		"next": "Tȟokáta ómakȟa kiŋháŋ",
		"past": "Hékta ómakȟa {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ ómakȟa {0} kiŋháŋ"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "Wí kʼuŋ héhaŋ",
		"current": "Lé wí kiŋ",
		"next": "Tȟokáta wí kiŋháŋ",
		"past": "Hékta wíyawapi {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ wíyawapi {0} kiŋháŋ"
	],
	"week": [
		"previous": "Okó kʼuŋ héhaŋ",
		"current": "Lé okó kiŋ",
		"next": "Tȟokáta okó kiŋháŋ",
		"past": "Hékta okó {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ okó {0} kiŋháŋ"
	],
	"day": [
		"previous": "Ȟtálehaŋ",
		"current": "Lé aŋpétu kiŋ",
		"next": "Híŋhaŋni kiŋháŋ",
		"past": "Hékta {0}-čháŋ k’uŋ héhaŋ",
		"future": "Letáŋhaŋ {0}-čháŋ kiŋháŋ"
	],
	"hour": [
		"current": "this hour",
		"past": "Hékta owápȟe {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ owápȟe {0} kiŋháŋ"
	],
	"minute": [
		"current": "this minute",
		"past": "Hékta oȟ’áŋkȟo {0} k’uŋ héhaŋ",
		"future": "Letáŋhaŋ oȟ’áŋkȟo {0} kiŋháŋ"
	],
	"second": [
		"current": "now",
		"past": "Hékta okpí {0} k’uŋ héhaŋ",
		"future": "Letáŋhaŋ okpí {0} kiŋháŋ"
	],
	"now": "now"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "Ómakȟa kʼuŋ héhaŋ",
		"current": "Lé ómakȟa kiŋ",
		"next": "Tȟokáta ómakȟa kiŋháŋ",
		"past": "Hékta ómakȟa {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ ómakȟa {0} kiŋháŋ"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "Wí kʼuŋ héhaŋ",
		"current": "Lé wí kiŋ",
		"next": "Tȟokáta wí kiŋháŋ",
		"past": "Hékta wíyawapi {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ wíyawapi {0} kiŋháŋ"
	],
	"week": [
		"previous": "Okó kʼuŋ héhaŋ",
		"current": "Lé okó kiŋ",
		"next": "Tȟokáta okó kiŋháŋ",
		"past": "Hékta okó {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ okó {0} kiŋháŋ"
	],
	"day": [
		"previous": "Ȟtálehaŋ",
		"current": "Lé aŋpétu kiŋ",
		"next": "Híŋhaŋni kiŋháŋ",
		"past": "Hékta {0}-čháŋ k’uŋ héhaŋ",
		"future": "Letáŋhaŋ {0}-čháŋ kiŋháŋ"
	],
	"hour": [
		"current": "this hour",
		"past": "Hékta owápȟe {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ owápȟe {0} kiŋháŋ"
	],
	"minute": [
		"current": "this minute",
		"past": "Hékta oȟ’áŋkȟo {0} k’uŋ héhaŋ",
		"future": "Letáŋhaŋ oȟ’áŋkȟo {0} kiŋháŋ"
	],
	"second": [
		"current": "now",
		"past": "Hékta okpí {0} k’uŋ héhaŋ",
		"future": "Letáŋhaŋ okpí {0} kiŋháŋ"
	],
	"now": "now"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "Ómakȟa kʼuŋ héhaŋ",
		"current": "Lé ómakȟa kiŋ",
		"next": "Tȟokáta ómakȟa kiŋháŋ",
		"past": "Hékta ómakȟa {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ ómakȟa {0} kiŋháŋ"
	],
	"quarter": [
		"previous": "last quarter",
		"current": "this quarter",
		"next": "next quarter",
		"past": "-{0} Q",
		"future": "+{0} Q"
	],
	"month": [
		"previous": "Wí kʼuŋ héhaŋ",
		"current": "Lé wí kiŋ",
		"next": "Tȟokáta wí kiŋháŋ",
		"past": "Hékta wíyawapi {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ wíyawapi {0} kiŋháŋ"
	],
	"week": [
		"previous": "Okó kʼuŋ héhaŋ",
		"current": "Lé okó kiŋ",
		"next": "Tȟokáta okó kiŋháŋ",
		"past": "Hékta okó {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ okó {0} kiŋháŋ"
	],
	"day": [
		"previous": "Ȟtálehaŋ",
		"current": "Lé aŋpétu kiŋ",
		"next": "Híŋhaŋni kiŋháŋ",
		"past": "Hékta {0}-čháŋ k’uŋ héhaŋ",
		"future": "Letáŋhaŋ {0}-čháŋ kiŋháŋ"
	],
	"hour": [
		"current": "this hour",
		"past": "Hékta owápȟe {0} kʼuŋ héhaŋ",
		"future": "Letáŋhaŋ owápȟe {0} kiŋháŋ"
	],
	"minute": [
		"current": "this minute",
		"past": "Hékta oȟ’áŋkȟo {0} k’uŋ héhaŋ",
		"future": "Letáŋhaŋ oȟ’áŋkȟo {0} kiŋháŋ"
	],
	"second": [
		"current": "now",
		"past": "Hékta okpí {0} k’uŋ héhaŋ",
		"future": "Letáŋhaŋ okpí {0} kiŋháŋ"
	],
	"now": "now"
]
	}
}
