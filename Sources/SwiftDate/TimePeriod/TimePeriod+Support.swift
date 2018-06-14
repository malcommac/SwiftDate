//
//  TimePeriod+Support.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

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
	case none // One or more of the dates does not exist
}

public enum IntervalType {
	case open
	case closed
}
