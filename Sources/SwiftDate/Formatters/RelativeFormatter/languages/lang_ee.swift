//
//  lang_ee.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_ee: RelativeFormatterLang {

	/// Locales.ewe
	public static let identifier: String = "ee"

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
				"previous": "ƒe si va yi",
				"current": "ƒe sia",
				"next": "ƒe si gbɔ na",
				"past": "le ƒe {0} si va yi me",
				"future": "le ƒe {0} me"
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "kɔta {0} si va yi me",
				"future": "le kɔta {0} si gbɔ na me"
			],
			"month": [
				"previous": "ɣleti si va yi",
				"current": "ɣleti sia",
				"next": "ɣleti si gbɔ na",
				"past": [
					"one": "ɣleti {0} si va yi",
					"other": "ɣleti {0} si wo va yi"
				],
				"future": [
					"one": "le ɣleti {0} me",
					"other": "le ɣleti {0} wo me"
				]
			],
			"week": [
				"previous": "kɔsiɖa si va yi",
				"current": "kɔsiɖa sia",
				"next": "kɔsiɖa si gbɔ na",
				"past": [
					"one": "kɔsiɖa {0} si va yi",
					"other": "kɔsiɖa {0} si wo va yi"
				],
				"future": [
					"one": "le kɔsiɖa {0} me",
					"other": "le kɔsiɖa {0} wo me"
				]
			],
			"day": [
				"previous": "etsɔ si va yi",
				"current": "egbe",
				"next": "etsɔ si gbɔna",
				"past": [
					"one": "ŋkeke {0} si va yi",
					"other": "ŋkeke {0} si wo va yi"
				],
				"future": [
					"one": "le ŋkeke {0} me",
					"other": "le ŋkeke {0} wo me"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "gaƒoƒo {0} si va yi",
					"other": "gaƒoƒo {0} si wo va yi"
				],
				"future": [
					"one": "le gaƒoƒo {0} me",
					"other": "le gaƒoƒo {0} wo me"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "aɖabaƒoƒo {0} si va yi",
					"other": "aɖabaƒoƒo {0} si wo va yi"
				],
				"future": [
					"one": "le aɖabaƒoƒo {0} me",
					"other": "le aɖabaƒoƒo {0} wo me"
				]
			],
			"second": [
				"current": "fifi",
				"past": [
					"one": "sekend {0} si va yi",
					"other": "sekend {0} si wo va yi"
				],
				"future": [
					"one": "le sekend {0} me",
					"other": "le sekend {0} wo me"
				]
			],
			"now": "fifi"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "ƒe si va yi",
				"current": "ƒe sia",
				"next": "ƒe si gbɔ na",
				"past": "ƒe {0} si va yi me",
				"future": "le ƒe {0} si gbɔna me"
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "kɔta {0} si va yi me",
				"future": [
					"one": "le kɔta {0} si gbɔna me",
					"other": "le kɔta {0} si gbɔ na me"
				]
			],
			"month": [
				"previous": "ɣleti si va yi",
				"current": "ɣleti sia",
				"next": "ɣleti si gbɔ na",
				"past": [
					"one": "ɣleti {0} si va yi",
					"other": "ɣleti {0} si wo va yi"
				],
				"future": [
					"one": "le ɣleti {0} me",
					"other": "le ɣleti {0} wo me"
				]
			],
			"week": [
				"previous": "kɔsiɖa si va yi",
				"current": "kɔsiɖa sia",
				"next": "kɔsiɖa si gbɔ na",
				"past": [
					"one": "kɔsiɖa {0} si va yi",
					"other": "kɔsiɖa {0} si wo va yi"
				],
				"future": [
					"one": "le kɔsiɖa {0} me",
					"other": "le kɔsiɖa {0} wo me"
				]
			],
			"day": [
				"previous": "etsɔ si va yi",
				"current": "egbe",
				"next": "etsɔ si gbɔna",
				"past": [
					"one": "ŋkeke {0} si va yi",
					"other": "ŋkeke {0} si wo va yi"
				],
				"future": [
					"one": "le ŋkeke {0} me",
					"other": "le ŋkeke {0} wo me"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "gaƒoƒo {0} si va yi",
					"other": "gaƒoƒo {0} si wo va yi"
				],
				"future": [
					"one": "le gaƒoƒo {0} me",
					"other": "le gaƒoƒo {0} wo me"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "aɖabaƒoƒo {0} si va yi",
					"other": "aɖabaƒoƒo {0} si wo va yi"
				],
				"future": [
					"one": "le aɖabaƒoƒo {0} me",
					"other": "le aɖabaƒoƒo {0} wo me"
				]
			],
			"second": [
				"current": "fifi",
				"past": [
					"one": "sekend {0} si va yi",
					"other": "sekend {0} si wo va yi"
				],
				"future": [
					"one": "le sekend {0} me",
					"other": "le sekend {0} wo me"
				]
			],
			"now": "fifi"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "ƒe si va yi",
				"current": "ƒe sia",
				"next": "ƒe si gbɔ na",
				"past": [
					"one": "ƒe {0} si va yi",
					"other": "ƒe {0} si wo va yi"
				],
				"future": "le ƒe {0} me"
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "kɔta {0} si va yi me",
				"future": "le kɔta {0} si gbɔ na me"
			],
			"month": [
				"previous": "ɣleti si va yi",
				"current": "ɣleti sia",
				"next": "ɣleti si gbɔ na",
				"past": [
					"one": "ɣleti {0} si va yi",
					"other": "ɣleti {0} si wo va yi"
				],
				"future": [
					"one": "le ɣleti {0} me",
					"other": "le ɣleti {0} wo me"
				]
			],
			"week": [
				"previous": "kɔsiɖa si va yi",
				"current": "kɔsiɖa sia",
				"next": "kɔsiɖa si gbɔ na",
				"past": [
					"one": "kɔsiɖa {0} si va yi",
					"other": "kɔsiɖa {0} si wo va yi"
				],
				"future": [
					"one": "le kɔsiɖa {0} me",
					"other": "le kɔsiɖa {0} wo me"
				]
			],
			"day": [
				"previous": "etsɔ si va yi",
				"current": "egbe",
				"next": "etsɔ si gbɔna",
				"past": [
					"one": "ŋkeke {0} si va yi",
					"other": "ŋkeke {0} si wo va yi"
				],
				"future": [
					"one": "le ŋkeke {0} me",
					"other": "le ŋkeke {0} wo me"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "gaƒoƒo {0} si va yi",
					"other": "gaƒoƒo {0} si wo va yi"
				],
				"future": [
					"one": "le gaƒoƒo {0} me",
					"other": "le gaƒoƒo {0} wo me"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "aɖabaƒoƒo {0} si va yi",
					"other": "aɖabaƒoƒo {0} si wo va yi"
				],
				"future": [
					"one": "le aɖabaƒoƒo {0} me",
					"other": "le aɖabaƒoƒo {0} wo me"
				]
			],
			"second": [
				"current": "fifi",
				"past": [
					"one": "sekend {0} si va yi",
					"other": "sekend {0} si wo va yi"
				],
				"future": [
					"one": "le sekend {0} me",
					"other": "le sekend {0} wo me"
				]
			],
			"now": "fifi"
		]
	}
}
