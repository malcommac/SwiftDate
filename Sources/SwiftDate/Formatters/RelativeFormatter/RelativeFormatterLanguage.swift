//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import Foundation

internal class RelativeFormatterLanguagesCache {

    static let shared = RelativeFormatterLanguagesCache()

    private(set) var cachedValues = [String: [String: Any]]()

    func flavoursForLocaleID(_ langID: String) -> [String: Any]? {
        do {
            guard let fullURL = Bundle(for: RelativeFormatter.self).resourceURL?.appendingPathComponent("langs/\(langID).json") else {
                return nil
            }
            let data = try Data(contentsOf: fullURL)
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)

            if let value = json as? [String: Any] {
                cachedValues[langID] = value
                return value
            } else {
                return nil
            }

        } catch {
            debugPrint("Failed to read data for language id: \(langID)")
            return nil
        }
    }
}

public enum RelativeFormatterLanguage: String, CaseIterable {
    case af = "af" // Locales.afrikaans
    case am = "am" // Locales.amharic
    case ar_AE = "ar_AE" // Locales.arabicUnitedArabEmirates
    case ar = "ar" // Locales.arabic
    case `as` = "as" // Locales.assamese
    case az = "az" // Locales.assamese
    case be = "be" // Locales.belarusian
    case bg = "bg" // Locales.bulgarian
    case bn = "bn" // Locales.bengali
    case br = "br" // Locales.breton
    case bs = "bs" // Locales.bosnian
    case bs_Cyrl = "bs-Cyrl" // Locales.belarusian
    case ca = "ca" // Locales.catalan
    case cz = "cz" // Locales.czech
    case cy = "cy" // Locales.welsh
    case cs = "cs" // Locales.czech
    case da = "da" // Locales.danish
    case de = "de" // Locales.dutch
    case dsb = "dsb" // Locales.lowerSorbian
    case dz = "dz" // Locales.dzongkha
    case ee = "ee" // Locales.ewe
    case el = "el" // Locales.greek
    case en = "en" // Locales.english
    case es_AR = "es_AR" // Locales.spanishArgentina
    case es_PY = "es_PY" // Locales.spanishParaguay
    case es_MX = "es_MX" // Locales.spanishMexico
    case es_US = "es_US" // Locales.spanishUnitedStates
    case es = "es" // Locales.spanish
    case et = "et" // Locales.estonian
    case eu = "eu" // Locales.basque
    case fa = "fa" // Locales.persian
    case fi = "fi" // Locales.finnish
    case fil = "fil" // Locales.filipino
    case fo = "fo" // Locales.faroese
    case fr_CA = "fr_CA" // French (Canada)
    case fr = "fr" // French
    case fur = "fur" // Friulian
    case fy = "fy" // Western Frisian
    case ga = "ga" // Irish
    case gd = "gd" // Scottish Gaelic
    case gl = "gl" // Galician
    case gu = "gu" // Gujarati
    case he = "he" // Hebrew
    case hi = "hi" // Hindi
    case hr = "hr" // Croatian
    case hsb = "hsb" // Upper Sorbian
    case hu = "hu" // Hungarian
    case hy = "hy" // Armenian
    case id = "id" // Indonesian
    case `is` = "is" // Icelandic
    case it = "it" // Locales.italian
    case ja = "ja" // Japanese
    case jgo = "jgo" // Ngomba
    case ka = "ka" // Georgian
    case kea = "kea" // Kabuverdianu
    case kk = "kk" // Kazakh
    case kl = "kl" // Kalaallisut
    case km = "km" // Khmer
    case kn = "kn" // Kannada
    case ko = "ko" // Korean
    case kok = "kok" // Konkani
    case ksh = "ksh" // Colognian
    case ky = "ky" // Kyrgyz
    case lb = "lb" // Luxembourgish
    case lkt = "lkt" // Lakota
    case lo = "lo" // Lao
    case lt = "lt" // Lithuanian
    case lv = "lv" // Latvian
    case mk = "mk" // Macedonian
    case ml = "ml" // Malayalam
    case mn = "mn" // Mongolian
    case mr = "mr" // Marathi
    case ms = "ms" // Malay
    case mt = "mt" // Maltese
    case my = "my" // Burmese
    case mzn = "mzn" // Mazanderani
    case nb = "nb" // Norwegian Bokmål
    case ne = "ne" // Nepali
    case nl = "nl" // Netherland
    case nn = "nn" // Norwegian Nynorsk
    case or = "or" // Odia
    case pa = "pa" // Punjabi
    case pl = "pl" // Polish
    case ps = "ps" // Pashto
    case pt = "pt" // Portuguese
    case ro = "ro" // Romanian
    case ru = "ru" // Russian
    case sah = "sah" // Sakha
    case sd = "sd" // Sindhi
    case se_FI = "se_FI" // Northern Sami (Finland)
    case se = "se" // Northern Sami
    case si = "si" // Sinhala
    case sk = "sk" // Slovak
    case sl = "sl" // Slovenian
    case sq = "sq" // Albanian
    case sr_Latn = "sr_Latn" // Serbian (Latin)
    case sr = "sr" // Serbian
    case sv = "sv" // Swedish
    case sw = "sw" // Swedish
    case ta = "ta" // Tamil
    case te = "te" // Telugu
    case th = "th" // Thai
    case ti = "ti" // Tigrinya
    case tk = "tk" // Turkmen
    case to = "to" // Tongan
    case tr = "tr" // Turkish
    case ug = "ug" // Uyghur
    case uk = "uk" // Ukrainian
    case ur_IN = "ur_IN" // Urdu (India)
    case ur = "ur" // Urdu
    case uz_Cyrl = "uz_Cyrl" // Uzbek (Cyrillic)
    case uz = "uz" // Uzbek (Cyrillic)
    case vi = "vi" // Vietnamese
    case wae = "wae" // Walser
    case yue_Hans = "yue_Hans" // Cantonese (Simplified)
    case yue_Hant = "yue_Hant" // Cantonese (Traditional)
    case zh_Hans_HK = "zh_Hans_HK" // Chinese (Simplified, Hong Kong [China])
    case zh_Hans_MO = "zh_Hans_MO" // Chinese (Simplified, Macau [China])
    case zh_Hans_SG = "zh_Hans_SG" // Chinese (Simplified, Singapore)
    case zh_Hant_HK = "zh_Hant_HK" // Chinese (Traditional, Hong Kong [China])
    case zh_Hant_MO = "zh_Hant_MO" // Chinese (Traditional, Macau [China])
    case zh_Hans = "zh_Hans" // Chinese (Simplified)
    case zh_Hant = "zh_Hant" // Chinese (Traditional)
    case zh = "zh" // Chinese
    case zu = "zu" // Zulu

