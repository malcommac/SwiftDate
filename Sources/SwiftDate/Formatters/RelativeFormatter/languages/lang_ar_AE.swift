//
//  lang_arAE.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// swiftlint:disable type_name// swiftlint:disable type_name
public class lang_arAE: RelativeFormatterLang {

	/// Locales.arabicUnitedArabEmirates
	public static let identifier: String = "ar_AE"

	public required init() {}

	public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
		switch value {
		case 0: return .zero
		case 1: return .one
		case 2: return .two
		default:
			let mod100 = Int(value) % 100
			if mod100 >= 3 && mod100 <= 10 {
				return .few
			} else if mod100 >= 11 {
				return .many
			} else {
				return .other
			}
		}
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
				"previous": "السنة الماضية",
				"current": "هذه السنة",
				"next": "السنة التالية",
				"past": [
					"one": "قبل سنة واحدة",
					"two": "قبل سنتين",
					"few": "قبل {0} سنوات",
					"other": "قبل {0} سنة"
				],
				"future": [
					"one": "خلال سنة واحدة",
					"two": "خلال سنتين",
					"few": "خلال {0} سنوات",
					"other": "خلال {0} سنة"
				]
			],
			"quarter": [
				"previous": "الربع الأخير",
				"current": "هذا الربع",
				"next": "الربع القادم",
				"past": [
					"one": "قبل ربع سنة واحد",
					"two": "قبل ربعي سنة",
					"few": "قبل {0} أرباع سنة",
					"other": "قبل {0} ربع سنة"
				],
				"future": [
					"one": "خلال ربع سنة واحد",
					"two": "خلال ربعي سنة",
					"few": "خلال {0} أرباع سنة",
					"other": "خلال {0} ربع سنة"
				]
			],
			"month": [
				"previous": "الشهر الماضي",
				"current": "هذا الشهر",
				"next": "الشهر القادم",
				"past": [
					"one": "قبل شهر واحد",
					"two": "قبل شهرين",
					"few": "خلال {0} أشهر",
					"many": "قبل {0} شهرًا",
					"other": "قبل {0} شهر"
				],
				"future": [
					"one": "خلال شهر واحد",
					"two": "خلال شهرين",
					"few": "خلال {0} أشهر",
					"many": "خلال {0} شهرًا",
					"other": "خلال {0} شهر"
				]
			],
			"week": [
				"previous": "الأسبوع الماضي",
				"current": "هذا الأسبوع",
				"next": "الأسبوع القادم",
				"past": [
					"one": "قبل أسبوع واحد",
					"two": "قبل أسبوعين",
					"few": "قبل {0} أسابيع",
					"many": "قبل {0} أسبوعًا",
					"other": "قبل {0} أسبوع"
				],
				"future": [
					"one": "خلال أسبوع واحد",
					"two": "خلال {0} أسبوعين",
					"few": "خلال {0} أسابيع",
					"many": "خلال {0} أسبوعًا",
					"other": "خلال {0} أسبوع"
				]
			],
			"day": [
				"previous": "أمس",
				"current": "اليوم",
				"next": "غدًا",
				"past": [
					"one": "قبل يوم واحد",
					"two": "قبل يومين",
					"few": "قبل {0} أيام",
					"many": "قبل {0} يومًا",
					"other": "قبل {0} يوم"
				],
				"future": [
					"one": "خلال يوم واحد",
					"two": "خلال يومين",
					"few": "خلال {0} أيام",
					"many": "خلال {0} يومًا",
					"other": "خلال {0} يوم"
				]
			],
			"hour": [
				"current": "الساعة الحالية",
				"past": [
					"one": "قبل ساعة واحدة",
					"two": "قبل ساعتين",
					"few": "قبل {0} ساعات",
					"other": "قبل {0} ساعة"
				],
				"future": [
					"one": "خلال ساعة واحدة",
					"two": "خلال ساعتين",
					"few": "خلال {0} ساعات",
					"other": "خلال {0} ساعة"
				]
			],
			"minute": [
				"current": "هذه الدقيقة",
				"past": [
					"one": "قبل دقيقة واحدة",
					"two": "قبل دقيقتين",
					"few": "قبل {0} دقائق",
					"other": "قبل {0} دقيقة"
				],
				"future": [
					"one": "خلال دقيقة واحدة",
					"two": "خلال دقيقتين",
					"few": "خلال {0} دقائق",
					"other": "خلال {0} دقيقة"
				]
			],
			"second": [
				"current": "الآن",
				"past": [
					"one": "قبل ثانية واحدة",
					"two": "قبل ثانيتين",
					"few": "قبل {0} ثوانٍ",
					"other": "قبل {0} ثانية"
				],
				"future": [
					"one": "خلال ثانية واحدة",
					"two": "خلال ثانيتين",
					"few": "خلال {0} ثوانٍ",
					"other": "خلال {0} ثانية"
				]
			],
			"now": "الآن"
		]
	}

	private var _narrow: [String: Any] {
		return [
			"year": [
				"previous": "السنة الماضية",
				"current": "هذه السنة",
				"next": "السنة التالية",
				"past": [
					"one": "قبل سنة واحدة",
					"two": "قبل سنتين",
					"few": "قبل {0} سنوات",
					"other": "قبل {0} سنة"
				],
				"future": [
					"one": "خلال سنة واحدة",
					"two": "خلال سنتين",
					"few": "خلال {0} سنوات",
					"other": "خلال {0} سنة"
				]
			],
			"quarter": [
				"previous": "الربع الأخير",
				"current": "هذا الربع",
				"next": "الربع القادم",
				"past": [
					"one": "قبل ربع سنة واحد",
					"two": "قبل ربعي سنة",
					"few": "قبل {0} أرباع سنة",
					"other": "قبل {0} ربع سنة"
				],
				"future": [
					"one": "خلال ربع سنة واحد",
					"two": "خلال ربعي سنة",
					"few": "خلال {0} أرباع سنة",
					"other": "خلال {0} ربع سنة"
				]
			],
			"month": [
				"previous": "الشهر الماضي",
				"current": "هذا الشهر",
				"next": "الشهر القادم",
				"past": [
					"one": "قبل شهر واحد",
					"two": "قبل شهرين",
					"few": "قبل {0} أشهر",
					"many": "قبل {0} شهرًا",
					"other": "قبل {0} شهر"
				],
				"future": [
					"one": "خلال شهر واحد",
					"two": "خلال شهرين",
					"few": "خلال {0} أشهر",
					"many": "خلال {0} شهرًا",
					"other": "خلال {0} شهر"
				]
			],
			"week": [
				"previous": "الأسبوع الماضي",
				"current": "هذا الأسبوع",
				"next": "الأسبوع القادم",
				"past": [
					"one": "قبل أسبوع واحد",
					"two": "قبل أسبوعين",
					"few": "قبل {0} أسابيع",
					"many": "قبل {0} أسبوعًا",
					"other": "قبل {0} أسبوع"
				],
				"future": [
					"one": "خلال أسبوع واحد",
					"two": "خلال أسبوعين",
					"few": "خلال {0} أسابيع",
					"many": "خلال {0} أسبوعًا",
					"other": "خلال {0} أسبوع"
				]
			],
			"day": [
				"previous": "أمس",
				"current": "اليوم",
				"next": "غدًا",
				"past": [
					"one": "قبل يوم واحد",
					"two": "قبل يومين",
					"few": "قبل {0} أيام",
					"many": "قبل {0} يومًا",
					"other": "قبل {0} يوم"
				],
				"future": [
					"one": "خلال يوم واحد",
					"two": "خلال يومين",
					"few": "خلال {0} أيام",
					"many": "خلال {0} يومًا",
					"other": "خلال {0} يوم"
				]
			],
			"hour": [
				"current": "الساعة الحالية",
				"past": [
					"one": "قبل ساعة واحدة",
					"two": "قبل ساعتين",
					"few": "قبل {0} ساعات",
					"other": "قبل {0} ساعة"
				],
				"future": [
					"one": "خلال ساعة واحدة",
					"two": "خلال ساعتين",
					"few": "خلال {0} ساعات",
					"other": "خلال {0} ساعة"
				]
			],
			"minute": [
				"current": "هذه الدقيقة",
				"past": [
					"one": "قبل دقيقة واحدة",
					"two": "قبل دقيقتين",
					"few": "قبل {0} دقائق",
					"other": "قبل {0} دقيقة"
				],
				"future": [
					"one": "خلال دقيقة واحدة",
					"two": "خلال دقيقتين",
					"few": "خلال {0} دقائق",
					"other": "خلال {0} دقيقة"
				]
			],
			"second": [
				"current": "الآن",
				"past": [
					"one": "قبل ثانية واحدة",
					"two": "قبل ثانيتين",
					"few": "قبل {0} ثوانٍ",
					"other": "قبل {0} ثانية"
				],
				"future": [
					"one": "خلال ثانية واحدة",
					"two": "خلال ثانيتين",
					"few": "خلال {0} ثوانٍ",
					"other": "خلال {0} ثانية"
				]
			],
			"now": "الآن"
		]
	}

	private var _long: [String: Any] {
		return [
			"year": [
				"previous": "السنة الماضية",
				"current": "هذه السنة",
				"next": "السنة التالية",
				"past": [
					"one": "قبل سنة واحدة",
					"two": "قبل سنتين",
					"few": "قبل {0} سنوات",
					"other": "قبل {0} سنة"
				],
				"future": [
					"one": "خلال سنة واحدة",
					"two": "خلال سنتين",
					"few": "خلال {0} سنوات",
					"other": "خلال {0} سنة"
				]
			],
			"quarter": [
				"previous": "الربع الأخير",
				"current": "هذا الربع",
				"next": "الربع القادم",
				"past": [
					"one": "قبل ربع سنة واحد",
					"two": "قبل ربعي سنة",
					"few": "قبل {0} أرباع سنة",
					"other": "قبل {0} ربع سنة"
				],
				"future": [
					"one": "خلال ربع سنة واحد",
					"two": "خلال ربعي سنة",
					"few": "خلال {0} أرباع سنة",
					"other": "خلال {0} ربع سنة"
				]
			],
			"month": [
				"previous": "الشهر الماضي",
				"current": "هذا الشهر",
				"next": "الشهر القادم",
				"past": [
					"one": "قبل شهر واحد",
					"two": "قبل شهرين",
					"few": "قبل {0} أشهر",
					"many": "قبل {0} شهرًا",
					"other": "قبل {0} شهر"
				],
				"future": [
					"one": "خلال شهر واحد",
					"two": "خلال شهرين",
					"few": "خلال {0} أشهر",
					"many": "خلال {0} شهرًا",
					"other": "خلال {0} شهر"
				]
			],
			"week": [
				"previous": "الأسبوع الماضي",
				"current": "هذا الأسبوع",
				"next": "الأسبوع القادم",
				"past": [
					"one": "قبل أسبوع واحد",
					"two": "قبل أسبوعين",
					"few": "قبل {0} أسابيع",
					"many": "قبل {0} أسبوعًا",
					"other": "قبل {0} أسبوع"
				],
				"future": [
					"one": "خلال أسبوع واحد",
					"two": "خلال أسبوعين",
					"few": "خلال {0} أسابيع",
					"many": "خلال {0} أسبوعًا",
					"other": "خلال {0} أسبوع"
				]
			],
			"day": [
				"previous": "أمس",
				"current": "اليوم",
				"next": "غدًا",
				"past": [
					"one": "قبل يوم واحد",
					"two": "قبل يومين",
					"few": "قبل {0} أيام",
					"many": "قبل {0} يومًا",
					"other": "قبل {0} يوم"
				],
				"future": [
					"one": "خلال يوم واحد",
					"two": "خلال يومين",
					"few": "خلال {0} أيام",
					"many": "خلال {0} يومًا",
					"other": "خلال {0} يوم"
				]
			],
			"hour": [
				"current": "الساعة الحالية",
				"past": [
					"one": "قبل ساعة واحدة",
					"two": "قبل ساعتين",
					"few": "قبل {0} ساعات",
					"other": "قبل {0} ساعة"
				],
				"future": [
					"one": "خلال ساعة واحدة",
					"two": "خلال ساعتين",
					"few": "خلال {0} ساعات",
					"other": "خلال {0} ساعة"
				]
			],
			"minute": [
				"current": "هذه الدقيقة",
				"past": [
					"one": "قبل دقيقة واحدة",
					"two": "قبل دقيقتين",
					"few": "قبل {0} دقائق",
					"other": "قبل {0} دقيقة"
				],
				"future": [
					"one": "خلال دقيقة واحدة",
					"two": "خلال دقيقتين",
					"few": "خلال {0} دقائق",
					"other": "خلال {0} دقيقة"
				]
			],
			"second": [
				"current": "الآن",
				"past": [
					"one": "قبل ثانية واحدة",
					"two": "قبل ثانيتين",
					"few": "قبل {0} ثوانِ",
					"other": "قبل {0} ثانية"
				],
				"future": [
					"one": "خلال ثانية واحدة",
					"two": "خلال ثانيتين",
					"few": "خلال {0} ثوانٍ",
					"other": "خلال {0} ثانية"
				]
			],
			"now": "الآن"
		]
	}
}
