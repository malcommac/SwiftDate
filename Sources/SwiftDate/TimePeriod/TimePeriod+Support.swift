//
//  TimePeriod+Support.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

/// There may come a need, say when you are making a scheduling app, when
/// it might be good to know how two time periods relate to one another
/// Are they the same? Is one inside of another?
/// All these questions may be asked using the relationship method of TimePeriod.
public enum TimePeriodRelation {
	case after
	case startTouching
	case startInside
	case insideStartTouching
	case enclosingStartTouching
	case enclosing
	case enclosingEndTouching
	case exactMatch
	case inside
	case insideEndTouching
	case endInside
	case endTouching
	case before
	case none
}

/// Whether the time period is Open or Closed
///
/// - open: The boundary moment of time is included in calculations.
/// - closed: The boundary moment of time represents a boundary value which is excluded in regard to calculations.
public enum IntervalType {
	case open
	case closed
}

/// When a time periods is lengthened or shortened, it does so anchoring one date
/// of the time period and then changing the other one. There is also an option to
/// anchor the centerpoint of the time period, changing both the start and end dates.
public enum TimePeriodAnchor {
	case beginning
	case center
	case end
}
