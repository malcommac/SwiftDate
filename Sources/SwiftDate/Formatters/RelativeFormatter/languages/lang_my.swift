import Foundation

// swiftlint:disable type_name
public class lang_my: RelativeFormatterLang {

	/// Burmese
	public static let identifier: String = "my"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return .other
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
		"previous": "ယမန်နှစ်",
		"current": "ယခုနှစ်",
		"next": "လာမည့်နှစ်",
		"past": "ပြီးခဲ့သည့် {0} နှစ်",
		"future": "{0} နှစ်အတွင်း"
	],
	"quarter": [
		"previous": "ပြီးခဲ့သောသုံးလပတ်",
		"current": "ယခုသုံးလပတ်",
		"next": "နောက်လာမည့်သုံးလပတ်",
		"past": "ပြီးခဲ့သည့် သုံးလပတ်ကာလ {0} ခုအတွင်း",
		"future": "သုံးလပတ်ကာလ {0} ခုအတွင်း"
	],
	"month": [
		"previous": "ပြီးခဲ့သည့်လ",
		"current": "ယခုလ",
		"next": "လာမည့်လ",
		"past": "ပြီးခဲ့သည့် {0} လ",
		"future": "{0} လအတွင်း"
	],
	"week": [
		"previous": "ပြီးခဲ့သည့် သီတင်းပတ်",
		"current": "ယခု သီတင်းပတ်",
		"next": "လာမည့် သီတင်းပတ်",
		"past": "ပြီးခဲ့သည့် {0} ပတ်",
		"future": "{0} ပတ်အတွင်း"
	],
	"day": [
		"previous": "မနေ့က",
		"current": "ယနေ့",
		"next": "မနက်ဖြန်",
		"past": "ပြီးခဲ့သည့် {0} ရက်",
		"future": "{0} ရက်အတွင်း"
	],
	"hour": [
		"current": "ဤအချိန်",
		"past": "ပြီးခဲ့သည့် {0} နာရီ",
		"future": "{0} နာရီအတွင်း"
	],
	"minute": [
		"current": "ဤမိနစ်",
		"past": "ပြီးခဲ့သည့် {0} မိနစ်",
		"future": "{0} မိနစ်အတွင်း"
	],
	"second": [
		"current": "ယခု",
		"past": "ပြီးခဲ့သည့် {0} စက္ကန့်",
		"future": "{0} စက္ကန့်အတွင်း"
	],
	"now": "ယခု"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ယမန်နှစ်",
		"current": "ယခုနှစ်",
		"next": "လာမည့်နှစ်",
		"past": "ပြီးခဲ့သည့် {0} နှစ်",
		"future": "{0} နှစ်အတွင်း"
	],
	"quarter": [
		"previous": "ပြီးခဲ့သောသုံးလပတ်",
		"current": "ယခုသုံးလပတ်",
		"next": "နောက်လာမည့်သုံးလပတ်",
		"past": "ပြီးခဲ့သည့် သုံးလပတ်ကာလ {0} ခုအတွင်း",
		"future": "သုံးလပတ်ကာလ {0} ခုအတွင်း"
	],
	"month": [
		"previous": "ပြီးခဲ့သည့်လ",
		"current": "ယခုလ",
		"next": "လာမည့်လ",
		"past": "ပြီးခဲ့သည့် {0} လ",
		"future": "{0} လအတွင်း"
	],
	"week": [
		"previous": "ပြီးခဲ့သည့် သီတင်းပတ်",
		"current": "ယခု သီတင်းပတ်",
		"next": "လာမည့် သီတင်းပတ်",
		"past": "ပြီးခဲ့သည့် {0} ပတ်",
		"future": "{0} ပတ်အတွင်း"
	],
	"day": [
		"previous": "မနေ့က",
		"current": "ယနေ့",
		"next": "မနက်ဖြန်",
		"past": "ပြီးခဲ့သည့် {0} ရက်",
		"future": "{0} ရက်အတွင်း"
	],
	"hour": [
		"current": "ဤအချိန်",
		"past": "ပြီးခဲ့သည့် {0} နာရီ",
		"future": "{0} နာရီအတွင်း"
	],
	"minute": [
		"current": "ဤမိနစ်",
		"past": "ပြီးခဲ့သည့် {0} မိနစ်",
		"future": "{0} မိနစ်အတွင်း"
	],
	"second": [
		"current": "ယခု",
		"past": "ပြီးခဲ့သည့် {0} စက္ကန့်",
		"future": "{0} စက္ကန့်အတွင်း"
	],
	"now": "ယခု"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ယမန်နှစ်",
		"current": "ယခုနှစ်",
		"next": "လာမည့်နှစ်",
		"past": "ပြီးခဲ့သည့် {0} နှစ်",
		"future": "{0} နှစ်အတွင်း"
	],
	"quarter": [
		"previous": "ပြီးခဲ့သည့် သုံးလပတ်",
		"current": "ယခု သုံးလပတ်",
		"next": "လာမည့် သုံးလပတ်",
		"past": "ပြီးခဲ့သည့် သုံးလပတ်ကာလ {0} ခုအတွင်း",
		"future": "သုံးလပတ်ကာလ {0} အတွင်း"
	],
	"month": [
		"previous": "ပြီးခဲ့သည့်လ",
		"current": "ယခုလ",
		"next": "လာမည့်လ",
		"past": "ပြီးခဲ့သည့် {0} လ",
		"future": "{0} လအတွင်း"
	],
	"week": [
		"previous": "ပြီးခဲ့သည့် သီတင်းပတ်",
		"current": "ယခု သီတင်းပတ်",
		"next": "လာမည့် သီတင်းပတ်",
		"past": "ပြီးခဲ့သည့် {0} ပတ်",
		"future": "{0} ပတ်အတွင်း"
	],
	"day": [
		"previous": "မနေ့က",
		"current": "ယနေ့",
		"next": "မနက်ဖြန်",
		"past": "ပြီးခဲ့သည့် {0} ရက်",
		"future": "{0} ရက်အတွင်း"
	],
	"hour": [
		"current": "ဤအချိန်",
		"past": "ပြီးခဲ့သည့် {0} နာရီ",
		"future": "{0} နာရီအတွင်း"
	],
	"minute": [
		"current": "ဤမိနစ်",
		"past": "ပြီးခဲ့သည့် {0} မိနစ်",
		"future": "{0} မိနစ်အတွင်း"
	],
	"second": [
		"current": "ယခု",
		"past": "ပြီးခဲ့သည့် {0} စက္ကန့်",
		"future": "{0} စက္ကန့်အတွင်း"
	],
	"now": "ယခု"
]
	}
}
