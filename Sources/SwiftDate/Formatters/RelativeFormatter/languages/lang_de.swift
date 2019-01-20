//
//  lang_de.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_de: RelativeFormatterLang {

	/// Locales.dutch
	public static let identifier: String = "de"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1:		return .one
		default:	return .other
		}
	}

	// module.exports=function(e){var i=String(e).split("."),n=Number(i{0})==e,r=n&&i{0}.slice(-1),s=n&&i{0}.slice(-2);return 1==r&&11!=s?"one":r>=2&&r<=4&&(s<12||s>14)?"few":n&&0==r||r>=5&&r<=9||s>=11&&s<=14?"many":"other"}
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
				"previous": "letztes Jahr",
				"current": "dieses Jahr",
				"next": "nächstes Jahr",
				"past": [
					"one": "vor {0} Jahr",
					"other": "vor {0} Jahren"
				],
				"future": [
					"one": "in {0} Jahr",
					"other": "in {0} Jahren"
				]
			],
			"quarter": [
				"previous": "letztes Quartal",
				"current": "dieses Quartal",
				"next": "nächstes Quartal",
				"past": "vor {0} Quart.",
				"future": "in {0} Quart."
			],
			"month": [
				"previous": "letzten Monat",
				"current": "diesen Monat",
				"next": "nächsten Monat",
				"past": [
					"one": "vor {0} Monat",
					"other": "vor {0} Monaten"
				],
				"future": [
					"one": "in {0} Monat",
					"other": "in {0} Monaten"
				]
			],
			"week": [
				"previous": "letzte Woche",
				"current": "diese Woche",
				"next": "nächste Woche",
				"past": [
					"one": "vor {0} Woche",
					"other": "vor {0} Wochen"
				],
				"future": [
					"one": "in {0} Woche",
					"other": "in {0} Wochen"
				]
			],
			"day": [
				"previous": "gestern",
				"current": "heute",
				"next": "morgen",
				"past": [
					"one": "vor {0} Tag",
					"other": "vor {0} Tagen"
				],
				"future": [
					"one": "in {0} Tag",
					"other": "in {0} Tagen"
				]
			],
			"hour": [
				"current": "in dieser Stunde",
				"past": "vor {0} Std.",
				"future": "in {0} Std."
			],
			"minute": [
				"current": "in dieser Minute",
				"past": "vor {0} Min.",
				"future": "in {0} Min."
			],
			"second": [
				"current": "jetzt",
				"past": "vor {0} Sek.",
				"future": "in {0} Sek."
			],
			"now": "jetzt"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "letztes Jahr",
				"current": "dieses Jahr",
				"next": "nächstes Jahr",
				"past": [
					"one": "vor {0} Jahr",
					"other": "vor {0} Jahren"
				],
				"future": [
					"one": "in {0} Jahr",
					"other": "in {0} Jahren"
				]
			],
			"quarter": [
				"previous": "letztes Quartal",
				"current": "dieses Quartal",
				"next": "nächstes Quartal",
				"past": "vor {0} Q",
				"future": "in {0} Q"
			],
			"month": [
				"previous": "letzten Monat",
				"current": "diesen Monat",
				"next": "nächsten Monat",
				"past": [
					"one": "vor {0} Monat",
					"other": "vor {0} Monaten"
				],
				"future": [
					"one": "in {0} Monat",
					"other": "in {0} Monaten"
				]
			],
			"week": [
				"previous": "letzte Woche",
				"current": "diese Woche",
				"next": "nächste Woche",
				"past": "vor {0} Wo.",
				"future": "in {0} Wo."
			],
			"day": [
				"previous": "gestern",
				"current": "heute",
				"next": "morgen",
				"past": [
					"one": "vor {0} Tag",
					"other": "vor {0} Tagen"
				],
				"future": [
					"one": "in {0} Tag",
					"other": "in {0} Tagen"
				]
			],
			"hour": [
				"current": "in dieser Stunde",
				"past": "vor {0} Std.",
				"future": "in {0} Std."
			],
			"minute": [
				"current": "in dieser Minute",
				"past": "vor {0} m",
				"future": "in {0} m"
			],
			"second": [
				"current": "jetzt",
				"past": "vor {0} s",
				"future": "in {0} s"
			],
			"now": "jetzt"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "letztes Jahr",
				"current": "dieses Jahr",
				"next": "nächstes Jahr",
				"past": [
					"one": "vor {0} Jahr",
					"other": "vor {0} Jahren"
				],
				"future": [
					"one": "in {0} Jahr",
					"other": "in {0} Jahren"
				]
			],
			"quarter": [
				"previous": "letztes Quartal",
				"current": "dieses Quartal",
				"next": "nächstes Quartal",
				"past": [
					"one": "vor {0} Quartal",
					"other": "vor {0} Quartalen"
				],
				"future": [
					"one": "in {0} Quartal",
					"other": "in {0} Quartalen"
				]
			],
			"month": [
				"previous": "letzten Monat",
				"current": "diesen Monat",
				"next": "nächsten Monat",
				"past": [
					"one": "vor {0} Monat",
					"other": "vor {0} Monaten"
				],
				"future": [
					"one": "in {0} Monat",
					"other": "in {0} Monaten"
				]
			],
			"week": [
				"previous": "letzte Woche",
				"current": "diese Woche",
				"next": "nächste Woche",
				"past": [
					"one": "vor {0} Woche",
					"other": "vor {0} Wochen"
				],
				"future": [
					"one": "in {0} Woche",
					"other": "in {0} Wochen"
				]
			],
			"day": [
				"previous": "gestern",
				"current": "heute",
				"next": "morgen",
				"past": [
					"one": "vor {0} Tag",
					"other": "vor {0} Tagen"
				],
				"future": [
					"one": "in {0} Tag",
					"other": "in {0} Tagen"
				]
			],
			"hour": [
				"current": "in dieser Stunde",
				"past": [
					"one": "vor {0} Stunde",
					"other": "vor {0} Stunden"
				],
				"future": [
					"one": "in {0} Stunde",
					"other": "in {0} Stunden"
				]
			],
			"minute": [
				"current": "in dieser Minute",
				"past": [
					"one": "vor {0} Minute",
					"other": "vor {0} Minuten"
				],
				"future": [
					"one": "in {0} Minute",
					"other": "in {0} Minuten"
				]
			],
			"second": [
				"current": "jetzt",
				"past": [
					"one": "vor {0} Sekunde",
					"other": "vor {0} Sekunden"
				],
				"future": [
					"one": "in {0} Sekunde",
					"other": "in {0} Sekunden"
				]
			],
			"now": "jetzt"
		]
	}
}