    /// Table with the data of the language.
    /// Data is structured in:
    /// { flavour: { unit : { data } } }
    public var flavours: [String: Any] {
        return RelativeFormatterLanguagesCache.shared.flavoursForLocaleID(self.rawValue) ?? [:]
    }

    public var identifier: String {
        return self.rawValue
    }

    public func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm? {
        switch self {

        case .sr_Latn, .sr, .uk:
            let mod10 = Int(value) % 10
            let mod100 = Int(value) % 100

            switch mod10 {
            case 1:
                switch mod100 {
                case 11:
                    break
                default:
                    return .one
                }
            case 2, 3, 4:
                switch mod100 {
                case 12, 13, 14:
                    break
                default:
                    return .few
                }
            default:
                break
            }

            return .many

        case .ru, .sk, .sl:
            let mod10 = Int(value) % 10
            let mod100 = Int(value) % 100

            switch mod100 {
            case 11...14:
                break

            default:
                switch mod10 {
                case 1:
                    return .one
                case 2...4:
                    return .few
                default:
                    break
                }

            }
            return .many

        case .ro:
            let mod100 = Int(value) % 100

            switch value {
            case 0:
                return .few
            case 1:
                return .one
            default:
                if mod100 > 1 && mod100 <= 19 {
                    return .few
                }
            }

            return .other

        case .pa:
            switch value {
            case 0, 1:
                return .one
            default:
                return .other
            }

        case .mt:
            switch value {
            case 1: return .one
            case 0: return .few
            case 2...10: return .few
            case 11...19: return .many
            default: return .other
            }

        case .lt, .lv:
            let mod10 = Int(value) % 10
            let mod100 = Int(value) % 100

            if value == 0 {
                return .zero
            }

            if value == 1 {
                return .one
            }

            switch mod10 {
            case 1:
                if mod100 != 11 {
                    return .one
                }
                return .many
            default:
                return .many
            }

        case .ksh, .se:
            switch value {
            case 0: return .zero
            case 1: return .one
            default: return .other
            }

        case .`is`:
            let mod10 = Int(value) % 10
            let mod100 = Int(value) % 100

            if value == 0 {
                return .zero
            }

            if value == 1 {
                return .one
            }

            switch mod10 {
            case 1:
                if mod100 != 11 {
                    return .one
                }
            default:
                break
            }

            return .many

        case .id, .ja, .ms, .my, .mzn, .sah, .se_FI, .si, .th, .yue_Hans, .yue_Hant,
             .zh_Hans_HK, .zh_Hans_MO, .zh_Hans_SG, .zh_Hant_HK, .zh_Hant_MO, .zh:

            return .other

        case .hy:
            return (value >= 0 && value < 2 ? .one : .other)

        case .ga, .gd:
            switch Int(value) {
            case 1: return .one
            case 2: return .two
            case 3...6: return .few
            case 7...10: return .many
            default: return .other
            }

        case .fr_CA, .fr:
            return (value >= 0 && value < 2 ? .one : .other)

        case .dz, .kea, .ko, .kok, .lkt, .lo:
            return nil

        case .cs: // Locales.czech
            switch value {
            case 1:
                return .one
            case 2, 3, 4:
                return .few
            default:
                return .other
            }

        case .cy:
            switch value {
            case 0:    return .zero
            case 1: return .one
            case 2: return .two
            case 3: return .few
            case 6: return .many
            default: return .other
            }

        case .cz, .dsb:
            switch value {
            case 1:
                return .one
            case 2, 3, 4:
                return .few
            default:
                return .other
            }

        case .br:
            let n = Int(value)
            return n % 10 == 1 && n % 100 != 11 && n % 100 != 71 && n % 100 != 91 ? .zero : n % 10 == 2 && n % 100 != 12 && n % 100 != 72 && n % 100 != 92 ? .one : (n % 10 == 3 || n % 10 == 4 || n % 10 == 9) && n % 100 != 13 && n % 100 != 14 && n % 100 != 19 && n % 100 != 73 && n % 100 != 74 && n % 100 != 79 && n % 100 != 93 && n % 100 != 94 && n % 100 != 99 ? .two : n % 1_000_000 == 0 && n != 0 ? .many : .other

        case .be, .bs, .bs_Cyrl, .hr, .hsb, .pl:
            let mod10 = Int(value) % 10
            let mod100 = Int(value) % 100

            switch mod10 {
            case 1:
                switch mod100 {
                case 11:
                    break
                default:
                    return .one
                }
            case 2, 3, 4:
                switch mod100 {
                case 12, 13, 14:
                    break
                default:
                    return .few
                }
            default:
                break
            }
            return .many

        case .ar, .ar_AE, .he:
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

        case .am, .bn, .fa, .gu, .kn, .mr, .zu:
            return (value >= 0 && value <= 1 ? .one : .other)

        default:
            return (value == 1 ? .one : .other)

        }
    }

}
