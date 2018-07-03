//
//  lang_fil.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_fil: RelativeFormatterLang {

	/// Locales.filipino
	public static let identifier: String = "fil"

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
				"previous": "nakaraang taon",
				"current": "ngayong taon",
				"next": "susunod na taon",
				"past": [
					"one": "{0} taon ang nakalipas",
					"other": "{0} (na) taon ang nakalipas"
				],
				"future": [
					"one": "sa {0} taon",
					"other": "sa {0} (na) taon"
				]
			],
			"quarter": [
				"previous": "nakaraang quarter",
				"current": "ngayong quarter",
				"next": "susunod na quarter",
				"past": [
					"one": "{0} quarter ang nakalipas",
					"other": "{0} (na) quarter ang nakalipas"
				],
				"future": "sa {0} (na) quarter"
			],
			"month": [
				"previous": "nakaraang buwan",
				"current": "ngayong buwan",
				"next": "susunod na buwan",
				"past": [
					"one": "{0} buwan ang nakalipas",
					"other": "{0} (na) buwan ang nakalipas"
				],
				"future": [
					"one": "sa {0} buwan",
					"other": "sa {0} (na) buwan"
				]
			],
			"week": [
				"previous": "nakaraang linggo",
				"current": "ngayong linggo",
				"next": "susunod na linggo",
				"past": [
					"one": "{0} linggo ang nakalipas",
					"other": "{0} (na) linggo ang nakalipas"
				],
				"future": [
					"one": "sa {0} linggo",
					"other": "sa {0} (na) linggo"
				]
			],
			"day": [
				"previous": "kahapon",
				"current": "ngayong araw",
				"next": "bukas",
				"past": "{0} (na) araw ang nakalipas",
				"future": "sa {0} (na) araw"
			],
			"hour": [
				"current": "ngayong oras",
				"past": [
					"one": "{0} oras ang nakalipas",
					"other": "{0} (na) oras ang nakalipas"
				],
				"future": [
					"one": "sa {0} oras",
					"other": "sa {0} (na) oras"
				]
			],
			"minute": [
				"current": "sa minutong ito",
				"past": [
					"one": "{0} min. ang nakalipas",
					"other": "{0} (na) min. ang nakalipas"
				],
				"future": [
					"one": "sa {0} min.",
					"other": "sa {0} (na) min."
				]
			],
			"second": [
				"current": "ngayon",
				"past": [
					"one": "{0} seg. ang nakalipas",
					"other": "{0} (na) seg. nakalipas"
				],
				"future": [
					"one": "sa {0} seg.",
					"other": "sa {0} (na) seg."
				]
			],
			"now": "ngayon"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "nakaraang taon",
				"current": "ngayong taon",
				"next": "susunod na taon",
				"past": [
					"one": "{0} taon ang nakalipas",
					"other": "{0} (na) taon ang nakalipas"
				],
				"future": [
					"one": "sa {0} taon",
					"other": "sa {0} (na) taon"
				]
			],
			"quarter": [
				"previous": "nakaraang quarter",
				"current": "ngayong quarter",
				"next": "susunod na quarter",
				"past": [
					"one": "{0} quarter ang nakalipas",
					"other": "{0} (na) quarter ang nakalipas"
				],
				"future": [
					"one": "sa {0} quarter",
					"other": "sa {0} (na) quarter"
				]
			],
			"month": [
				"previous": "nakaraang buwan",
				"current": "ngayong buwan",
				"next": "susunod na buwan",
				"past": [
					"one": "{0} buwan ang nakalipas",
					"other": "{0} (na) buwan ang nakalipas"
				],
				"future": [
					"one": "sa {0} buwan",
					"other": "sa {0} (na) buwan"
				]
			],
			"week": [
				"previous": "nakaraang linggo",
				"current": "ngayong linggo",
				"next": "susunod na linggo",
				"past": [
					"one": "{0} linggo ang nakalipas",
					"other": "{0} (na) linggo ang nakalipas"
				],
				"future": [
					"one": "sa {0} linggo",
					"other": "sa {0} (na) linggo"
				]
			],
			"day": [
				"previous": "kahapon",
				"current": "ngayong araw",
				"next": "bukas",
				"past": [
					"one": "{0} araw ang nakalipas",
					"other": "{0} (na) araw ang nakalipas"
				],
				"future": [
					"one": "sa {0} araw",
					"other": "sa {0} (na) araw"
				]
			],
			"hour": [
				"current": "ngayong oras",
				"past": [
					"one": "{0} oras nakalipas",
					"other": "{0} (na) oras nakalipas"
				],
				"future": [
					"one": "sa {0} oras",
					"other": "sa {0} (na) oras"
				]
			],
			"minute": [
				"current": "sa minutong ito",
				"past": [
					"one": "{0} min. ang nakalipas",
					"other": "{0} (na) min. ang nakalipas"
				],
				"future": [
					"one": "sa {0} min.",
					"other": "sa {0} (na) min."
				]
			],
			"second": [
				"current": "ngayon",
				"past": [
					"one": "{0} seg. nakalipas",
					"other": "{0} (na) seg. nakalipas"
				],
				"future": [
					"one": "sa {0} seg.",
					"other": "sa {0} (na) seg."
				]
			],
			"now": "ngayon"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "nakaraang taon",
				"current": "ngayong taon",
				"next": "susunod na taon",
				"past": [
					"one": "{0} taon ang nakalipas",
					"other": "{0} (na) taon ang nakalipas"
				],
				"future": [
					"one": "sa {0} taon",
					"other": "sa {0} (na) taon"
				]
			],
			"quarter": [
				"previous": "nakaraang quarter",
				"current": "ngayong quarter",
				"next": "susunod na quarter",
				"past": [
					"one": "{0} quarter ang nakalipas",
					"other": "{0} (na) quarter ang nakalipas"
				],
				"future": [
					"one": "sa {0} quarter",
					"other": "sa {0} (na) quarter"
				]
			],
			"month": [
				"previous": "nakaraang buwan",
				"current": "ngayong buwan",
				"next": "susunod na buwan",
				"past": [
					"one": "{0} buwan ang nakalipas",
					"other": "{0} (na) buwan ang nakalipas"
				],
				"future": [
					"one": "sa {0} buwan",
					"other": "sa {0} (na) buwan"
				]
			],
			"week": [
				"previous": "nakalipas na linggo",
				"current": "sa linggong ito",
				"next": "susunod na linggo",
				"past": [
					"one": "{0} linggo ang nakalipas",
					"other": "{0} (na) linggo ang nakalipas"
				],
				"future": [
					"one": "sa {0} linggo",
					"other": "sa {0} (na) linggo"
				]
			],
			"day": [
				"previous": "kahapon",
				"current": "ngayong araw",
				"next": "bukas",
				"past": [
					"one": "{0} araw ang nakalipas",
					"other": "{0} (na) araw ang nakalipas"
				],
				"future": [
					"one": "sa {0} araw",
					"other": "sa {0} (na) araw"
				]
			],
			"hour": [
				"current": "ngayong oras",
				"past": [
					"one": "{0} oras ang nakalipas",
					"other": "{0} (na) oras ang nakalipas"
				],
				"future": [
					"one": "sa {0} oras",
					"other": "sa {0} (na) oras"
				]
			],
			"minute": [
				"current": "sa minutong ito",
				"past": [
					"one": "{0} minuto ang nakalipas",
					"other": "{0} (na) minuto ang nakalipas"
				],
				"future": [
					"one": "sa {0} minuto",
					"other": "sa {0} (na) minuto"
				]
			],
			"second": [
				"current": "ngayon",
				"past": [
					"one": "{0} segundo ang nakalipas",
					"other": "{0} (na) segundo ang nakalipas"
				],
				"future": [
					"one": "sa {0} segundo",
					"other": "sa {0} (na) segundo"
				]
			],
			"now": "ngayon"
		]
	}
}
