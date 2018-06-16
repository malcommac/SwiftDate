import Foundation

// swiftlint:disable type_name
public class lang_km: RelativeFormatterLang {

	/// Khmer
	public static let identifier: String = "km"

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
		"previous": "ឆ្នាំ​មុន",
		"current": "ឆ្នាំ​នេះ",
		"next": "ឆ្នាំ​ក្រោយ",
		"past": "{0} ឆ្នាំ​មុន",
		"future": "{0} ឆ្នាំទៀត"
	],
	"quarter": [
		"previous": "ត្រីមាស​មុន",
		"current": "ត្រីមាស​នេះ",
		"next": "ត្រីមាស​ក្រោយ",
		"past": "{0} ត្រីមាស​មុន",
		"future": "{0} ត្រីមាសទៀត"
	],
	"month": [
		"previous": "ខែ​មុន",
		"current": "ខែ​នេះ",
		"next": "ខែ​ក្រោយ",
		"past": "{0} ខែមុន",
		"future": "{0} ខែទៀត"
	],
	"week": [
		"previous": "សប្ដាហ៍​មុន",
		"current": "សប្ដាហ៍​នេះ",
		"next": "សប្ដាហ៍​ក្រោយ",
		"past": "{0} សប្ដាហ៍​មុន",
		"future": "{0} សប្ដាហ៍ទៀត"
	],
	"day": [
		"previous": "ម្សិលមិញ",
		"current": "ថ្ងៃ​នេះ",
		"next": "ថ្ងៃស្អែក",
		"past": "{0} ថ្ងៃ​​មុន",
		"future": "{0} ថ្ងៃទៀត"
	],
	"hour": [
		"current": "ម៉ោងនេះ",
		"past": "{0} ម៉ោង​មុន",
		"future": "{0} ម៉ោងទៀត"
	],
	"minute": [
		"current": "នាទីនេះ",
		"past": "{0} នាទី​​មុន",
		"future": "{0} នាទីទៀត"
	],
	"second": [
		"current": "ឥឡូវ",
		"past": "{0} វិនាទី​មុន",
		"future": "{0} វិនាទីទៀត"
	],
	"now": "ឥឡូវ"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ឆ្នាំ​មុន",
		"current": "ឆ្នាំ​នេះ",
		"next": "ឆ្នាំ​ក្រោយ",
		"past": "{0} ឆ្នាំ​មុន",
		"future": "{0} ឆ្នាំទៀត"
	],
	"quarter": [
		"previous": "ត្រីមាស​មុន",
		"current": "ត្រីមាស​នេះ",
		"next": "ត្រីមាស​ក្រោយ",
		"past": "{0} ត្រីមាស​មុន",
		"future": "{0} ត្រីមាសទៀត"
	],
	"month": [
		"previous": "ខែ​មុន",
		"current": "ខែ​នេះ",
		"next": "ខែ​ក្រោយ",
		"past": "{0} ខែមុន",
		"future": "{0} ខែទៀត"
	],
	"week": [
		"previous": "សប្ដាហ៍​មុន",
		"current": "សប្ដាហ៍​នេះ",
		"next": "សប្ដាហ៍​ក្រោយ",
		"past": "{0} សប្ដាហ៍​មុន",
		"future": "{0} សប្ដាហ៍ទៀត"
	],
	"day": [
		"previous": "ម្សិលមិញ",
		"current": "ថ្ងៃ​នេះ",
		"next": "ថ្ងៃស្អែក",
		"past": "{0} ថ្ងៃ​​មុន",
		"future": "{0} ថ្ងៃទៀត"
	],
	"hour": [
		"current": "ម៉ោងនេះ",
		"past": "{0} ម៉ោង​មុន",
		"future": "{0} ម៉ោងទៀត"
	],
	"minute": [
		"current": "នាទីនេះ",
		"past": "{0} នាទី​​មុន",
		"future": "{0} នាទីទៀត"
	],
	"second": [
		"current": "ឥឡូវ",
		"past": "{0} វិនាទី​មុន",
		"future": "{0} វិនាទីទៀត"
	],
	"now": "ឥឡូវ"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ឆ្នាំ​មុន",
		"current": "ឆ្នាំ​នេះ",
		"next": "ឆ្នាំ​ក្រោយ",
		"past": "{0} ឆ្នាំ​មុន",
		"future": "{0} ឆ្នាំទៀត"
	],
	"quarter": [
		"previous": "ត្រីមាស​មុន",
		"current": "ត្រីមាស​នេះ",
		"next": "ត្រីមាស​ក្រោយ",
		"past": "{0} ត្រីមាស​មុន",
		"future": "{0} ត្រីមាសទៀត"
	],
	"month": [
		"previous": "ខែ​មុន",
		"current": "ខែ​នេះ",
		"next": "ខែ​ក្រោយ",
		"past": "{0} ខែមុន",
		"future": "{0} ខែទៀត"
	],
	"week": [
		"previous": "សប្ដាហ៍​មុន",
		"current": "សប្ដាហ៍​នេះ",
		"next": "សប្ដាហ៍​ក្រោយ",
		"past": "{0} សប្ដាហ៍​មុន",
		"future": "{0} សប្ដាហ៍ទៀត"
	],
	"day": [
		"previous": "ម្សិលមិញ",
		"current": "ថ្ងៃ​នេះ",
		"next": "ថ្ងៃ​ស្អែក",
		"past": "{0} ថ្ងៃ​មុន",
		"future": "{0} ថ្ងៃទៀត"
	],
	"hour": [
		"current": "ម៉ោងនេះ",
		"past": "{0} ម៉ោង​មុន",
		"future": "ក្នុង​រយៈ​ពេល {0} ម៉ោង"
	],
	"minute": [
		"current": "នាទីនេះ",
		"past": "{0} នាទី​មុន",
		"future": "{0} នាទីទៀត"
	],
	"second": [
		"current": "ឥឡូវ",
		"past": "{0} វិនាទី​មុន",
		"future": "{0} វិនាទីទៀត"
	],
	"now": "ឥឡូវ"
]
	}
}
