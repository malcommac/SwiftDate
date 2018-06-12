//
//  String.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public protocol DateParsable {
	
	func toDate(_ format: String, region: Region) -> DateInRegion?
	func toDate(from style: StringToDateStyles, region: Region) -> DateInRegion?
	func toDate(region: Region) -> DateInRegion?
	
}

extension String: DateParsable {
	
	public func toDate(_ format: String, region: Region = SwiftDate.defaultRegion) -> DateInRegion? {
		return DateInRegion.init(self, format: format, region: region)
	}
	
	public func toDate(from style: StringToDateStyles, region: Region = SwiftDate.defaultRegion) -> DateInRegion? {
		return style.toDate(self, region: region)
	}
	
	public func toDate(region: Region = SwiftDate.defaultRegion) -> DateInRegion? {
		return DateInRegion.init(self, format: nil, region: region)
	}
	
}
