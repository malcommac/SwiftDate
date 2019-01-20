//
//  lang_af.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name// swiftlint:disable type_name
public class lang_af: RelativeFormatterLang {

	/// Locales.afrikaans
	public static let identifier: String = "af"

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
				"previous": "verlede jaar",
				"current": "hierdie jaar",
				"next": "volgende jaar",
				"past": "{0} jaar gelede",
				"future": "oor {0} jaar"
			],
			"quarter": [
				"previous": "vorige kwartaal",
				"current": "hierdie kwartaal",
				"next": "volgende kwartaal",
				"past": [
					"one": "{0} kwartaal gelede",
					"other": "{0} kwartale gelede"
				],
				"future": [
					"one": "oor {0} kwartaal",
					"other": "oor {0} kwartale"
				]
			],
			"month": [
				"previous": "verlede maand",
				"current": "vandeesmaand",
				"next": "volgende maand",
				"past": "{0} md. gelede",
				"future": "oor {0} md."
			],
			"week": [
				"previous": "verlede week",
				"current": "vandeesweek",
				"next": "volgende week",
				"past": "{0} w. gelede",
				"future": "oor {0} w."
			],
			"day": [
				"previous": "gister",
				"current": "vandag",
				"next": "môre",
				"past": [
					"one": "{0} dag gelede",
					"other": "{0} dae gelede"
				],
				"future": [
					"one": "oor {0} dag",
					"other": "oor {0} dae"
				]
			],
			"hour": [
				"current": "hierdie uur",
				"past": "{0} uur gelede",
				"future": "oor {0} uur"
			],
			"minute": [
				"current": "hierdie minuut",
				"past": "{0} min. gelede",
				"future": "oor {0} min."
			],
			"second": [
				"current": "nou",
				"past": "{0} sek. gelede",
				"future": "oor {0} sek."
			],
			"now": "nou"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "verlede jaar",
				"current": "hierdie jaar",
				"next": "volgende jaar",
				"past": "{0} jaar gelede",
				"future": "oor {0} jaar"
			],
			"quarter": [
				"previous": "vorige kwartaal",
				"current": "hierdie kwartaal",
				"next": "volgende kwartaal",
				"past": "{0} kwartale gelede",
				"future": "oor {0} kwartale"
			],
			"month": [
				"previous": "verlede maand",
				"current": "vandeesmaand",
				"next": "volgende maand",
				"past": "{0} md. gelede",
				"future": "oor {0} md."
			],
			"week": [
				"previous": "verlede week",
				"current": "vandeesweek",
				"next": "volgende week",
				"past": "{0} w. gelede",
				"future": "oor {0} w."
			],
			"day": [
				"previous": "gister",
				"current": "vandag",
				"next": "môre",
				"past": [
					"one": "{0} dag gelede",
					"other": "{0} dae gelede"
				],
				"future": [
					"one": "oor {0} dag",
					"other": "oor {0} dae"
				]
			],
			"hour": [
				"current": "hierdie uur",
				"past": "{0} uur gelede",
				"future": "oor {0} uur"
			],
			"minute": [
				"current": "hierdie minuut",
				"past": "{0} min. gelede",
				"future": "oor {0} min."
			],
			"second": [
				"current": "nou",
				"past": "{0} sek. gelede",
				"future": "oor {0} sek."
			],
			"now": "nou"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "verlede jaar",
				"current": "hierdie jaar",
				"next": "volgende jaar",
				"past": "{0} jaar gelede",
				"future": "oor {0} jaar"
			],
			"quarter": [
				"previous": "vorige kwartaal",
				"current": "hierdie kwartaal",
				"next": "volgende kwartaal",
				"past": [
					"one": "{0} kwartaal gelede",
					"other": "{0} kwartale gelede"
				],
				"future": [
					"one": "oor {0} kwartaal",
					"other": "oor {0} kwartale"
				]
			],
			"month": [
				"previous": "verlede maand",
				"current": "vandeesmaand",
				"next": "volgende maand",
				"past": [
					"one": "{0} maand gelede",
					"other": "{0} maande gelede"
				],
				"future": "oor {0} minuut"
			],
			"week": [
				"previous": "verlede week",
				"current": "vandeesweek",
				"next": "volgende week",
				"past": [
					"one": "{0} week gelede",
					"other": "{0} weke gelede"
				],
				"future": [
					"one": "oor {0} week",
					"other": "oor {0} weke"
				]
			],
			"day": [
				"previous": "gister",
				"current": "vandag",
				"next": "môre",
				"past": [
					"one": "{0} dag gelede",
					"other": "{0} dae gelede"
				],
				"future": [
					"one": "oor {0} dag",
					"other": "oor {0} dae"
				]
			],
			"hour": [
				"current": "hierdie uur",
				"past": "{0} uur gelede",
				"future": "oor {0} uur"
			],
			"minute": [
				"current": "hierdie minuut",
				"past": [
					"one": "{0} minuut gelede",
					"other": "{0} minute gelede"
				],
				"future": "oor {0} minuut"
			],
			"second": [
				"current": "nou",
				"past": [
					"one": "{0} sekonde gelede",
					"other": "{0} sekondes gelede"
				],
				"future": [
					"one": "oor {0} sekonde",
					"other": "oor {0} sekondes"
				]
			],
			"now": "nou"
		]
	}
}
