//
//  lang_cy.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_cy: RelativeFormatterLang {

	/// Locales.welsh
	public static let identifier: String = "cy"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 0:	return .zero
		case 1: return .one
		case 2: return .two
		case 3: return .few
		case 6: return .many
		default: return .other
		}
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
				"previous": "llynedd",
				"current": "eleni",
				"next": "blwyddyn nesaf",
				"past": [
					"one": "blwyddyn yn ôl",
					"two": "{0} flynedd yn ôl",
					"few": "{0} blynedd yn ôl",
					"many": "{0} blynedd yn ôl",
					"other": "{0} o flynyddoedd yn ôl"
				],
				"future": [
					"one": "ymhen blwyddyn",
					"two": "ymhen {0} flynedd",
					"few": "ymhen {0} blynedd",
					"many": "ymhen {0} blynedd",
					"other": "ymhen {0} mlynedd"
				]
			],
			"quarter": [
				"previous": "chwarter olaf",
				"current": "chwarter hwn",
				"next": "chwarter nesaf",
				"past": [
					"one": "{0} chwarter yn ôl",
					"two": "{0} chwarter yn ôl",
					"few": "{0} chwarter yn ôl",
					"many": "{0} chwarter yn ôl",
					"other": "{0} o chwarteri yn ôl"
				],
				"future": "ymhen {0} chwarter"
			],
			"month": [
				"previous": "mis diwethaf",
				"current": "y mis hwn",
				"next": "mis nesaf",
				"past": [
					"two": "deufis yn ôl",
					"other": "{0} mis yn ôl"
				],
				"future": [
					"one": "ymhen mis",
					"two": "ymhen deufis",
					"other": "ymhen {0} mis"
				]
			],
			"week": [
				"previous": "wythnos ddiwethaf",
				"current": "yr wythnos hon",
				"next": "wythnos nesaf",
				"past": [
					"two": "pythefnos yn ôl",
					"other": "{0} wythnos yn ôl"
				],
				"future": [
					"one": "ymhen wythnos",
					"two": "ymhen pythefnos",
					"other": "ymhen {0} wythnos"
				]
			],
			"day": [
				"previous": "ddoe",
				"current": "heddiw",
				"next": "yfory",
				"past": [
					"two": "{0} ddiwrnod yn ôl",
					"other": "{0} diwrnod yn ôl"
				],
				"future": [
					"one": "ymhen diwrnod",
					"two": "ymhen deuddydd",
					"other": "ymhen {0} diwrnod"
				]
			],
			"hour": [
				"current": "yr awr hon",
				"past": [
					"one": "awr yn ôl",
					"other": "{0} awr yn ôl"
				],
				"future": [
					"one": "ymhen awr",
					"other": "ymhen {0} awr"
				]
			],
			"minute": [
				"current": "y funud hon",
				"past": [
					"two": "{0} fun. yn ôl",
					"other": "{0} munud yn ôl"
				],
				"future": [
					"one": "ymhen {0} mun.",
					"two": "ymhen {0} fun.",
					"other": "ymhen {0} munud"
				]
			],
			"second": [
				"current": "nawr",
				"past": "{0} eiliad yn ôl",
				"future": "ymhen {0} eiliad"
			],
			"now": "nawr"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "llynedd",
				"current": "eleni",
				"next": "blwyddyn nesaf",
				"past": [
					"one": "blwyddyn yn ôl",
					"two": "{0} flynedd yn ôl",
					"few": "{0} blynedd yn ôl",
					"many": "{0} blynedd yn ôl",
					"other": "{0} o flynyddoedd yn ôl"
				],
				"future": [
					"one": "ymhen blwyddyn",
					"two": "ymhen {0} flynedd",
					"few": "ymhen {0} blynedd",
					"many": "ymhen {0} blynedd",
					"other": "ymhen {0} mlynedd"
				]
			],
			"quarter": [
				"previous": "chwarter olaf",
				"current": "chwarter hwn",
				"next": "chwarter nesaf",
				"past": [
					"one": "{0} chwarter yn ôl",
					"two": "{0} chwarter yn ôl",
					"few": "{0} chwarter yn ôl",
					"many": "{0} chwarter yn ôl",
					"other": "{0} o chwarteri yn ôl"
				],
				"future": "ymhen {0} chwarter"
			],
			"month": [
				"previous": "mis diwethaf",
				"current": "y mis hwn",
				"next": "mis nesaf",
				"past": [
					"two": "{0} fis yn ôl",
					"other": "{0} mis yn ôl"
				],
				"future": [
					"one": "ymhen mis",
					"two": "ymhen deufis",
					"other": "ymhen {0} mis"
				]
			],
			"week": [
				"previous": "wythnos ddiwethaf",
				"current": "yr wythnos hon",
				"next": "wythnos nesaf",
				"past": [
					"two": "pythefnos yn ôl",
					"other": "{0} wythnos yn ôl"
				],
				"future": "ymhen {0} wythnos"
			],
			"day": [
				"previous": "ddoe",
				"current": "heddiw",
				"next": "yfory",
				"past": [
					"two": "{0} ddiwrnod yn ôl",
					"other": "{0} diwrnod yn ôl"
				],
				"future": "ymhen {0} diwrnod"
			],
			"hour": [
				"current": "yr awr hon",
				"past": "{0} awr yn ôl",
				"future": "ymhen {0} awr"
			],
			"minute": [
				"current": "y funud hon",
				"past": "{0} mun. yn ôl",
				"future": "ymhen {0} mun."
			],
			"second": [
				"current": "nawr",
				"past": "{0} eiliad yn ôl",
				"future": "ymhen {0} eiliad"
			],
			"now": "nawr"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "llynedd",
				"current": "eleni",
				"next": "blwyddyn nesaf",
				"past": [
					"one": "blwyddyn yn ôl",
					"two": "{0} flynedd yn ôl",
					"few": "{0} blynedd yn ôl",
					"many": "{0} blynedd yn ôl",
					"other": "{0} o flynyddoedd yn ôl"
				],
				"future": [
					"one": "ymhen blwyddyn",
					"two": "ymhen {0} flynedd",
					"few": "ymhen {0} blynedd",
					"many": "ymhen {0} blynedd",
					"other": "ymhen {0} mlynedd"
				]
			],
			"quarter": [
				"previous": "chwarter olaf",
				"current": "chwarter hwn",
				"next": "chwarter nesaf",
				"past": [
					"one": "{0} chwarter yn ôl",
					"two": "{0} chwarter yn ôl",
					"few": "{0} chwarter yn ôl",
					"many": "{0} chwarter yn ôl",
					"other": "{0} o chwarteri yn ôl"
				],
				"future": "ymhen {0} chwarter"
			],
			"month": [
				"previous": "mis diwethaf",
				"current": "y mis hwn",
				"next": "mis nesaf",
				"past": [
					"two": "{0} fis yn ôl",
					"other": "{0} mis yn ôl"
				],
				"future": [
					"one": "ymhen mis",
					"two": "ymhen deufis",
					"other": "ymhen {0} mis"
				]
			],
			"week": [
				"previous": "wythnos ddiwethaf",
				"current": "yr wythnos hon",
				"next": "wythnos nesaf",
				"past": "{0} wythnos yn ôl",
				"future": [
					"one": "ymhen wythnos",
					"two": "ymhen pythefnos",
					"other": "ymhen {0} wythnos"
				]
			],
			"day": [
				"previous": "ddoe",
				"current": "heddiw",
				"next": "yfory",
				"past": [
					"two": "{0} ddiwrnod yn ôl",
					"other": "{0} diwrnod yn ôl"
				],
				"future": [
					"one": "ymhen diwrnod",
					"two": "ymhen deuddydd",
					"other": "ymhen {0} diwrnod"
				]
			],
			"hour": [
				"current": "yr awr hon",
				"past": "{0} awr yn ôl",
				"future": [
					"one": "ymhen awr",
					"other": "ymhen {0} awr"
				]
			],
			"minute": [
				"current": "y funud hon",
				"past": "{0} munud yn ôl",
				"future": "ymhen {0} munud"
			],
			"second": [
				"current": "nawr",
				"past": "{0} eiliad yn ôl",
				"future": "ymhen {0} eiliad"
			],
			"now": "nawr"
		]
	}
}
