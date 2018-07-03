import Foundation

// swiftlint:disable type_name
public class lang_fr: RelativeFormatterLang {

	/// French
	public static let identifier: String = "fr"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value < 2 ? .one : .other)
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
		"previous": "l’année dernière",
		"current": "cette année",
		"next": "l’année prochaine",
		"past": "il y a {0} a",
		"future": "dans {0} a"
	],
	"quarter": [
		"previous": "le trimestre dernier",
		"current": "ce trimestre",
		"next": "le trimestre prochain",
		"past": "il y a {0} trim.",
		"future": "dans {0} trim."
	],
	"month": [
		"previous": "le mois dernier",
		"current": "ce mois-ci",
		"next": "le mois prochain",
		"past": "il y a {0} m.",
		"future": "dans {0} m."
	],
	"week": [
		"previous": "la semaine dernière",
		"current": "cette semaine",
		"next": "la semaine prochaine",
		"past": "il y a {0} sem.",
		"future": "dans {0} sem."
	],
	"day": [
		"previous": "hier",
		"current": "aujourd’hui",
		"next": "demain",
		"past": "il y a {0} j",
		"future": "dans {0} j"
	],
	"hour": [
		"current": "cette heure-ci",
		"past": "il y a {0} h",
		"future": "dans {0} h"
	],
	"minute": [
		"current": "cette minute-ci",
		"past": "il y a {0} min",
		"future": "dans {0} min"
	],
	"second": [
		"current": "maintenant",
		"past": "il y a {0} s",
		"future": "dans {0} s"
	],
	"now": "maintenant"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "l’année dernière",
		"current": "cette année",
		"next": "l’année prochaine",
		"past": "-{0} a",
		"future": "+{0} a"
	],
	"quarter": [
		"previous": "le trimestre dernier",
		"current": "ce trimestre",
		"next": "le trimestre prochain",
		"past": "-{0} trim.",
		"future": "+{0} trim."
	],
	"month": [
		"previous": "le mois dernier",
		"current": "ce mois-ci",
		"next": "le mois prochain",
		"past": "-{0} m.",
		"future": "+{0} m."
	],
	"week": [
		"previous": "la semaine dernière",
		"current": "cette semaine",
		"next": "la semaine prochaine",
		"past": "-{0} sem.",
		"future": "+{0} sem."
	],
	"day": [
		"previous": "hier",
		"current": "aujourd’hui",
		"next": "demain",
		"past": "-{0} j",
		"future": "+{0} j"
	],
	"hour": [
		"current": "cette heure-ci",
		"past": "-{0} h",
		"future": "+{0} h"
	],
	"minute": [
		"current": "cette minute-ci",
		"past": "-{0} min",
		"future": "+{0} min"
	],
	"second": [
		"current": "maintenant",
		"past": "-{0} s",
		"future": "+{0} s"
	],
	"now": "maintenant"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "l’année dernière",
		"current": "cette année",
		"next": "l’année prochaine",
		"past": [
			"one": "il y a {0} an",
			"other": "il y a {0} ans"
		],
		"future": [
			"one": "dans {0} an",
			"other": "dans {0} ans"
		]
	],
	"quarter": [
		"previous": "le trimestre dernier",
		"current": "ce trimestre",
		"next": "le trimestre prochain",
		"past": [
			"one": "il y a {0} trimestre",
			"other": "il y a {0} trimestres"
		],
		"future": [
			"one": "dans {0} trimestre",
			"other": "dans {0} trimestres"
		]
	],
	"month": [
		"previous": "le mois dernier",
		"current": "ce mois-ci",
		"next": "le mois prochain",
		"past": "il y a {0} mois",
		"future": "dans {0} mois"
	],
	"week": [
		"previous": "la semaine dernière",
		"current": "cette semaine",
		"next": "la semaine prochaine",
		"past": [
			"one": "il y a {0} semaine",
			"other": "il y a {0} semaines"
		],
		"future": [
			"one": "dans {0} semaine",
			"other": "dans {0} semaines"
		]
	],
	"day": [
		"previous": "hier",
		"current": "aujourd’hui",
		"next": "demain",
		"past": [
			"one": "il y a {0} jour",
			"other": "il y a {0} jours"
		],
		"future": [
			"one": "dans {0} jour",
			"other": "dans {0} jours"
		]
	],
	"hour": [
		"current": "cette heure-ci",
		"past": [
			"one": "il y a {0} heure",
			"other": "il y a {0} heures"
		],
		"future": [
			"one": "dans {0} heure",
			"other": "dans {0} heures"
		]
	],
	"minute": [
		"current": "cette minute-ci",
		"past": [
			"one": "il y a {0} minute",
			"other": "il y a {0} minutes"
		],
		"future": [
			"one": "dans {0} minute",
			"other": "dans {0} minutes"
		]
	],
	"second": [
		"current": "maintenant",
		"past": [
			"one": "il y a {0} seconde",
			"other": "il y a {0} secondes"
		],
		"future": [
			"one": "dans {0} seconde",
			"other": "dans {0} secondes"
		]
	],
	"now": "maintenant"
]
	}
}
