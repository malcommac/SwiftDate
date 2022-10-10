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

// MARK: Int Extension

/// This allows us to transform a literal number in a `DateComponents` and use it in math operations
/// For example `5.days` will create a new `DateComponents` where `.day = 5`.

public extension Int {

	/// Internal transformation function
	///
	/// - parameter type: component to use
	///
	/// - returns: return self value in form of `DateComponents` where given `Calendar.Component` has `self` as value
	internal func toDateComponents(type: Calendar.Component) -> DateComponents {
		var dateComponents = DateComponents()
        DateComponents.allComponents.forEach( { dateComponents.setValue(0, for: $0 )})
        dateComponents.setValue(self, for: type)
        dateComponents.setValue(0, for: .era)
		return dateComponents
	}

	/// Create a `DateComponents` with `self` value set as nanoseconds
	var nanoseconds: DateComponents {
        toDateComponents(type: .nanosecond)
	}

	/// Create a `DateComponents` with `self` value set as seconds
	var seconds: DateComponents {
        toDateComponents(type: .second)
	}

	/// Create a `DateComponents` with `self` value set as minutes
	var minutes: DateComponents {
        toDateComponents(type: .minute)
	}

	/// Create a `DateComponents` with `self` value set as hours
	var hours: DateComponents {
        toDateComponents(type: .hour)
	}

	/// Create a `DateComponents` with `self` value set as days
	var days: DateComponents {
        toDateComponents(type: .day)
	}

	/// Create a `DateComponents` with `self` value set as weeks
	var weeks: DateComponents {
        toDateComponents(type: .weekOfYear)
	}

	/// Create a `DateComponents` with `self` value set as months
	var months: DateComponents {
        toDateComponents(type: .month)
	}

	/// Create a `DateComponents` with `self` value set as years
	var years: DateComponents {
        toDateComponents(type: .year)
	}

	/// Create a `DateComponents` with `self` value set as quarters
	var quarters: DateComponents {
        toDateComponents(type: .quarter)
	}

}
