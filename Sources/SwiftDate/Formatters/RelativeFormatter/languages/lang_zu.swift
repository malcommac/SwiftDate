import Foundation

// swiftlint:disable type_name
public class lang_zu: RelativeFormatterLang {

	/// Zulu
	public static let identifier: String = "zu"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return (value >= 0 && value <= 1 ? .one : .other)
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
		"previous": "onyakeni odlule",
		"current": "kulo nyaka",
		"next": "unyaka ozayo",
		"past": "{0} unyaka odlule",
		"future": [
			"one": "onyakeni ongu-{0} ozayo",
			"other": "eminyakeni engu-{0} ezayo"
		]
	],
	"quarter": [
		"previous": "ikota edlule",
		"current": "le kota",
		"next": "ikota ezayo",
		"past": [
			"one": "{0} amakota adlule",
			"other": "{0} amakota edlule"
		],
		"future": [
			"one": "kwikota engu-{0} ezayo",
			"other": "kumakota angu-{0} ezayo"
		]
	],
	"month": [
		"previous": "inyanga edlule",
		"current": "le nyanga",
		"next": "inyanga ezayo",
		"past": "{0} izinyanga ezedlule",
		"future": "ezinyangeni ezingu-{0} ezizayo"
	],
	"week": [
		"previous": "iviki eledlule",
		"current": "leli viki",
		"next": "iviki elizayo",
		"past": "amaviki angu-{0} edlule",
		"future": [
			"one": "evikini elingu-{0} elizayo",
			"other": "emavikini angu-{0} ezayo"
		]
	],
	"day": [
		"previous": "izolo",
		"current": "namhlanje",
		"next": "kusasa",
		"past": [
			"one": "{0} usuku olwedlule",
			"other": "{0} izinsuku ezedlule"
		],
		"future": [
			"one": "osukwini olungu-{0} oluzayo",
			"other": "ezinsukwini ezingu-{0} ezizayo"
		]
	],
	"hour": [
		"current": "leli hora",
		"past": [
			"one": "{0} ihora eledlule",
			"other": "emahoreni angu-{0} edlule"
		],
		"future": [
			"one": "ehoreni elingu-{0} elizayo",
			"other": "emahoreni angu-{0} ezayo"
		]
	],
	"minute": [
		"current": "leli minithi",
		"past": [
			"one": "{0} iminithi eledlule",
			"other": "{0} amaminithi edlule"
		],
		"future": [
			"one": "kuminithi elingu-{0} elizayo",
			"other": "kumaminithi angu-{0} ezayo"
		]
	],
	"second": [
		"current": "manje",
		"past": [
			"one": "{0} isekhondi eledlule",
			"other": "{0} amasekhondi edlule"
		],
		"future": [
			"one": "kusekhondi elingu-{0} elizayo",
			"other": "kumasekhondi angu-{0} ezayo"
		]
	],
	"now": "manje"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "onyakeni odlule",
		"current": "kulo nyaka",
		"next": "unyaka ozayo",
		"past": "{0} unyaka odlule",
		"future": [
			"one": "onyakeni ongu-{0} ozayo",
			"other": "eminyakeni engu-{0} ezayo"
		]
	],
	"quarter": [
		"previous": "ikota edlule",
		"current": "le kota",
		"next": "ikota ezayo",
		"past": [
			"one": "{0} amakota adlule",
			"other": "{0} amakota edlule"
		],
		"future": "kumakota angu-{0}"
	],
	"month": [
		"previous": "inyanga edlule",
		"current": "le nyanga",
		"next": "inyanga ezayo",
		"past": "{0} izinyanga ezedlule",
		"future": "enyangeni engu-{0} ezayo"
	],
	"week": [
		"previous": "iviki eledlule",
		"current": "leli viki",
		"next": "iviki elizayo",
		"past": "amaviki angu-{0} edlule",
		"future": "emavikini angu-{0} ezayo"
	],
	"day": [
		"previous": "izolo",
		"current": "namhlanje",
		"next": "kusasa",
		"past": [
			"one": "{0} usuku olwedlule",
			"other": "{0} izinsuku ezedlule"
		],
		"future": [
			"one": "osukwini olungu-{0} oluzayo",
			"other": "ezinsukwini ezingu-{0} ezizayo"
		]
	],
	"hour": [
		"current": "leli hora",
		"past": [
			"one": "{0} ihora eledlule",
			"other": "{0} amahora edlule"
		],
		"future": [
			"one": "ehoreni elingu-{0} elizayo",
			"other": "emahoreni angu-{0} ezayo"
		]
	],
	"minute": [
		"current": "leli minithi",
		"past": [
			"one": "{0} iminithi eledlule",
			"other": "{0} amaminithi edlule"
		],
		"future": [
			"one": "kuminithi elingu-{0} elizayo",
			"other": "kumaminithi angu-{0} ezayo"
		]
	],
	"second": [
		"current": "manje",
		"past": [
			"one": "{0} isekhondi eledlule",
			"other": "{0} amasekhondi edlule"
		],
		"future": [
			"one": "kusekhondi elingu-{0} elizayo",
			"other": "kumasekhondi angu-{0} ezayo"
		]
	],
	"now": "manje"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "onyakeni odlule",
		"current": "kulo nyaka",
		"next": "unyaka ozayo",
		"past": [
			"one": "{0} unyaka odlule",
			"other": "{0} iminyaka edlule"
		],
		"future": [
			"one": "onyakeni ongu-{0} ozayo",
			"other": "eminyakeni engu-{0} ezayo"
		]
	],
	"quarter": [
		"previous": "ikota edlule",
		"current": "le kota",
		"next": "ikota ezayo",
		"past": [
			"one": "{0} ikota edlule",
			"other": "{0} amakota adlule"
		],
		"future": [
			"one": "kwikota engu-{0} ezayo",
			"other": "kumakota angu-{0} ezayo"
		]
	],
	"month": [
		"previous": "inyanga edlule",
		"current": "le nyanga",
		"next": "inyanga ezayo",
		"past": [
			"one": "{0} inyanga edlule",
			"other": "{0} izinyanga ezedlule"
		],
		"future": [
			"one": "enyangeni engu-{0}",
			"other": "ezinyangeni ezingu-{0} ezizayo"
		]
	],
	"week": [
		"previous": "iviki eledlule",
		"current": "leli viki",
		"next": "iviki elizayo",
		"past": [
			"one": "evikini elingu-{0} eledlule",
			"other": "amaviki angu-{0} edlule"
		],
		"future": [
			"one": "evikini elingu-{0}",
			"other": "emavikini angu-{0}"
		]
	],
	"day": [
		"previous": "izolo",
		"current": "namhlanje",
		"next": "kusasa",
		"past": [
			"one": "osukwini olungu-{0} olwedlule",
			"other": "ezinsukwini ezingu-{0} ezedlule."
		],
		"future": [
			"one": "osukwini olungu-{0} oluzayo",
			"other": "ezinsukwini ezingu-{0} ezizayo"
		]
	],
	"hour": [
		"current": "leli hora",
		"past": [
			"one": "{0} ihora eledlule",
			"other": "emahoreni angu-{0} edlule"
		],
		"future": [
			"one": "ehoreni elingu-{0} elizayo",
			"other": "emahoreni angu-{0} ezayo"
		]
	],
	"minute": [
		"current": "leli minithi",
		"past": [
			"one": "{0} iminithi eledlule",
			"other": "{0} amaminithi edlule"
		],
		"future": [
			"one": "kuminithi elingu-{0} elizayo",
			"other": "kumaminithi angu-{0} ezayo"
		]
	],
	"second": [
		"current": "manje",
		"past": [
			"one": "{0} isekhondi eledlule",
			"other": "{0} amasekhondi edlule"
		],
		"future": [
			"one": "kusekhondi elingu-{0} elizayo",
			"other": "kumasekhondi angu-{0} ezayo"
		]
	],
	"now": "manje"
]
	}
}
