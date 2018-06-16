//
//  lang_bg.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_bg: RelativeFormatterLang {

	/// Locales.bulgarian
	public static let identifier: String = "bg"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (Int(value) == 1 ? .one : .other)
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
				"previous": "мин. г.",
				"current": "т. г.",
				"next": "следв. г.",
				"past": "преди {0} г.",
				"future": "след {0} г."
			],
			"quarter": [
				"previous": "мин. трим.",
				"current": "това трим.",
				"next": "следв. трим.",
				"past": "преди {0} трим.",
				"future": "след {0} трим."
			],
			"month": [
				"previous": "мин. мес.",
				"current": "този мес.",
				"next": "следв. мес.",
				"past": "преди {0} м.",
				"future": "след {0} м."
			],
			"week": [
				"previous": "миналата седмица",
				"current": "тази седм.",
				"next": "следв. седм.",
				"past": "преди {0} седм.",
				"future": "след {0} седм."
			],
			"day": [
				"previous": "вчера",
				"current": "днес",
				"next": "утре",
				"past": [
					"one": "преди {0} ден",
					"other": "преди {0} дни"
				],
				"future": [
					"one": "след {0} ден",
					"other": "след {0} дни"
				]
			],
			"hour": [
				"current": "в този час",
				"past": "преди {0} ч",
				"future": "след {0} ч"
			],
			"minute": [
				"current": "в тази минута",
				"past": "преди {0} мин",
				"future": "след {0} мин"
			],
			"second": [
				"current": "сега",
				"past": "преди {0} сек",
				"future": "след {0} сек"
			],
			"now": "сега"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "мин. г.",
				"current": "т. г.",
				"next": "сл. г.",
				"past": "пр. {0} г.",
				"future": "сл. {0} г."
			],
			"quarter": [
				"previous": "мин. трим.",
				"current": "това трим.",
				"next": "следв. трим.",
				"past": "пр. {0} трим.",
				"future": "сл. {0} трим."
			],
			"month": [
				"previous": "мин. м.",
				"current": "т. м.",
				"next": "сл. м.",
				"past": "пр. {0} м.",
				"future": "сл. {0} м."
			],
			"week": [
				"previous": "мин. седм.",
				"current": "тази седм.",
				"next": "сл. седм.",
				"past": "пр. {0} седм.",
				"future": "сл. {0} седм."
			],
			"day": [
				"previous": "вчера",
				"current": "днес",
				"next": "утре",
				"past": "пр. {0} д",
				"future": "сл. {0} д"
			],
			"hour": [
				"current": "в този час",
				"past": "пр. {0} ч",
				"future": "сл. {0} ч"
			],
			"minute": [
				"current": "в тази минута",
				"past": "пр. {0} мин",
				"future": "сл. {0} мин"
			],
			"second": [
				"current": "сега",
				"past": "пр. {0} сек",
				"future": "сл. {0} сек"
			],
			"now": "сега"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "миналата година",
				"current": "тази година",
				"next": "следващата година",
				"past": [
					"one": "преди {0} година",
					"other": "преди {0} години"
				],
				"future": [
					"one": "след {0} година",
					"other": "след {0} години"
				]
			],
			"quarter": [
				"previous": "предходно тримесечие",
				"current": "това тримесечие",
				"next": "следващо тримесечие",
				"past": [
					"one": "преди {0} тримесечие",
					"other": "преди {0} тримесечия"
				],
				"future": [
					"one": "след {0} тримесечие",
					"other": "след {0} тримесечия"
				]
			],
			"month": [
				"previous": "предходен месец",
				"current": "този месец",
				"next": "следващ месец",
				"past": [
					"one": "преди {0} месец",
					"other": "преди {0} месеца"
				],
				"future": [
					"one": "след {0} месец",
					"other": "след {0} месеца"
				]
			],
			"week": [
				"previous": "предходната седмица",
				"current": "тази седмица",
				"next": "следващата седмица",
				"past": [
					"one": "преди {0} седмица",
					"other": "преди {0} седмици"
				],
				"future": [
					"one": "след {0} седмица",
					"other": "след {0} седмици"
				]
			],
			"day": [
				"previous": "вчера",
				"current": "днес",
				"next": "утре",
				"past": [
					"one": "преди {0} ден",
					"other": "преди {0} дни"
				],
				"future": [
					"one": "след {0} ден",
					"other": "след {0} дни"
				]
			],
			"hour": [
				"current": "в този час",
				"past": [
					"one": "преди {0} час",
					"other": "преди {0} часа"
				],
				"future": [
					"one": "след {0} час",
					"other": "след {0} часа"
				]
			],
			"minute": [
				"current": "в тази минута",
				"past": [
					"one": "преди {0} минута",
					"other": "преди {0} минути"
				],
				"future": [
					"one": "след {0} минута",
					"other": "след {0} минути"
				]
			],
			"second": [
				"current": "сега",
				"past": [
					"one": "преди {0} секунда",
					"other": "преди {0} секунди"
				],
				"future": [
					"one": "след {0} секунда",
					"other": "след {0} секунди"
				]
			],
			"now": "сега"
		]
	}
}
