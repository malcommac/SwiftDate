import Foundation

// swiftlint:disable type_name
public class lang_lo: RelativeFormatterLang {

	/// Lao
	public static let identifier: String = "lo"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		return nil
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
		"previous": "ປີກາຍ",
		"current": "ປີນີ້",
		"next": "ປີໜ້າ",
		"past": "{0} ປີກ່ອນ",
		"future": "ໃນອີກ {0} ປີ"
	],
	"quarter": [
		"previous": "ໄຕຣມາດກ່ອນໜ້າ",
		"current": "ໄຕຣມາດນີ້",
		"next": "ໄຕຣມາດໜ້າ",
		"past": "{0} ຕມ. ກ່ອນ",
		"future": "ໃນ {0} ຕມ."
	],
	"month": [
		"previous": "ເດືອນແລ້ວ",
		"current": "ເດືອນນີ້",
		"next": "ເດືອນໜ້າ",
		"past": "{0} ດ. ກ່ອນ",
		"future": "ໃນອີກ {0} ດ."
	],
	"week": [
		"previous": "ອາທິດແລ້ວ",
		"current": "ອາທິດນີ້",
		"next": "ອາທິດໜ້າ",
		"past": "{0} ອທ. ກ່ອນ",
		"future": "ໃນອີກ {0} ອທ."
	],
	"day": [
		"previous": "ມື້ວານ",
		"current": "ມື້ນີ້",
		"next": "ມື້ອື່ນ",
		"past": "{0} ມື້ກ່ອນ",
		"future": "ໃນອີກ {0} ມື້"
	],
	"hour": [
		"current": "ຊົ່ວໂມງນີ້",
		"past": "{0} ຊມ. ກ່ອນ",
		"future": "ໃນອີກ {0} ຊມ."
	],
	"minute": [
		"current": "ນາທີນີ້",
		"past": "{0} ນທ. ກ່ອນ",
		"future": "ໃນ {0} ນທ."
	],
	"second": [
		"current": "ຕອນນີ້",
		"past": "{0} ວິ. ກ່ອນ",
		"future": "ໃນ {0} ວິ."
	],
	"now": "ຕອນນີ້"
]
	}

	private var _narrow: [String: Any] {
		return [
	"year": [
		"previous": "ປີກາຍ",
		"current": "ປີນີ້",
		"next": "ປີໜ້າ",
		"past": "{0} ປີກ່ອນ",
		"future": "ໃນອີກ {0} ປີ"
	],
	"quarter": [
		"previous": "ໄຕຣມາດກ່ອນໜ້າ",
		"current": "ໄຕຣມາດນີ້",
		"next": "ໄຕຣມາດໜ້າ",
		"past": "{0} ຕມ. ກ່ອນ",
		"future": "ໃນ {0} ຕມ."
	],
	"month": [
		"previous": "ເດືອນແລ້ວ",
		"current": "ເດືອນນີ້",
		"next": "ເດືອນໜ້າ",
		"past": "{0} ດ. ກ່ອນ",
		"future": "ໃນອີກ {0} ດ."
	],
	"week": [
		"previous": "ອາທິດແລ້ວ",
		"current": "ອາທິດນີ້",
		"next": "ອາທິດໜ້າ",
		"past": "{0} ອທ. ກ່ອນ",
		"future": "ໃນອີກ {0} ອທ."
	],
	"day": [
		"previous": "ມື້ວານ",
		"current": "ມື້ນີ້",
		"next": "ມື້ອື່ນ",
		"past": "{0} ມື້ກ່ອນ",
		"future": "ໃນອີກ {0} ມື້"
	],
	"hour": [
		"current": "ຊົ່ວໂມງນີ້",
		"past": "{0} ຊມ. ກ່ອນ",
		"future": "ໃນອີກ {0} ຊມ."
	],
	"minute": [
		"current": "ນາທີນີ້",
		"past": "{0} ນທ. ກ່ອນ",
		"future": "ໃນ {0} ນທ."
	],
	"second": [
		"current": "ຕອນນີ້",
		"past": "{0} ວິ. ກ່ອນ",
		"future": "ໃນ {0} ວິ."
	],
	"now": "ຕອນນີ້"
]
	}

	private var _long: [String: Any] {
		return [
	"year": [
		"previous": "ປີກາຍ",
		"current": "ປີນີ້",
		"next": "ປີໜ້າ",
		"past": "{0} ປີກ່ອນ",
		"future": "ໃນອີກ {0} ປີ"
	],
	"quarter": [
		"previous": "ໄຕຣມາດກ່ອນໜ້າ",
		"current": "ໄຕຣມາດນີ້",
		"next": "ໄຕຣມາດໜ້າ",
		"past": "{0} ໄຕຣມາດກ່ອນ",
		"future": "ໃນອີກ {0} ໄຕຣມາດ"
	],
	"month": [
		"previous": "ເດືອນແລ້ວ",
		"current": "ເດືອນນີ້",
		"next": "ເດືອນໜ້າ",
		"past": "{0} ເດືອນກ່ອນ",
		"future": "ໃນອີກ {0} ເດືອນ"
	],
	"week": [
		"previous": "ອາທິດແລ້ວ",
		"current": "ອາທິດນີ້",
		"next": "ອາທິດໜ້າ",
		"past": "{0} ອາທິດກ່ອນ",
		"future": "ໃນອີກ {0} ອາທິດ"
	],
	"day": [
		"previous": "ມື້ວານ",
		"current": "ມື້ນີ້",
		"next": "ມື້ອື່ນ",
		"past": "{0} ມື້ກ່ອນ",
		"future": "ໃນອີກ {0} ມື້"
	],
	"hour": [
		"current": "ຊົ່ວໂມງນີ້",
		"past": "{0} ຊົ່ວໂມງກ່ອນ",
		"future": "ໃນອີກ {0} ຊົ່ວໂມງ"
	],
	"minute": [
		"current": "ນາທີນີ້",
		"past": "{0} ນາທີກ່ອນ",
		"future": "{0} ໃນອີກ 0 ນາທີ"
	],
	"second": [
		"current": "ຕອນນີ້",
		"past": "{0} ວິນາທີກ່ອນ",
		"future": "ໃນອີກ {0} ວິນາທີ"
	],
	"now": "ຕອນນີ້"
]
	}
}
