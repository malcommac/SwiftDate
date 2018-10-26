//
//  lang_bs.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_bs: RelativeFormatterLang {

	/// Locales.bosnian
	public static let identifier: String = "bs"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		let mod10 = Int(value) % 10
		let mod100 = Int(value) % 100

		switch mod10 {
		case 1:
			switch mod100 {
			case 11:
				break
			default:
				return .one
			}
		case 2, 3, 4:
			switch mod100 {
			case 12, 13, 14:
				break
			default:
				return .few
			}
		default:
			break
		}
		return .many
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
				"previous": "prošle godine",
				"current": "ove godine",
				"next": "sljedeće godine",
				"past": "prije {0} god.",
				"future": "za {0} god."
			],
			"quarter": [
				"previous": "posljednji kvartal",
				"current": "ovaj kvartal",
				"next": "sljedeći kvartal",
				"past": "prije {0} kv.",
				"future": "za {0} kv."
			],
			"month": [
				"previous": "prošli mjesec",
				"current": "ovaj mjesec",
				"next": "sljedeći mjesec",
				"past": "prije {0} mj.",
				"future": "za {0} mj."
			],
			"week": [
				"previous": "prošle sedmice",
				"current": "ove sedmice",
				"next": "sljedeće sedmice",
				"past": "prije {0} sed.",
				"future": "za {0} sed."
			],
			"day": [
				"previous": "jučer",
				"current": "danas",
				"next": "sutra",
				"past": "prije {0} d.",
				"future": "za {0} d."
			],
			"hour": [
				"current": "ovaj sat",
				"past": [
					"one": "prije {0} sat",
					"few": "prije {0} sata",
					"other": "prije {0} sati"
				],
				"future": [
					"one": "za {0} sat",
					"few": "za {0} sata",
					"other": "za {0} sati"
				]
			],
			"minute": [
				"current": "ova minuta",
				"past": "prije {0} min.",
				"future": "za {0} min."
			],
			"second": [
				"current": "sada",
				"past": "prije {0} sek.",
				"future": "za {0} sek."
			],
			"now": "sada"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "prošle godine",
				"current": "ove godine",
				"next": "sljedeće godine",
				"past": "prije {0} g.",
				"future": "za {0} g."
			],
			"quarter": [
				"previous": "posljednji kvartal",
				"current": "ovaj kvartal",
				"next": "sljedeći kvartal",
				"past": "prije {0} kv.",
				"future": "za {0} kv."
			],
			"month": [
				"previous": "prošli mjesec",
				"current": "ovaj mjesec",
				"next": "sljedeći mjesec",
				"past": "prije {0} mj.",
				"future": "za {0} mj."
			],
			"week": [
				"previous": "prošle sedmice",
				"current": "ove sedmice",
				"next": "sljedeće sedmice",
				"past": "prije {0} sed.",
				"future": "za {0} sed."
			],
			"day": [
				"previous": "jučer",
				"current": "danas",
				"next": "sutra",
				"past": "prije {0} d.",
				"future": "za {0} d."
			],
			"hour": [
				"current": "ovaj sat",
				"past": [
					"one": "prije {0} sat",
					"few": "prije {0} sata",
					"other": "prije {0} sati"
				],
				"future": [
					"one": "za {0} sat",
					"few": "za {0} sata",
					"other": "za {0} sati"
				]
			],
			"minute": [
				"current": "ova minuta",
				"past": "prije {0} min.",
				"future": "za {0} min."
			],
			"second": [
				"current": "sada",
				"past": "prije {0} sek.",
				"future": "za {0} sek."
			],
			"now": "sada"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "prošle godine",
				"current": "ove godine",
				"next": "sljedeće godine",
				"past": [
					"one": "prije {0} godinu",
					"few": "prije {0} godine",
					"other": "prije {0} godina"
				],
				"future": [
					"one": "za {0} godinu",
					"few": "za {0} godine",
					"other": "za {0} godina"
				]
			],
			"quarter": [
				"previous": "posljednji kvartal",
				"current": "ovaj kvartal",
				"next": "sljedeći kvartal",
				"past": [
					"one": "prije {0} kvartal",
					"other": "prije {0} kvartala"
				],
				"future": [
					"one": "za {0} kvartal",
					"other": "za {0} kvartala"
				]
			],
			"month": [
				"previous": "prošli mjesec",
				"current": "ovaj mjesec",
				"next": "sljedeći mjesec",
				"past": [
					"one": "prije {0} mjesec",
					"few": "prije {0} mjeseca",
					"other": "prije {0} mjeseci"
				],
				"future": [
					"one": "za {0} mjesec",
					"few": "za {0} mjeseca",
					"other": "za {0} mjeseci"
				]
			],
			"week": [
				"previous": "prošle sedmice",
				"current": "ove sedmice",
				"next": "sljedeće sedmice",
				"past": [
					"one": "prije {0} sedmicu",
					"few": "prije {0} sedmice",
					"other": "prije {0} sedmica"
				],
				"future": [
					"one": "za {0} sedmicu",
					"few": "za {0} sedmice",
					"other": "za {0} sedmica"
				]
			],
			"day": [
				"previous": "jučer",
				"current": "danas",
				"next": "sutra",
				"past": [
					"one": "prije {0} dan",
					"other": "prije {0} dana"
				],
				"future": [
					"one": "za {0} dan",
					"other": "za {0} dana"
				]
			],
			"hour": [
				"current": "ovaj sat",
				"past": [
					"one": "prije {0} sat",
					"few": "prije {0} sata",
					"other": "prije {0} sati"
				],
				"future": [
					"one": "za {0} sat",
					"few": "za {0} sata",
					"other": "za {0} sati"
				]
			],
			"minute": [
				"current": "ova minuta",
				"past": [
					"one": "prije {0} minutu",
					"few": "prije {0} minute",
					"other": "prije {0} minuta"
				],
				"future": [
					"one": "za {0} minutu",
					"few": "za {0} minute",
					"other": "za {0} minuta"
				]
			],
			"second": [
				"current": "sada",
				"past": [
					"one": "prije {0} sekundu",
					"few": "prije {0} sekunde",
					"other": "prije {0} sekundi"
				],
				"future": [
					"one": "za {0} sekundu",
					"few": "za {0} sekunde",
					"other": "za {0} sekundi"
				]
			],
			"now": "sada"
		]
	}
}
