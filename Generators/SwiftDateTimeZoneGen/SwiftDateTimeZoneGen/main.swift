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
var timeZoneNames = NSTimeZone.knownTimeZoneNames().sort()

// Add custom time zones
timeZoneNames.append("Local")
timeZoneNames.append("System")
timeZoneNames.append("Default")

var level = 0

// print intro
print(" ")
print("public enum TimeZoneName: String {")
print(" ")
print("    public var description: String {")
print("        return self.rawValue")
print("    }")
print(" ")
print("    public var timeZone : NSTimeZone {")
print("        switch self {")
print("        case .Local:")
print("            return NSTimeZone.localTimeZone()")
print("        case .Default:")
print("            return NSTimeZone.defaultTimeZone()")
print("        case .System:")
print("            return NSTimeZone.systemTimeZone()")
print("        default:")
print("            return NSTimeZone(name: self.rawValue)!")
print("        }")
print("    }")
print(" ")


for index in timeZoneNames.indices {
    
    let name = timeZoneNames[index]
    
    print("case \(name.toCamelCase()) = \"\(name)\"")

}

print("}")
