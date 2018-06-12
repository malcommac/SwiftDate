//
//  i18n.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 08/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

// https://developer.mozilla.org/en-US/docs/Mozilla/Localization/Localization_and_Plurals
// http://unicode.org/repos/cldr-tmp/trunk/diff/supplemental/language_plural_rules.html
// http://localization-guide.readthedocs.org/en/latest/l10n/pluralforms.html

import Foundation

public typealias LocalizableJSON = [String: Any]

public protocol LocalizableFileProtocol: class {
	var data: LocalizableJSON { get }
	var code: String { get }
	
	init()
	
	func get(key: String) -> String?
}

public extension LocalizableFileProtocol {
	
	public func get(key: String) -> String? {
		return self.data[key] as? String
	}
}

public enum i18nLangs: String {
	case en_US = "en_US"
}

internal extension Locale {
	
	var i18nCode: i18nLangs {
		guard let languageCode = self.languageCode else { return .en_US }
		let identifier = "\(languageCode)-\(languageCode.uppercased())"
		guard let lang = i18nLangs(rawValue: identifier) else {
			guard let alt_lang = i18nLangs(rawValue: languageCode) else {
				return .en_US
			}
			return alt_lang
		}
		return lang
	}
	
}

public class i18n {
	
	public static let shared: i18n = i18n()
	
	private var cache: [i18nLangs: LocalizableFileProtocol] = [:]
	private var langMap: [i18nLangs : LocalizableFileProtocol.Type] = [:]
	
	public var locale: Locale = Locale.current
	
	private init() {
		initBuiltInLanguages()
	}
	
	public func initBuiltInLanguages() {
		self.langMap = [
			.en_US : lang_en.self
		]
	}
	

	public func localize(_ key: String, lang: i18nLangs? = nil, arguments: CVarArg...) -> String? {
		let language = (lang ?? self.locale.i18nCode)
		guard let table = self.table(forLang: language) else {
			debugPrint("No table found for \(String(describing: lang))")
			return nil
		}
		guard let translatedKey = table.get(key: key) else { return nil }
		return String(format: translatedKey, arguments: arguments)
	}
	
	/// Get the table for specified language.
	/// Table are cached internally and can be replaced by user own versions at anytime.
	///
	/// - Parameters:
	///   - lang: languages to retrive.
	///   - fallbackLang: fallback language if requested one were not found.
	/// - Returns: table instance, `nil` if not found
	private func table(forLang lang: i18nLangs, fallbackLang: i18nLangs = .en_US) -> LocalizableFileProtocol? {
		guard let tableInstance = self.cache[lang] else {
			// there is not any cached table
			guard let fileType = self.langMap[lang] else {
				// there is no reference to this table
				debugPrint("Language table \(lang) not found. Returning fallback \(fallbackLang)")
				return self.cache[fallbackLang]
			}
			self.cache[lang] = fileType.init()
			return self.cache[lang]
		}
		return tableInstance // cached table
	}
}
