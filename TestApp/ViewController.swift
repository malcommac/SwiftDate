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
		
		Date.setDefaultRegion(Region(tz: TimeZoneName.gmt,
									 cal: CalendarName.gregorian,
									 loc: LocaleName.englishEurope))
		
	/*	let startDate = Date(timeIntervalSince1970: 1511222400.0) // 21 Nov 2017
		let endDate = startDate.add(components: [.day: 30])
		var currentDate = startDate.add(components: [.day: 1])
		while currentDate.isBefore(date: endDate, granularity: .day) {
			let swiftDateDiff = (currentDate - startDate).in(.day)!
			let seconds = currentDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
			let customDateDiff = Int(seconds / 60 / 60 / 24)
			if swiftDateDiff != customDateDiff {
				print("Diff with \(currentDate) should be \(customDateDiff) days, instead of \(swiftDateDiff).")
			}
			currentDate = currentDate.add(components: [.day: 1])
		}
		
	*/
		
		var t: TimeInterval = (60 * 60 * 24 * 90)
		t += (60 * 60)
		let x = t.in([.day,.hour])
		print(x)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

