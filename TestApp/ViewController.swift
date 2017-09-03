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
	
	//	let italian = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italian)
		let arabic = Region(tz: TimeZoneName.asiaKuwait, cal: CalendarName.gregorian, loc: LocaleName.arabic)
		let arabic_sa = Region(tz: TimeZoneName.asiaKuwait, cal: CalendarName.gregorian, loc: LocaleName.arabicSaudiArabia)
		
		/*let oneHourAgo = DateInRegion() - 1.hour
		let (test1,_) = try! oneHourAgo.colloquialSinceNow()
		print("test1: \(test1)") //test1: one hour ago
		
		let oneHourAgo_IT = DateInRegion(absoluteDate: Date(), in: italian) - 1.hour
		let (test2,_) = try! oneHourAgo_IT.colloquialSinceNow()
		print("test2: \(test2)") //test2: un'ora fa
		*/
		let oneHourAgo_AR = DateInRegion(absoluteDate: Date(), in: arabic) - 1.hour
		let (test3,_) = try! oneHourAgo_AR.colloquialSinceNow()
		print("test3: \(test3)") //test3: one hour ago
		
		let oneHourAgo_AR_SA = DateInRegion(absoluteDate: Date(), in: arabic_sa) - 1.hour
		let (test4,_) = try! oneHourAgo_AR_SA.colloquialSinceNow()
		print("test4: \(test4)") //test4: one hour ago
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

