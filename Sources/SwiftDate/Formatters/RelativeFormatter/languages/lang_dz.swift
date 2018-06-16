//
//  lang_dz.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_dz: RelativeFormatterLang {

	/// Locales.dzongkha
	public static let identifier: String = "dz"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return nil
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
				"previous": "last year",
				"current": "this year",
				"next": "next year",
				"past": "ལོ་འཁོར་ {0} ཧེ་མ་",
				"future": "ལོ་འཁོར་ {0} ནང་"
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "last month",
				"current": "this month",
				"next": "next month",
				"past": "ཟླཝ་ {0} ཧེ་མ་",
				"future": "ཟླཝ་ {0} ནང་"
			],
			"week": [
				"previous": "last week",
				"current": "this week",
				"next": "next week",
				"past": "བངུན་ཕྲག་ {0} ཧེ་མ་",
				"future": "བངུན་ཕྲག་ {0} ནང་"
			],
			"day": [
				"previous": "ཁ་ཙ་",
				"current": "ད་རིས་",
				"next": "ནངས་པ་",
				"past": "ཉིནམ་ {0} ཧེ་མ་",
				"future": "ཉིནམ་ {0} ནང་"
			],
			"hour": [
				"current": "this hour",
				"past": "ཆུ་ཚོད་ {0} ཧེ་མ་",
				"future": "ཆུ་ཚོད་ {0} ནང་"
			],
			"minute": [
				"current": "this minute",
				"past": "སྐར་མ་ {0} ཧེ་མ་",
				"future": "སྐར་མ་ {0} ནང་"
			],
			"second": [
				"current": "now",
				"past": "སྐར་ཆ་ {0} ཧེ་མ་",
				"future": "སྐར་ཆ་ {0} ནང་"
			],
			"now": "now"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "last year",
				"current": "this year",
				"next": "next year",
				"past": "ལོ་འཁོར་ {0} ཧེ་མ་",
				"future": "ལོ་འཁོར་ {0} ནང་"
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "last month",
				"current": "this month",
				"next": "next month",
				"past": "ཟླཝ་ {0} ཧེ་མ་",
				"future": "ཟླཝ་ {0} ནང་"
			],
			"week": [
				"previous": "last week",
				"current": "this week",
				"next": "next week",
				"past": "བངུན་ཕྲག་ {0} ཧེ་མ་",
				"future": "བངུན་ཕྲག་ {0} ནང་"
			],
			"day": [
				"previous": "ཁ་ཙ་",
				"current": "ད་རིས་",
				"next": "ནངས་པ་",
				"past": "ཉིནམ་ {0} ཧེ་མ་",
				"future": "ཉིནམ་ {0} ནང་"
			],
			"hour": [
				"current": "this hour",
				"past": "ཆུ་ཚོད་ {0} ཧེ་མ་",
				"future": "ཆུ་ཚོད་ {0} ནང་"
			],
			"minute": [
				"current": "this minute",
				"past": "སྐར་མ་ {0} ཧེ་མ་",
				"future": "སྐར་མ་ {0} ནང་"
			],
			"second": [
				"current": "now",
				"past": "སྐར་ཆ་ {0} ཧེ་མ་",
				"future": "སྐར་ཆ་ {0} ནང་"
			],
			"now": "now"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "last year",
				"current": "this year",
				"next": "next year",
				"past": "ལོ་འཁོར་ {0} ཧེ་མ་",
				"future": "ལོ་འཁོར་ {0} ནང་"
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": "-{0} Q",
				"future": "+{0} Q"
			],
			"month": [
				"previous": "last month",
				"current": "this month",
				"next": "next month",
				"past": "ཟླཝ་ {0} ཧེ་མ་",
				"future": "ཟླཝ་ {0} ནང་"
			],
			"week": [
				"previous": "last week",
				"current": "this week",
				"next": "next week",
				"past": "བངུན་ཕྲག་ {0} ཧེ་མ་",
				"future": "བངུན་ཕྲག་ {0} ནང་"
			],
			"day": [
				"previous": "ཁ་ཙ་",
				"current": "ད་རིས་",
				"next": "ནངས་པ་",
				"past": "ཉིནམ་ {0} ཧེ་མ་",
				"future": "ཉིནམ་ {0} ནང་"
			],
			"hour": [
				"current": "this hour",
				"past": "ཆུ་ཚོད་ {0} ཧེ་མ་",
				"future": "ཆུ་ཚོད་ {0} ནང་"
			],
			"minute": [
				"current": "this minute",
				"past": "སྐར་མ་ {0} ཧེ་མ་",
				"future": "སྐར་མ་ {0} ནང་"
			],
			"second": [
				"current": "now",
				"past": "སྐར་ཆ་ {0} ཧེ་མ་",
				"future": "སྐར་ཆ་ {0} ནང་"
			],
			"now": "now"
		]
	}
}
