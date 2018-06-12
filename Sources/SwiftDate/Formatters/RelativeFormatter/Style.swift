//
//  Style.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 08/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public extension RelativeFormatter {
	
	public enum Flavour: String {
		case long 				= "long"
		case longTime 			= "long_time"
		case longConvenient	 	= "long_convenient"
		case short 				= "short"
		case shortTime 			= "short_time"
		case shortConvenient 	= "short_convenient"
		case narrow 			= "narrow"
		case tiny 				= "tiny"
		case quantify 			= "quantify"
	}
	
}
