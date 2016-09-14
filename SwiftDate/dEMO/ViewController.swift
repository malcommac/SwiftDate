//
//  ViewController.swift
//  dEMO
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

//
		let dGMT = Date()
		let rRegion = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.currentAutoUpdating)
//
		let date1 = try! DateInRegion(string: "2016-01-01 15:30:00", format: .custom("yyyy-MM-DD HH:mm:SS"), fromRegion: rRegion)
		let date2 = try! DateInRegion(string: "2016-01-01 14:30:00", format: .custom("yyyy-MM-DD HH:mm:SS"), fromRegion: rRegion)
		let diff = date2 - date1
//		
//		let inSeconds = diff.in(.second)
//		let inMinutes = diff.in(.minute)
		let inHours = diff.in(.hour)
		
		let x = try! diff.string(unitStyle: .short)
		
		let (d,t) = try! date1.colloquialSinceNow()
		
		let xx = try! date1.atTime(hour: 22, minute: 0, second: 2)
		print("ok")
		

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

