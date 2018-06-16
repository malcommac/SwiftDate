//
//  lang_el.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
public class lang_el: RelativeFormatterLang {

	/// Locales.greek
	public static let identifier: String = "el"

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
				"previous": "πέρσι",
				"current": "φέτος",
				"next": "επόμενο έτος",
				"past": [
					"one": "πριν από {0} έτος",
					"other": "πριν από {0} έτη"
				],
				"future": [
					"one": "σε {0} έτος",
					"other": "σε {0} έτη"
				]
			],
			"quarter": [
				"previous": "προηγ. τρίμ.",
				"current": "τρέχον τρίμ.",
				"next": "επόμ. τρίμ.",
				"past": "πριν από {0} τρίμ.",
				"future": "σε {0} τρίμ."
			],
			"month": [
				"previous": "προηγούμενος μήνας",
				"current": "τρέχων μήνας",
				"next": "επόμενος μήνας",
				"past": [
					"one": "πριν από {0} μήνα",
					"other": "πριν από {0} μήνες"
				],
				"future": [
					"one": "σε {0} μήνα",
					"other": "σε {0} μήνες"
				]
			],
			"week": [
				"previous": "προηγούμενη εβδομάδα",
				"current": "τρέχουσα εβδομάδα",
				"next": "επόμενη εβδομάδα",
				"past": "πριν από {0} εβδ.",
				"future": "σε {0} εβδ."
			],
			"day": [
				"previous": "χθες",
				"current": "σήμερα",
				"next": "αύριο",
				"past": "πριν από {0} ημ.",
				"future": "σε {0} ημ."
			],
			"hour": [
				"current": "τρέχουσα ώρα",
				"past": "πριν από {0} ώ.",
				"future": "σε {0} ώ."
			],
			"minute": [
				"current": "τρέχον λεπτό",
				"past": "πριν από {0} λεπ.",
				"future": "σε {0} λεπ."
			],
			"second": [
				"current": "τώρα",
				"past": "πριν από {0} δευτ.",
				"future": "σε {0} δευτ."
			],
			"now": "τώρα"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "πέρσι",
				"current": "φέτος",
				"next": "επόμενο έτος",
				"past": [
					"one": "{0} έτος πριν",
					"other": "{0} έτη πριν"
				],
				"future": [
					"one": "σε {0} έτος",
					"other": "σε {0} έτη"
				]
			],
			"quarter": [
				"previous": "προηγ. τρίμ.",
				"current": "τρέχον τρίμ.",
				"next": "επόμ. τρίμ.",
				"past": "{0} τρίμ. πριν",
				"future": "σε {0} τρίμ."
			],
			"month": [
				"previous": "προηγούμενος μήνας",
				"current": "τρέχων μήνας",
				"next": "επόμενος μήνας",
				"past": "{0} μ. πριν",
				"future": "σε {0} μ."
			],
			"week": [
				"previous": "προηγούμενη εβδομάδα",
				"current": "τρέχουσα εβδομάδα",
				"next": "επόμενη εβδομάδα",
				"past": "{0} εβδ. πριν",
				"future": "σε {0} εβδ."
			],
			"day": [
				"previous": "χθες",
				"current": "σήμερα",
				"next": "αύριο",
				"past": "{0} ημ. πριν",
				"future": "σε {0} ημ."
			],
			"hour": [
				"current": "τρέχουσα ώρα",
				"past": "{0} ώ. πριν",
				"future": "σε {0} ώ."
			],
			"minute": [
				"current": "τρέχον λεπτό",
				"past": "{0} λ. πριν",
				"future": "σε {0} λ."
			],
			"second": [
				"current": "τώρα",
				"past": "{0} δ. πριν",
				"future": "σε {0} δ."
			],
			"now": "τώρα"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "πέρσι",
				"current": "φέτος",
				"next": "επόμενο έτος",
				"past": [
					"one": "πριν από {0} έτος",
					"other": "πριν από {0} έτη"
				],
				"future": [
					"one": "σε {0} έτος",
					"other": "σε {0} έτη"
				]
			],
			"quarter": [
				"previous": "προηγούμενο τρίμηνο",
				"current": "τρέχον τρίμηνο",
				"next": "επόμενο τρίμηνο",
				"past": [
					"one": "πριν από {0} τρίμηνο",
					"other": "πριν από {0} τρίμηνα"
				],
				"future": [
					"one": "σε {0} τρίμηνο",
					"other": "σε {0} τρίμηνα"
				]
			],
			"month": [
				"previous": "προηγούμενος μήνας",
				"current": "τρέχων μήνας",
				"next": "επόμενος μήνας",
				"past": [
					"one": "πριν από {0} μήνα",
					"other": "πριν από {0} μήνες"
				],
				"future": [
					"one": "σε {0} μήνα",
					"other": "σε {0} μήνες"
				]
			],
			"week": [
				"previous": "προηγούμενη εβδομάδα",
				"current": "τρέχουσα εβδομάδα",
				"next": "επόμενη εβδομάδα",
				"past": [
					"one": "πριν από {0} εβδομάδα",
					"other": "πριν από {0} εβδομάδες"
				],
				"future": [
					"one": "σε {0} εβδομάδα",
					"other": "σε {0} εβδομάδες"
				]
			],
			"day": [
				"previous": "χθες",
				"current": "σήμερα",
				"next": "αύριο",
				"past": [
					"one": "πριν από {0} ημέρα",
					"other": "πριν από {0} ημέρες"
				],
				"future": [
					"one": "σε {0} ημέρα",
					"other": "σε {0} ημέρες"
				]
			],
			"hour": [
				"current": "τρέχουσα ώρα",
				"past": [
					"one": "πριν από {0} ώρα",
					"other": "πριν από {0} ώρες"
				],
				"future": [
					"one": "σε {0} ώρα",
					"other": "σε {0} ώρες"
				]
			],
			"minute": [
				"current": "τρέχον λεπτό",
				"past": [
					"one": "πριν από {0} λεπτό",
					"other": "πριν από {0} λεπτά"
				],
				"future": [
					"one": "σε {0} λεπτό",
					"other": "σε {0} λεπτά"
				]
			],
			"second": [
				"current": "τώρα",
				"past": [
					"one": "πριν από {0} δευτερόλεπτο",
					"other": "πριν από {0} δευτερόλεπτα"
				],
				"future": [
					"one": "σε {0} δευτερόλεπτο",
					"other": "σε {0} δευτερόλεπτα"
				]
			],
			"now": "τώρα"
		]
	}
}
