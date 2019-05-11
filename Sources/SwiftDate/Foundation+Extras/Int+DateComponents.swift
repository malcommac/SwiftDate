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
		dateComponents.setValue(self, for: type)
		return dateComponents
	}

	/// Create a `DateComponents` with `self` value set as nanoseconds
	var nanoseconds: DateComponents {
		return toDateComponents(type: .nanosecond)
	}

	/// Create a `DateComponents` with `self` value set as seconds
	var seconds: DateComponents {
		return toDateComponents(type: .second)
	}

	/// Create a `DateComponents` with `self` value set as minutes
	var minutes: DateComponents {
		return toDateComponents(type: .minute)
	}

	/// Create a `DateComponents` with `self` value set as hours
	var hours: DateComponents {
		return toDateComponents(type: .hour)
	}

	/// Create a `DateComponents` with `self` value set as days
	var days: DateComponents {
		return toDateComponents(type: .day)
	}

	/// Create a `DateComponents` with `self` value set as weeks
	var weeks: DateComponents {
		return toDateComponents(type: .weekOfYear)
	}

	/// Create a `DateComponents` with `self` value set as months
	var months: DateComponents {
		return toDateComponents(type: .month)
	}

	/// Create a `DateComponents` with `self` value set as years
	var years: DateComponents {
		return toDateComponents(type: .year)
	}

	/// Create a `DateComponents` with `self` value set as quarters
	var quarters: DateComponents {
		return toDateComponents(type: .quarter)
	}

}
