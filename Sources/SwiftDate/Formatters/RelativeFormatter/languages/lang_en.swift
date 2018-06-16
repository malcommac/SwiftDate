//
//  lang_en.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_en: RelativeFormatterLang {
	public static let identifier: String = "en"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value == 1 ? .one : .other)
	}

	public var flavours: [String: Any] {
		return [
			RelativeFormatter.Flavour.long.rawValue: self._long,
			RelativeFormatter.Flavour.longConvenient.rawValue: self._longConvenient,
			RelativeFormatter.Flavour.longTime.rawValue: self._longTime,
			RelativeFormatter.Flavour.narrow.rawValue: self._narrow,
			RelativeFormatter.Flavour.shortConvenient.rawValue: self._shortConvenient,
			RelativeFormatter.Flavour.shortTime.rawValue: self._shortTime,
			RelativeFormatter.Flavour.short.rawValue: self._short,
			RelativeFormatter.Flavour.tiny.rawValue: self._tiny
		]
	}

	private var _tiny: [String: Any] {
		return [
			"year": "{0}yr",
			"month": "{0}mo",
			"week": "{0}wk",
			"day": "{0}d",
			"hour": "{0}h",
			"minute": "{0}m",
			"second": "{0}s",
			"now": "now"
		]
	}

	private var _short: [String: Any] {
		return [
			"year": [
				"previous": "last yr.",
				"current": "this yr.",
				"next": "next yr.",
				"past": "{0} yr. ago",
				"future": "in {0} yr."
			],
			"quarter": [
				"previous": "last qtr.",
				"current": "this qtr.",
				"next": "next qtr.",
				"past": [
					"one": "{0} qtr. ago",
					"other": "{0} qtrs. ago"
				],
				"future": [
					"one": "in {0} qtr.",
					"other": "in {0} qtrs."
				]
			],
			"month": [
				"previous": "last mo.",
				"current": "this mo.",
				"next": "next mo.",
				"past": "{0} mo. ago",
				"future": "in {0} mo."
			],
			"week": [
				"previous": "last wk.",
				"current": "this wk.",
				"next": "next wk.",
				"past": "{0} wk. ago",
				"future": "in {0} wk."
			],
			"day": [
				"previous": "yesterday",
				"current": "today",
				"next": "tomorrow",
				"past": [
					"one": "{0} day ago",
					"other": "{0} days ago"
				],
				"future": [
					"one": "in {0} day",
					"other": "in {0} days"
				]
			],
			"hour": [
				"current": "this hour",
				"past": "{0} hr. ago",
				"future": "in {0} hr."
			],
			"minute": [
				"current": "this minute",
				"past": "{0} min. ago",
				"future": "in {0} min."
			],
			"second": [
				"current": "now",
				"past": "{0} sec. ago",
				"future": "in {0} sec."
			],
			"now": "now"
		]
	}

	private var _shortTime: [String: Any] {
		return [
			"year": "{0} yr.",
			"month": "{0} mo.",
			"week": "{0} wk.",
			"day": [
				"one": "{0} day",
				"other": "{0} days"
			],
			"hour": "{0} hr.",
			"minute": "{0} min.",
			"second": "{0} sec.",
			"now": "now"
		]
	}

	private var _shortConvenient: [String: Any] {
		return [
			"year": [
				"previous": "last yr.",
				"current": "this yr.",
				"next": "next yr.",
				"past": "{0} yr. ago",
				"future": "in {0} yr."
			],
			"quarter": [
				"previous": "last qtr.",
				"current": "this qtr.",
				"next": "next qtr.",
				"past": [
					"one": "{0} qtr. ago",
					"other": "{0} qtrs. ago"
				],
				"future": [
					"one": "in {0} qtr.",
					"other": "in {0} qtrs."
				]
			],
			"month": [
				"previous": "last mo.",
				"current": "this mo.",
				"next": "next mo.",
				"past": "{0} mo. ago",
				"future": "in {0} mo."
			],
			"week": [
				"previous": "last wk.",
				"current": "this wk.",
				"next": "next wk.",
				"past": "{0} wk. ago",
				"future": "in {0} wk."
			],
			"day": [
				"previous": "yesterday",
				"current": "today",
				"next": "tomorrow",
				"past": [
					"one": "{0} day ago",
					"other": "{0} days ago"
				],
				"future": [
					"one": "in {0} day",
					"other": "in {0} days"
				]
			],
			"hour": [
				"current": "this hour",
				"past": "{0} hr. ago",
				"future": "in {0} hr."
			],
			"minute": [
				"current": "this minute",
				"past": "{0} min. ago",
				"future": "in {0} min."
			],
			"second": [
				"current": "now",
				"past": "{0} sec. ago",
				"future": "in {0} sec."
			],
			"now": [
				"future": "in a moment",
				"past": "just now"
			]
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "last yr.",
				"current": "this yr.",
				"next": "next yr.",
				"past": "{0} yr. ago",
				"future": "in {0} yr."
			],
			"quarter": [
				"previous": "last qtr.",
				"current": "this qtr.",
				"next": "next qtr.",
				"past": [
					"one": "{0} qtr. ago",
					"other": "{0} qtrs. ago"
				],
				"future": [
					"one": "in {0} qtr.",
					"other": "in {0} qtrs."
				]
			],
			"month": [
				"previous": "last mo.",
				"current": "this mo.",
				"next": "next mo.",
				"past": "{0} mo. ago",
				"future": "in {0} mo."
			],
			"week": [
				"previous": "last wk.",
				"current": "this wk.",
				"next": "next wk.",
				"past": "{0} wk. ago",
				"future": "in {0} wk."
			],
			"day": [
				"previous": "yesterday",
				"current": "today",
				"next": "tomorrow",
				"past": [
					"one": "{0} day ago",
					"other": "{0} days ago"
				],
				"future": [
					"one": "in {0} day",
					"other": "in {0} days"
				]
			],
			"hour": [
				"current": "this hour",
				"past": "{0} hr. ago",
				"future": "in {0} hr."
			],
			"minute": [
				"current": "this minute",
				"past": "{0} min. ago",
				"future": "in {0} min."
			],
			"second": [
				"current": "now",
				"past": "{0} sec. ago",
				"future": "in {0} sec."
			],
			"now": "now"
		]
	}

	private var _longTime: [String: Any] {
		return [
			"year": [
				"one": "{0} year",
				"other": "{0} years"
			],
			"month": [
				"one": "{0} month",
				"other": "{0} months"
			],
			"week": [
				"one": "{0} week",
				"other": "{0} weeks"
			],
			"day": [
				"one": "{0} day",
				"other": "{0} days"
			],
			"hour": [
				"one": "{0} hour",
				"other": "{0} hours"
			],
			"minute": [
				"one": "{0} minute",
				"other": "{0} minutes"
			],
			"second": [
				"one": "{0} second",
				"other": "{0} seconds"
			],
			"now": [
				"future": "in a moment",
				"past": "just now"
			]
		]
	}

	private var _longConvenient: [String: Any] {
		return [
			"year": [
				"previous": "last year",
				"current": "this year",
				"next": "next year",
				"past": [
					"one": "a year ago",
					"other": "{0} years ago"
				],
				"future": [
					"one": "in a year",
					"other": "in {0} years"
				]
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": [
					"one": "a quarter ago",
					"other": "{0} quarters ago"
				],
				"future": [
					"one": "in a quarter",
					"other": "in {0} quarters"
				]
			],
			"month": [
				"previous": "last month",
				"current": "this month",
				"next": "next month",
				"past": [
					"one": "a month ago",
					"other": "{0} months ago"
				],
				"future": [
					"one": "in a month",
					"other": "in {0} months"
				]
			],
			"week": [
				"previous": "last week",
				"current": "this week",
				"next": "next week",
				"past": [
					"one": "a week ago",
					"other": "{0} weeks ago"
				],
				"future": [
					"one": "in a week",
					"other": "in {0} weeks"
				]
			],
			"day": [
				"previous": "yesterday",
				"current": "today",
				"next": "tomorrow",
				"past": [
					"one": "a day ago",
					"other": "{0} days ago"
				],
				"future": [
					"one": "in a day",
					"other": "in {0} days"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "an hour ago",
					"other": "{0} hours ago"
				],
				"future": [
					"one": "in an hour",
					"other": "in {0} hours"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "a minute ago",
					"other": "{0} minutes ago"
				],
				"future": [
					"one": "in a minute",
					"other": "in {0} minutes"
				]
			],
			"second": [
				"current": "now",
				"past": [
					"one": "a second ago",
					"other": "{0} seconds ago"
				],
				"future": [
					"one": "in a second",
					"other": "in {0} seconds"
				]
			],
			"now": [
				"future": "in a moment",
				"past": "just now"
			]
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "last year",
				"current": "this year",
				"next": "next year",
				"past": [
					"one": "{0} year ago",
					"other": "{0} years ago"
				],
				"future": [
					"one": "in {0} year",
					"other": "in {0} years"
				]
			],
			"quarter": [
				"previous": "last quarter",
				"current": "this quarter",
				"next": "next quarter",
				"past": [
					"one": "{0} quarter ago",
					"other": "{0} quarters ago"
				],
				"future": [
					"one": "in {0} quarter",
					"other": "in {0} quarters"
				]
			],
			"month": [
				"previous": "last month",
				"current": "this month",
				"next": "next month",
				"past": [
					"one": "{0} month ago",
					"other": "{0} months ago"
				],
				"future": [
					"one": "in {0} month",
					"other": "in {0} months"
				]
			],
			"week": [
				"previous": "last week",
				"current": "this week",
				"next": "next week",
				"past": [
					"one": "{0} week ago",
					"other": "{0} weeks ago"
				],
				"future": [
					"one": "in {0} week",
					"other": "in {0} weeks"
				]
			],
			"day": [
				"previous": "yesterday",
				"current": "today",
				"next": "tomorrow",
				"past": [
					"one": "{0} day ago",
					"other": "{0} days ago"
				],
				"future": [
					"one": "in {0} day",
					"other": "in {0} days"
				]
			],
			"hour": [
				"current": "this hour",
				"past": [
					"one": "{0} hour ago",
					"other": "{0} hours ago"
				],
				"future": [
					"one": "in {0} hour",
					"other": "in {0} hours"
				]
			],
			"minute": [
				"current": "this minute",
				"past": [
					"one": "{0} minute ago",
					"other": "{0} minutes ago"
				],
				"future": [
					"one": "in {0} minute",
					"other": "in {0} minutes"
				]
			],
			"second": [
				"current": "now",
				"past": [
					"one": "{0} second ago",
					"other": "{0} seconds ago"
				],
				"future": [
					"one": "in {0} second",
					"other": "in {0} seconds"
				]
			],
			"now": "now"
		]
	}

}
