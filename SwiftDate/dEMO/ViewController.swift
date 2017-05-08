//
//  ViewController.swift
//  Demo Application
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import UIKit
import SwiftDate

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	
		//let y = DOTNETDateTimeFormatter.date("/Date(-31536000000+0200)/", calendar: CalendarName.gregorian.calendar)
		
		let d1 = "/Date(-31536000000+0200)/".date(format: .dotNET)!
		
		let str = DOTNETDateTimeFormatter.string(d1)
		print(str)
//	
//		return
//		let d1 = "1969-01-01 00:00:00".date(format: .custom("yyyy-MM-dd HH:mm:SS"), fromRegion: Region.GMT())!
//		let d1_string = d1.string(format: .dotNET)
//		
	//	let d2 = "1970-01-01 00:00:00".date(format: .custom("yyyy-MM-dd HH:mm:SS"), fromRegion: Region.GMT())!
	//	let d2_string = d2.string(format: .dotNET)
		
//		print(d1_string)
//	//	print(d2_string)
//		
//		let d1_parsed = d1_string.date(format: .dotNET)!
//		print(d1_parsed)
	}

}

