//
//  Date+Math.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 07/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
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

public func - (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(-rhs)
}
