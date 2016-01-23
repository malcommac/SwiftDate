//
//  main.swift
//  time-zone-gen
//
//  Created by Jeroen Houtzager on 26/12/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Foundation


extension String {
    func toCamelCase() -> String {
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z]+", options: .CaseInsensitive)
        let range = NSMakeRange(0, self.characters.count)
        return regex.stringByReplacingMatchesInString(self.capitalizedString, options: [], range: range, withTemplate: "")
    }
}

// Create an array of time zone names in camelCase
var localeIdentifiers = NSLocale.availableLocaleIdentifiers().sort()

// print intro
print(" ")
print("public enum LocaleIdentifier: String {")
print(" ")
print("    public var description: String {")
print("        return self.rawValue")
print("    }")
print(" ")
print("    public var locale : NSLocale {")
print("        switch self {")
print("        case .Current:")
print("            return NSLocale.currentLocale()")
print("        case .System:")
print("            return NSLocale.systemLocale()")
print("        default:")
print("            return NSLocale(localeIdentifier: self.rawValue)!")
print("        }")
print("    }")
print(" ")
print("    case Current = \"Current\"")
print("    case System = \"System\"")
print(" ")

let englishLocale = NSLocale(localeIdentifier: "en_US")

var names = Dictionary<String,String>()

for localeID in localeIdentifiers {
    
    let locale = NSLocale(localeIdentifier: localeID)
    if let name = englishLocale.displayNameForKey(NSLocaleIdentifier, value: locale.objectForKey(NSLocaleIdentifier) as? String ?? localeID) {
        names[name] = localeID
    } else {
        print("// [\(localeID)] NOT available")
    }
}

let sortedNames = names.keys.sort { $0 < $1 }

for key in sortedNames {
    print("    case \(key.toCamelCase()) = \"\(names[key]!)\"")
}

print("}")
