//
//  Date+Math.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 11/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public extension Date {
	
	public func inLocalRegion() -> DateInRegion {
		return DateInRegion(absoluteDate: self)
	}
	
	public func inGMTRegion() -> DateInRegion {
		return DateInRegion(absoluteDate: self, in: Region.GMT())
	}
	
	public func inRegion(region: Region? = nil) -> DateInRegion {
		return DateInRegion(absoluteDate: self, in: region)
	}
	
	public func add(components: DateComponents) throws -> Date {
		let date: DateInRegion = try! self.inGMTRegion() + components
		return date.absoluteDate
	}
	
}

public func - (lhs: Date, rhs: DateComponents) -> Date {
	return lhs + (-rhs)
}

public func + (lhs: Date, rhs: DateComponents) -> Date {
	return try! lhs.add(components: rhs)
}

public func + (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(rhs)
}

public func - (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(-rhs)
}
