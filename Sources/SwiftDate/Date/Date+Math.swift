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

/// Subtracts two dates and returns the relative components from `lhs` to `rhs`.
/// Follows this mathematical pattern:
///     let difference = lhs - rhs
///     rhs + difference = lhs
public func - (lhs: Date, rhs: Date) -> DateComponents {
	return SwiftDate.defaultRegion.calendar.dateComponents(DateComponents.allComponentsSet, from: rhs, to: lhs)
}

/// Adds date components to a date and returns a new date.
public func + (lhs: Date, rhs: DateComponents) -> Date {
	return rhs.from(lhs)!
}

/// Adds date components to a date and returns a new date.
public func + (lhs: DateComponents, rhs: Date) -> Date {
	return (rhs + lhs)
}

/// Subtracts date components from a date and returns a new date.
public func - (lhs: Date, rhs: DateComponents) -> Date {
	return (lhs + (-rhs))
}

public func + (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(rhs)
}
