//
//  lang_eu.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_eu: RelativeFormatterLang {

	/// Locales.basque
	public static let identifier: String = "eu"

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
				"previous": "aurreko urtea",
				"current": "aurten",
				"next": "hurrengo urtea",
				"past": "Duela {0} urte",
				"future": "{0} urte barru"
			],
			"quarter": [
				"previous": "aurreko hiruhilekoa",
				"current": "hiruhileko hau",
				"next": "hurrengo hiruhilekoa",
				"past": "Duela {0} hiruhileko",
				"future": "{0} hiruhileko barru"
			],
			"month": [
				"previous": "aurreko hilabetean",
				"current": "hilabete honetan",
				"next": "hurrengo hilabetean",
				"past": "Duela {0} hilabete",
				"future": "{0} hilabete barru"
			],
			"week": [
				"previous": "aurreko astean",
				"current": "aste honetan",
				"next": "hurrengo astean",
				"past": "Duela {0} aste",
				"future": "{0} aste barru"
			],
			"day": [
				"previous": "atzo",
				"current": "gaur",
				"next": "bihar",
				"past": "Duela {0} egun",
				"future": "{0} egun barru"
			],
			"hour": [
				"current": "ordu honetan",
				"past": "Duela {0} ordu",
				"future": "{0} ordu barru"
			],
			"minute": [
				"current": "minutu honetan",
				"past": "Duela {0} minutu",
				"future": "{0} minutu barru"
			],
			"second": [
				"current": "orain",
				"past": "Duela {0} segundo",
				"future": "{0} segundo barru"
			],
			"now": "orain"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "aurreko urtea",
				"current": "aurten",
				"next": "hurrengo urtea",
				"past": "Duela {0} urte",
				"future": "{0} urte barru"
			],
			"quarter": [
				"previous": "aurreko hiruhilekoa",
				"current": "hiruhileko hau",
				"next": "hurrengo hiruhilekoa",
				"past": "Duela {0} hiruhileko",
				"future": "{0} hiruhileko barru"
			],
			"month": [
				"previous": "aurreko hilabetean",
				"current": "hilabete honetan",
				"next": "hurrengo hilabetean",
				"past": "Duela {0} hilabete",
				"future": "{0} hilabete barru"
			],
			"week": [
				"previous": "aurreko astean",
				"current": "aste honetan",
				"next": "hurrengo astean",
				"past": "Duela {0} aste",
				"future": "{0} aste barru"
			],
			"day": [
				"previous": "atzo",
				"current": "gaur",
				"next": "bihar",
				"past": "Duela {0} egun",
				"future": "{0} egun barru"
			],
			"hour": [
				"current": "ordu honetan",
				"past": "Duela {0} ordu",
				"future": "{0} ordu barru"
			],
			"minute": [
				"current": "minutu honetan",
				"past": "Duela {0} minutu",
				"future": "{0} minutu barru"
			],
			"second": [
				"current": "orain",
				"past": "Duela {0} segundo",
				"future": "{0} segundo barru"
			],
			"now": "orain"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "iaz",
				"current": "aurten",
				"next": "hurrengo urtean",
				"past": "Duela {0} urte",
				"future": "{0} urte barru"
			],
			"quarter": [
				"previous": "aurreko hiruhilekoa",
				"current": "hiruhileko hau",
				"next": "hurrengo hiruhilekoa",
				"past": "Duela {0} hiruhileko",
				"future": "{0} hiruhileko barru"
			],
			"month": [
				"previous": "aurreko hilabetean",
				"current": "hilabete honetan",
				"next": "hurrengo hilabetean",
				"past": "Duela {0} hilabete",
				"future": "{0} hilabete barru"
			],
			"week": [
				"previous": "aurreko astean",
				"current": "aste honetan",
				"next": "hurrengo astean",
				"past": "Duela {0} aste",
				"future": "{0} aste barru"
			],
			"day": [
				"previous": "atzo",
				"current": "gaur",
				"next": "bihar",
				"past": "Duela {0} egun",
				"future": "{0} egun barru"
			],
			"hour": [
				"current": "ordu honetan",
				"past": "Duela {0} ordu",
				"future": "{0} ordu barru"
			],
			"minute": [
				"current": "minutu honetan",
				"past": "Duela {0} minutu",
				"future": "{0} minutu barru"
			],
			"second": [
				"current": "orain",
				"past": "Duela {0} segundo",
				"future": "{0} segundo barru"
			],
			"now": "orain"
		]
	}
}
