//
//  String.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public protocol DateParsable {
	
	func date(from style: StringToDateStyles, region: Region) -> DateInRegion?
	func date(region: Region) -> DateInRegion?
	
}

extension String: DateParsable {
	
	public func date(from style: StringToDateStyles, region: Region = SwiftDate.defaultRegion) -> DateInRegion? {
		return style.toDate(self, region: region)
	}
	
	public func date(region: Region = SwiftDate.defaultRegion) -> DateInRegion? {
		return DateInRegion.init(self, format: nil, region: region)
	}
	
}
