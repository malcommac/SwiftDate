import Foundation

// swiftlint:disable type_name
public class lang_hu: RelativeFormatterLang {

	/// Hungarian
	public static let identifier: String = "hu"

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
		"previous": "előző év",
		"current": "ez az év",
		"next": "következő év",
		"past": "{0} évvel ezelőtt",
		"future": "{0} év múlva"
	],
	"quarter": [
		"previous": "előző negyedév",
		"current": "ez a negyedév",
		"next": "következő negyedév",
		"past": "{0} negyedévvel ezelőtt",
		"future": "{0} negyedév múlva"
	],
	"month": [
		"previous": "előző hónap",
		"current": "ez a hónap",
		"next": "következő hónap",
		"past": "{0} hónappal ezelőtt",
		"future": "{0} hónap múlva"
	],
	"week": [
		"previous": "előző hét",
		"current": "ez a hét",
		"next": "következő hét",
		"past": "{0} héttel ezelőtt",
		"future": "{0} hét múlva"
	],
	"day": [
		"previous": "tegnap",
		"current": "ma",
		"next": "holnap",
		"past": "{0} napja",
		"future": "{0} nap múlva"
	],
	"hour": [
		"current": "ebben az órában",
		"past": "{0} órával ezelőtt",
		"future": "{0} óra múlva"
	],
	"minute": [
		"current": "ebben a percben",
		"past": "{0} perccel ezelőtt",
		"future": "{0} perc múlva"
	],
	"second": [
		"current": "most",
		"past": "{0} másodperccel ezelőtt",
		"future": "{0} másodperc múlva"
	],
	"now": "most"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "előző év",
		"current": "ez az év",
		"next": "következő év",
		"past": "{0} évvel ezelőtt",
		"future": "{0} év múlva"
	],
	"quarter": [
		"previous": "előző negyedév",
		"current": "ez a negyedév",
		"next": "következő negyedév",
		"past": "{0} negyedévvel ezelőtt",
		"future": "{0} n.év múlva"
	],
	"month": [
		"previous": "előző hónap",
		"current": "ez a hónap",
		"next": "következő hónap",
		"past": "{0} hónappal ezelőtt",
		"future": "{0} hónap múlva"
	],
	"week": [
		"previous": "előző hét",
		"current": "ez a hét",
		"next": "következő hét",
		"past": "{0} héttel ezelőtt",
		"future": "{0} hét múlva"
	],
	"day": [
		"previous": "tegnap",
		"current": "ma",
		"next": "holnap",
		"past": "{0} napja",
		"future": "{0} nap múlva"
	],
	"hour": [
		"current": "ebben az órában",
		"past": "{0} órával ezelőtt",
		"future": "{0} óra múlva"
	],
	"minute": [
		"current": "ebben a percben",
		"past": "{0} perccel ezelőtt",
		"future": "{0} perc múlva"
	],
	"second": [
		"current": "most",
		"past": "{0} másodperccel ezelőtt",
		"future": "{0} másodperc múlva"
	],
	"now": "most"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "előző év",
		"current": "ez az év",
		"next": "következő év",
		"past": "{0} évvel ezelőtt",
		"future": "{0} év múlva"
	],
	"quarter": [
		"previous": "előző negyedév",
		"current": "ez a negyedév",
		"next": "következő negyedév",
		"past": "{0} negyedévvel ezelőtt",
		"future": "{0} negyedév múlva"
	],
	"month": [
		"previous": "előző hónap",
		"current": "ez a hónap",
		"next": "következő hónap",
		"past": "{0} hónappal ezelőtt",
		"future": "{0} hónap múlva"
	],
	"week": [
		"previous": "előző hét",
		"current": "ez a hét",
		"next": "következő hét",
		"past": "{0} héttel ezelőtt",
		"future": "{0} hét múlva"
	],
	"day": [
		"previous": "tegnap",
		"current": "ma",
		"next": "holnap",
		"past": "{0} nappal ezelőtt",
		"future": "{0} nap múlva"
	],
	"hour": [
		"current": "ebben az órában",
		"past": "{0} órával ezelőtt",
		"future": "{0} óra múlva"
	],
	"minute": [
		"current": "ebben a percben",
		"past": "{0} perccel ezelőtt",
		"future": "{0} perc múlva"
	],
	"second": [
		"current": "most",
		"past": "{0} másodperccel ezelőtt",
		"future": "{0} másodperc múlva"
	],
	"now": "most"
]
	}
}
