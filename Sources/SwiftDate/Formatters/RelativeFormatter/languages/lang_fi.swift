//
//  lang_fi.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_fi: RelativeFormatterLang {

	/// Locales.finnish
	public static let identifier: String = "fi"

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
				"previous": "viime v",
				"current": "tänä v",
				"next": "ensi v",
				"past": "{0} v sitten",
				"future": "{0} v päästä"
			],
			"quarter": [
				"previous": "viime neljänneksenä",
				"current": "tänä neljänneksenä",
				"next": "ensi neljänneksenä",
				"past": [
					"one": "{0} neljännes sitten",
					"other": "{0} neljännestä sitten"
				],
				"future": "{0} neljänneksen päästä"
			],
			"month": [
				"previous": "viime kk",
				"current": "tässä kk",
				"next": "ensi kk",
				"past": "{0} kk sitten",
				"future": "{0} kk päästä"
			],
			"week": [
				"previous": "viime vk",
				"current": "tällä vk",
				"next": "ensi vk",
				"past": "{0} vk sitten",
				"future": "{0} vk päästä"
			],
			"day": [
				"previous": "eilen",
				"current": "tänään",
				"next": "huom.",
				"past": "{0} pv sitten",
				"future": "{0} pv päästä"
			],
			"hour": [
				"current": "tunnin sisällä",
				"past": "{0} t sitten",
				"future": "{0} t päästä"
			],
			"minute": [
				"current": "minuutin sisällä",
				"past": "{0} min sitten",
				"future": "{0} min päästä"
			],
			"second": [
				"current": "nyt",
				"past": "{0} s sitten",
				"future": "{0} s päästä"
			],
			"now": "nyt"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "viime v",
				"current": "tänä v",
				"next": "ensi v",
				"past": "{0} v sitten",
				"future": "{0} v päästä"
			],
			"quarter": [
				"previous": "viime nelj.",
				"current": "tänä nelj.",
				"next": "ensi nelj.",
				"past": "{0} nelj. sitten",
				"future": "{0} nelj. päästä"
			],
			"month": [
				"previous": "viime kk",
				"current": "tässä kk",
				"next": "ensi kk",
				"past": "{0} kk sitten",
				"future": "{0} kk päästä"
			],
			"week": [
				"previous": "viime vk",
				"current": "tällä vk",
				"next": "ensi vk",
				"past": "{0} vk sitten",
				"future": "{0} vk päästä"
			],
			"day": [
				"previous": "eilen",
				"current": "tänään",
				"next": "huom.",
				"past": "{0} pv sitten",
				"future": "{0} pv päästä"
			],
			"hour": [
				"current": "tunnin sisällä",
				"past": "{0} t sitten",
				"future": "{0} t päästä"
			],
			"minute": [
				"current": "minuutin sisällä",
				"past": "{0} min sitten",
				"future": "{0} min päästä"
			],
			"second": [
				"current": "nyt",
				"past": "{0} s sitten",
				"future": "{0} s päästä"
			],
			"now": "nyt"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "viime vuonna",
				"current": "tänä vuonna",
				"next": "ensi vuonna",
				"past": [
					"one": "{0} vuosi sitten",
					"other": "{0} vuotta sitten"
				],
				"future": "{0} vuoden päästä"
			],
			"quarter": [
				"previous": "viime neljännesvuonna",
				"current": "tänä neljännesvuonna",
				"next": "ensi neljännesvuonna",
				"past": [
					"one": "{0} neljännesvuosi sitten",
					"other": "{0} neljännesvuotta sitten"
				],
				"future": "{0} neljännesvuoden päästä"
			],
			"month": [
				"previous": "viime kuussa",
				"current": "tässä kuussa",
				"next": "ensi kuussa",
				"past": [
					"one": "{0} kuukausi sitten",
					"other": "{0} kuukautta sitten"
				],
				"future": "{0} kuukauden päästä"
			],
			"week": [
				"previous": "viime viikolla",
				"current": "tällä viikolla",
				"next": "ensi viikolla",
				"past": [
					"one": "{0} viikko sitten",
					"other": "{0} viikkoa sitten"
				],
				"future": "{0} viikon päästä"
			],
			"day": [
				"previous": "eilen",
				"current": "tänään",
				"next": "huomenna",
				"past": [
					"one": "{0} päivä sitten",
					"other": "{0} päivää sitten"
				],
				"future": "{0} päivän päästä"
			],
			"hour": [
				"current": "tämän tunnin aikana",
				"past": [
					"one": "{0} tunti sitten",
					"other": "{0} tuntia sitten"
				],
				"future": "{0} tunnin päästä"
			],
			"minute": [
				"current": "tämän minuutin aikana",
				"past": [
					"one": "{0} minuutti sitten",
					"other": "{0} minuuttia sitten"
				],
				"future": "{0} minuutin päästä"
			],
			"second": [
				"current": "nyt",
				"past": [
					"one": "{0} sekunti sitten",
					"other": "{0} sekuntia sitten"
				],
				"future": "{0} sekunnin päästä"
			],
			"now": "nyt"
		]
	}
}
