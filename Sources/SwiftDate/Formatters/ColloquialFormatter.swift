//
//  ColloquialDateTimeFormatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 07/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public struct ColloquialFormatter: DateToStringTrasformable {
	
	
	/// Options used to format the colloqual string
	public struct Options {
		
		public init() {}
	}
	
	public init(options: ColloquialFormatter.Options? = nil) {
		
	}
	
	public func toString(_ date: DateRepresentable) -> String {
		return ""
	}
}
