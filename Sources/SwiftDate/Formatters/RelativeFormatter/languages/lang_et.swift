//
//  lang_et.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_et: RelativeFormatterLang {

	/// Locales.estonian
	public static let identifier: String = "et"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
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
				"previous": "eelmine aasta",
				"current": "käesolev aasta",
				"next": "järgmine aasta",
				"past": "{0} a eest",
				"future": "{0} a pärast"
			],
			"quarter": [
				"previous": "eelmine kv",
				"current": "käesolev kv",
				"next": "järgmine kv",
				"past": "{0} kv eest",
				"future": "{0} kv pärast"
			],
			"month": [
				"previous": "eelmine kuu",
				"current": "käesolev kuu",
				"next": "järgmine kuu",
				"past": "{0} kuu eest",
				"future": "{0} kuu pärast"
			],
			"week": [
				"previous": "eelmine nädal",
				"current": "käesolev nädal",
				"next": "järgmine nädal",
				"past": "{0} näd eest",
				"future": "{0} näd pärast"
			],
			"day": [
				"previous": "eile",
				"current": "täna",
				"next": "homme",
				"past": "{0} p eest",
				"future": "{0} p pärast"
			],
			"hour": [
				"current": "praegusel tunnil",
				"past": "{0} t eest",
				"future": "{0} t pärast"
			],
			"minute": [
				"current": "praegusel minutil",
				"past": "{0} min eest",
				"future": "{0} min pärast"
			],
			"second": [
				"current": "nüüd",
				"past": "{0} sek eest",
				"future": "{0} sek pärast"
			],
			"now": "nüüd"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "eelmine aasta",
				"current": "käesolev aasta",
				"next": "järgmine aasta",
				"past": "{0} a eest",
				"future": "{0} a pärast"
			],
			"quarter": [
				"previous": "eelmine kv",
				"current": "käesolev kv",
				"next": "järgmine kv",
				"past": "{0} kv eest",
				"future": "{0} kv pärast"
			],
			"month": [
				"previous": "eelmine kuu",
				"current": "käesolev kuu",
				"next": "järgmine kuu",
				"past": "{0} k eest",
				"future": "{0} k pärast"
			],
			"week": [
				"previous": "eelmine nädal",
				"current": "käesolev nädal",
				"next": "järgmine nädal",
				"past": "{0} näd eest",
				"future": "{0} näd pärast"
			],
			"day": [
				"previous": "eile",
				"current": "täna",
				"next": "homme",
				"past": "{0} p eest",
				"future": "{0} p pärast"
			],
			"hour": [
				"current": "praegusel tunnil",
				"past": "{0} t eest",
				"future": "{0} t pärast"
			],
			"minute": [
				"current": "praegusel minutil",
				"past": "{0} min eest",
				"future": "{0} min pärast"
			],
			"second": [
				"current": "nüüd",
				"past": "{0} s eest",
				"future": "{0} s pärast"
			],
			"now": "nüüd"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "eelmine aasta",
				"current": "käesolev aasta",
				"next": "järgmine aasta",
				"past": "{0} aasta eest",
				"future": "{0} aasta pärast"
			],
			"quarter": [
				"previous": "eelmine kvartal",
				"current": "käesolev kvartal",
				"next": "järgmine kvartal",
				"past": "{0} kvartali eest",
				"future": "{0} kvartali pärast"
			],
			"month": [
				"previous": "eelmine kuu",
				"current": "käesolev kuu",
				"next": "järgmine kuu",
				"past": "{0} kuu eest",
				"future": "{0} kuu pärast"
			],
			"week": [
				"previous": "eelmine nädal",
				"current": "käesolev nädal",
				"next": "järgmine nädal",
				"past": "{0} nädala eest",
				"future": "{0} nädala pärast"
			],
			"day": [
				"previous": "eile",
				"current": "täna",
				"next": "homme",
				"past": "{0} päeva eest",
				"future": "{0} päeva pärast"
			],
			"hour": [
				"current": "praegusel tunnil",
				"past": "{0} tunni eest",
				"future": "{0} tunni pärast"
			],
			"minute": [
				"current": "praegusel minutil",
				"past": "{0} minuti eest",
				"future": "{0} minuti pärast"
			],
			"second": [
				"current": "nüüd",
				"past": "{0} sekundi eest",
				"future": "{0} sekundi pärast"
			],
			"now": "nüüd"
		]
	}
}
