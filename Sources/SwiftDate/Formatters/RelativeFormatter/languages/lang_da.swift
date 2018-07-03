//
//  lang_da.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_da: RelativeFormatterLang {

	/// Locales.danish
	public static let identifier: String = "da"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 1:		return .one
		default:	return .other
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
				"previous": "sidste år",
				"current": "i år",
				"next": "næste år",
				"past": "for {0} år siden",
				"future": "om {0} år"
			],
			"quarter": [
				"previous": "sidste kvt.",
				"current": "dette kvt.",
				"next": "næste kvt.",
				"past": "for {0} kvt. siden",
				"future": "om {0} kvt."
			],
			"month": [
				"previous": "sidste md.",
				"current": "denne md.",
				"next": "næste md.",
				"past": [
					"one": "for {0} md. siden",
					"other": "for {0} mdr. siden"
				],
				"future": [
					"one": "om {0} md.",
					"other": "om {0} mdr."
				]
			],
			"week": [
				"previous": "sidste uge",
				"current": "denne uge",
				"next": "næste uge",
				"past": [
					"one": "for {0} uge siden",
					"other": "for {0} uger siden"
				],
				"future": [
					"one": "om {0} uge",
					"other": "om {0} uger"
				]
			],
			"day": [
				"previous": "i går",
				"current": "i dag",
				"next": "i morgen",
				"past": [
					"one": "for {0} dag siden",
					"other": "for {0} dage siden"
				],
				"future": [
					"one": "om {0} dag",
					"other": "om {0} dage"
				]
			],
			"hour": [
				"current": "i den kommende time",
				"past": [
					"one": "for {0} time siden",
					"other": "for {0} timer siden"
				],
				"future": [
					"one": "om {0} time",
					"other": "om {0} timer"
				]
			],
			"minute": [
				"current": "i det kommende minut",
				"past": "for {0} min. siden",
				"future": "om {0} min."
			],
			"second": [
				"current": "nu",
				"past": "for {0} sek. siden",
				"future": "om {0} sek."
			],
			"now": "nu"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "sidste år",
				"current": "i år",
				"next": "næste år",
				"past": "for {0} år siden",
				"future": "om {0} år"
			],
			"quarter": [
				"previous": "sidste kvt.",
				"current": "dette kvt.",
				"next": "næste kvt.",
				"past": "for {0} kvt. siden",
				"future": "om {0} kvt."
			],
			"month": [
				"previous": "sidste md.",
				"current": "denne md.",
				"next": "næste md.",
				"past": [
					"one": "for {0} md. siden",
					"other": "for {0} mdr. siden"
				],
				"future": [
					"one": "om {0} md.",
					"other": "om {0} mdr."
				]
			],
			"week": [
				"previous": "sidste uge",
				"current": "denne uge",
				"next": "næste uge",
				"past": [
					"one": "for {0} uge siden",
					"other": "for {0} uger siden"
				],
				"future": [
					"one": "om {0} uge",
					"other": "om {0} uger"
				]
			],
			"day": [
				"previous": "i går",
				"current": "i dag",
				"next": "i morgen",
				"past": [
					"one": "for {0} dag siden",
					"other": "for {0} dage siden"
				],
				"future": [
					"one": "om {0} dag",
					"other": "om {0} dage"
				]
			],
			"hour": [
				"current": "i den kommende time",
				"past": [
					"one": "for {0} time siden",
					"other": "for {0} timer siden"
				],
				"future": [
					"one": "om {0} time",
					"other": "om {0} timer"
				]
			],
			"minute": [
				"current": "i det kommende minut",
				"past": "for {0} min. siden",
				"future": "om {0} min."
			],
			"second": [
				"current": "nu",
				"past": "for {0} sek. siden",
				"future": "om {0} sek."
			],
			"now": "nu"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "sidste år",
				"current": "i år",
				"next": "næste år",
				"past": "for {0} år siden",
				"future": "om {0} år"
			],
			"quarter": [
				"previous": "sidste kvartal",
				"current": "dette kvartal",
				"next": "næste kvartal",
				"past": [
					"one": "for {0} kvartal siden",
					"other": "for {0} kvartaler siden"
				],
				"future": [
					"one": "om {0} kvartal",
					"other": "om {0} kvartaler"
				]
			],
			"month": [
				"previous": "sidste måned",
				"current": "denne måned",
				"next": "næste måned",
				"past": [
					"one": "for {0} måned siden",
					"other": "for {0} måneder siden"
				],
				"future": [
					"one": "om {0} måned",
					"other": "om {0} måneder"
				]
			],
			"week": [
				"previous": "sidste uge",
				"current": "denne uge",
				"next": "næste uge",
				"past": [
					"one": "for {0} uge siden",
					"other": "for {0} uger siden"
				],
				"future": [
					"one": "om {0} uge",
					"other": "om {0} uger"
				]
			],
			"day": [
				"previous": "i går",
				"current": "i dag",
				"next": "i morgen",
				"past": [
					"one": "for {0} dag siden",
					"other": "for {0} dage siden"
				],
				"future": [
					"one": "om {0} dag",
					"other": "om {0} dage"
				]
			],
			"hour": [
				"current": "i den kommende time",
				"past": [
					"one": "for {0} time siden",
					"other": "for {0} timer siden"
				],
				"future": [
					"one": "om {0} time",
					"other": "om {0} timer"
				]
			],
			"minute": [
				"current": "i det kommende minut",
				"past": [
					"one": "for {0} minut siden",
					"other": "for {0} minutter siden"
				],
				"future": [
					"one": "om {0} minut",
					"other": "om {0} minutter"
				]
			],
			"second": [
				"current": "nu",
				"past": [
					"one": "for {0} sekund siden",
					"other": "for {0} sekunder siden"
				],
				"future": [
					"one": "om {0} sekund",
					"other": "om {0} sekunder"
				]
			],
			"now": "nu"
		]
	}
}
