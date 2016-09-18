//
//  DateComponents.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 15/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public extension DateComponents {
	
	public func from(date: Date, in region: Region? = nil) -> Date? {
		let srcRegion = region ?? Region.GMT()
		return srcRegion.calendar.date(byAdding: self, to: date)
	}
	
	public func from(dateInRegion: DateInRegion) -> DateInRegion? {
		guard let absDate = dateInRegion.region.calendar.date(byAdding: self, to: dateInRegion.absoluteDate) else {
			return nil
		}
		let newDateInRegion = DateInRegion(absoluteDate: absDate, in: dateInRegion.region.copy())
		return newDateInRegion
	}
	
	public func ago(from date: Date, in region: Region? = nil) -> Date? {
		let srcRegion = region ?? Region.GMT()
		return srcRegion.calendar.date(byAdding: -self, to: date)
	}
	
	public func ago(fromDateInRegion date: DateInRegion) -> DateInRegion? {
		guard let absDate = date.region.calendar.date(byAdding: -self, to: date.absoluteDate) else {
			return nil
		}
		let newDateInRegion = DateInRegion(absoluteDate: absDate, in: date.region.copy())
		return newDateInRegion
	}
	
	public func fromNow(in region: Region? = nil) -> Date? {
		return self.from(date: Date(), in: region)
	}
	
	public func ago(in region: Region? = nil) -> Date? {
		return self.ago(from: Date(), in: region)
	}
	
	
}
