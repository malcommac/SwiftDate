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

import SwiftDate
import XCTest

class TestDateInRegion_Langs: XCTestCase {

	public func testLanguages() {

		RelativeFormatter.allLanguages.forEach { lang in
			XCTAssert((lang.identifier.isEmpty == false), "Language \(lang.identifier) has not a valid identifier")
			lang.flavours.forEach({ (key, value) in
				if RelativeFormatter.Flavour(rawValue: key) == nil {
					XCTFail("Flavour '\(key)' is not supported by the library (lang '\(lang.identifier)')")
					return
				}
				guard let flavourDict = value as? [String: Any] else {
					XCTFail("Flavour dictionary '\(key)' is not a valid dictionary")
					return
				}
				flavourDict.keys.forEach({ rawTimeUnit in
					if RelativeFormatter.Unit(rawValue: rawTimeUnit) == nil {
						XCTFail("Time unit '\(rawTimeUnit)' in lang \(key) is not a valid")
						return
					}
				})
			})
		}
	}

    public func testValues() {
        let ago5Mins = DateInRegion() - 5.minutes
        let value1 = ago5Mins.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.italian) // "5 minuti fa"
        XCTAssert(value1 == "5 minuti fa", "Failed to get relative date in default style")

        let justNow2 = DateInRegion() - 2.hours
        let value2 = justNow2.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian) // "2h fa"
        XCTAssert(value2 == "2h fa", "Failed to get relative date in twitter style")

        let justNow = DateInRegion() - 10.seconds
        let value3 = justNow.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian) // "ora"
        XCTAssert(value3 == "ora", "Failed to get relative date in twitter style")

        let value4 = justNow.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.english) // "now"
        XCTAssert(value4 == "now", "Failed to get relative date in twitter style")

    }

}
