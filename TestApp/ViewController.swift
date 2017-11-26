//
//  ViewController.swift
//  TestApp
//
//  Created by dan on 06/07/2017.
//  Copyright © 2017 SwiftDate. All rights reserved.
//

import UIKit
import SwiftDate

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italianItaly)

		let date1 = DateInRegion(string: "1999-12-31 23:30:00", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!
		let date2 = DateInRegion(string: "1999-12-31 23:40:05", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!
		

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

