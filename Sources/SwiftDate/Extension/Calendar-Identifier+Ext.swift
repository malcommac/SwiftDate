//
//  SwiftDate
//  Toolkit to parse, validate, manipulate, compare and display dates, time & timezones in Swift.
//
//  Created by Daniele Margutti
//  Email: hello@danielemargutti.com
//  Web: http://www.danielemargutti.com
//
//  Copyright ©2022 Daniele Margutti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation

extension Calendar.Identifier: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .gregorian:
            return "gregorian"
        case .buddhist:
            return "buddhist"
        case .chinese:
            return "chinese"
        case .coptic:
            return "coptic"
        case .ethiopicAmeteMihret:
            return "ethiopicAmeteMihret"
        case .ethiopicAmeteAlem:
            return "ethiopicAmeteAlem"
        case .hebrew:
            return "hebrew"
        case .iso8601:
            return "iso8601"
        case .indian:
            return "indian"
        case .islamic:
            return "islamic"
        case .islamicCivil:
            return "islamicCivil"
        case .japanese:
            return "japanese"
        case .persian:
            return "persian"
        case .republicOfChina:
            return "republicOfChina"
        case .islamicTabular:
            return "islamicTabular"
        case .islamicUmmAlQura:
            return "islamicUmmAlQura"
        @unknown default:
            fatalError("Unknown: \(self)")
        }
    }
    
}
