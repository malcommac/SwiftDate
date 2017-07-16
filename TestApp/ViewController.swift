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
		

		let gmt = Region(tz: TimeZoneName.gmt, cal: CalendarName.gregorian, loc: LocaleName.english)
		let startDate = DateInRegion(string: "2017-07-16 16:00:00 +0000", format: .iso8601Auto, fromRegion: gmt)!
		var nextWeek = startDate.prevMonth(at: .start)
		for _ in 0..<10 {
			nextWeek = nextWeek.nextMonth(at: .start)
			print(nextWeek.string(format: .iso8601Auto))
		}


		
		/*var currentEndMonth = endMonth.prevMonth.endOf(component: .month)
		for _ in 0..<10 {
			currentEndMonth = currentEndMonth.nextMonth
			print(currentEndMonth)
		}*/
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

