//
//  DateInterval.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public struct DateSpan {

	public let start: Date
	
	public let duration: TimeInterval
	
	public var end: Date {
		return self.start.addingTimeInterval(duration)
	}
	
	public init(start: Date, duration: TimeInterval) {
		self.start = start
		self.duration = duration
	}
	
	public init(start: Date, end: Date) {
		self.start = start
		self.duration = (end.timeIntervalSince1970 - start.timeIntervalSince1970)
	}
}
