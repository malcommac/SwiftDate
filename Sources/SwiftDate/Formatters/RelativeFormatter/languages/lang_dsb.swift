//
//  lang_dsb.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_dsb: RelativeFormatterLang {

	/// Locales.lowerSorbian
	public static let identifier: String = "dsb"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1:			return .one
		case 2, 3, 4:	return .few
		default:		return .other
		}
	}

	// module.exports=function(e){var i=String(e).split("."),n=Number(i{0})==e,r=n&&i{0}.slice(-1),s=n&&i{0}.slice(-2);return 1==r&&11!=s?"one":r>=2&&r<=4&&(s<12||s>14)?"few":n&&0==r||r>=5&&r<=9||s>=11&&s<=14?"many":"other"}
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
				"previous": "łoni",
				"current": "lětosa",
				"next": "znowa",
				"past": "pśed {0} l.",
				"future": "za {0} l."
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "pśed {0} kwart.",
				"future": "za {0} kwart."
			],
			"month": [
				"previous": "slědny mjasec",
				"current": "ten mjasec",
				"next": "pśiducy mjasec",
				"past": "pśed {0} mjas.",
				"future": "za {0} mjas."
			],
			"week": [
				"previous": "slědny tyźeń",
				"current": "ten tyźeń",
				"next": "pśiducy tyźeń",
				"past": "pśed {0} tyź.",
				"future": "za {0} tyź."
			],
			"day": [
				"previous": "cora",
				"current": "źinsa",
				"next": "witśe",
				"past": "pśed {0} dnj.",
				"future": [
					"one": "za {0} źeń",
					"few": "za {0} dny",
					"other": "za {0} dnj."
				]
			],
			"hour": [
				"current": "this hour",
				"past": "pśed {0} góź.",
				"future": "za {0} góź."
			],
			"minute": [
				"current": "this minute",
				"past": "pśed {0} min.",
				"future": "za {0} min."
			],
			"second": [
				"current": "now",
				"past": "pśed {0} sek.",
				"future": "za {0} sek."
			],
			"now": "now"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "łoni",
				"current": "lětosa",
				"next": "znowa",
				"past": "pśed {0} l.",
				"future": "za {0} l."
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "pśed {0} kw.",
				"future": "za {0} kw."
			],
			"month": [
				"previous": "slědny mjasec",
				"current": "ten mjasec",
				"next": "pśiducy mjasec",
				"past": "pśed {0} mjas.",
				"future": "za {0} mjas."
			],
			"week": [
				"previous": "slědny tyźeń",
				"current": "ten tyźeń",
				"next": "pśiducy tyźeń",
				"past": "pśed {0} tyź.",
				"future": "za {0} tyź."
			],
			"day": [
				"previous": "cora",
				"current": "źinsa",
				"next": "witśe",
				"past": "pśed {0} d",
				"future": "za {0} ź"
			],
			"hour": [
				"current": "this hour",
				"past": "pśed {0} g",
				"future": "za {0} g"
			],
			"minute": [
				"current": "this minute",
				"past": "pśed {0} m",
				"future": "za {0} m"
			],
			"second": [
				"current": "now",
				"past": "pśed {0} s",
				"future": "za {0} s"
			],
			"now": "now"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "łoni",
				"current": "lětosa",
				"next": "znowa",
				"past": [
					"one": "pśed {0} lětom",
					"two": "pśed {0} lětoma",
					"other": "pśed {0} lětami"
				],
				"future": [
					"one": "za {0} lěto",
					"two": "za {0} lěśe",
					"few": "za {0} lěta",
					"other": "za {0} lět"
				]
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": [
					"one": "pśed {0} kwartalom",
					"two": "pśed {0} kwartaloma",
					"other": "pśed {0} kwartalami"
				],
				"future": [
					"one": "za {0} kwartal",
					"two": "za {0} kwartala",
					"few": "za {0} kwartale",
					"other": "za {0} kwartalow"
				]
			],
			"month": [
				"previous": "slědny mjasec",
				"current": "ten mjasec",
				"next": "pśiducy mjasec",
				"past": [
					"one": "pśed {0} mjasecom",
					"two": "pśed {0} mjasecoma",
					"other": "pśed {0} mjasecami"
				],
				"future": [
					"one": "za {0} mjasec",
					"two": "za {0} mjaseca",
					"few": "za {0} mjasecy",
					"other": "za {0} mjasecow"
				]
			],
			"week": [
				"previous": "slědny tyźeń",
				"current": "ten tyźeń",
				"next": "pśiducy tyźeń",
				"past": [
					"one": "pśed {0} tyźenjom",
					"two": "pśed {0} tyźenjoma",
					"other": "pśed {0} tyźenjami"
				],
				"future": [
					"one": "za {0} tyźeń",
					"two": "za {0} tyźenja",
					"few": "za {0} tyźenje",
					"other": "za {0} tyźenjow"
				]
			],
			"day": [
				"previous": "cora",
				"current": "źinsa",
				"next": "witśe",
				"past": [
					"one": "pśed {0} dnjom",
					"two": "pśed {0} dnjoma",
					"other": "pśed {0} dnjami"
				],
				"future": [
					"one": "za {0} źeń",
					"two": "za {0} dnja",
					"few": "za {0} dny",
					"other": "za {0} dnjow"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "pśed {0} góźinu",
					"two": "pśed {0} góźinoma",
					"other": "pśed {0} góźinami"
				],
				"future": [
					"one": "za {0} góźinu",
					"two": "za {0} góźinje",
					"few": "za {0} góźiny",
					"other": "za {0} góźin"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "pśed {0} minutu",
					"two": "pśed {0} minutoma",
					"other": "pśed {0} minutami"
				],
				"future": [
					"one": "za {0} minutu",
					"two": "za {0} minuśe",
					"few": "za {0} minuty",
					"other": "za {0} minutow"
				]
			],
			"second": [
				"current": "now",
				"past": [
					"one": "pśed {0} sekundu",
					"two": "pśed {0} sekundoma",
					"other": "pśed {0} sekundami"
				],
				"future": [
					"one": "za {0} sekundu",
					"two": "za {0} sekunźe",
					"few": "za {0} sekundy",
					"other": "za {0} sekundow"
				]
			],
			"now": "now"
		]
	}
}
