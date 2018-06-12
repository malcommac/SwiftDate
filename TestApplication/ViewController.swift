//
//  ViewController.swift
//  TestApplication
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, timezone: TimeZones.europeRome, locale: Locales.italian)
		
		//let newDate = DateInRegion("2001-01-01 06:30:00")
		//let newDateInUTC = newDate?.express(in: Region.defaultGMT())
		
		
//		let n = DateInRegion(components: {
//			$0.day = 4
//			$0.month = 6
//			$0.year = 2018
//			$0.hour = 0
//			$0.minute = 0
//			$0.second = 0
//		})
//		print(n!.description)
//
//		let i = n!.string("yyyy")
//		print(i)

//		let now = DateInRegion()
//		print("now = \(now)\n")
//
//		let iso8601_string = now.string(with: .iso)
//		print("iso8601 string = \(iso8601_string)\n")
//
//		print("absoluteDateTime UTC = \(now.date)\n") // UTC format
//
//		let absoluteDate = now.date
//		let absoluteDate_iso8601_string = absoluteDate.string(with: .iso)
//		print("absoluteDate iso8601 string = \(absoluteDate_iso8601_string)\n")


		//let d = "1983-06-01T09:30:00+02:00".toDate()!
		let d1 = "2018-06-10T19:50:00+02:00".toDate()!
		
		let coll = d1.toString(.relative)
		print("")
//		print(d?.string("yyyy")
//		print(d)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
