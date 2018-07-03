//
//  DateComponents+Int.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 07/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
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
	public var nanoseconds: DateComponents {
		return self.toDateComponents(type: .nanosecond)
	}

	/// Create a `DateComponents` with `self` value set as seconds
	public var seconds: DateComponents {
		return self.toDateComponents(type: .second)
	}

	/// Create a `DateComponents` with `self` value set as minutes
	public var minutes: DateComponents {
		return self.toDateComponents(type: .minute)
	}

	/// Create a `DateComponents` with `self` value set as hours
	public var hours: DateComponents {
		return self.toDateComponents(type: .hour)
	}

	/// Create a `DateComponents` with `self` value set as days
	public var days: DateComponents {
		return self.toDateComponents(type: .day)
	}

	/// Create a `DateComponents` with `self` value set as weeks
	public var weeks: DateComponents {
		return self.toDateComponents(type: .weekOfYear)
	}

	/// Create a `DateComponents` with `self` value set as months
	public var months: DateComponents {
		return self.toDateComponents(type: .month)
	}

	/// Create a `DateComponents` with `self` value set as years
	public var years: DateComponents {
		return self.toDateComponents(type: .year)
	}

	/// Create a `DateComponents` with `self` value set as quarters
	public var quarters: DateComponents {
		return self.toDateComponents(type: .quarter)
	}

}
