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

		let newYork = Region(tz: TimeZones.americaNewYork, cal: Calendars.gregorian, loc: Locales.englishUnitedStates)
		let rome = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.italianItaly)
		let amsterdam = Region(tz: TimeZones.europeAmsterdam, cal: Calendars.gregorian, loc: Locales.dutchNetherlands)
		let utc = Region(tz: TimeZones.gmt, cal: Calendars.gregorian, loc: Locales.english)
	
		
//		let expectedWeekendStartDate = try! DateInRegion(components: [.year: 2015, .month: 10, .day: 31], fromRegion: amsterdam)
//		let expectedWeekendEndDate = (expectedWeekendStartDate + 1.days).endOf(component: .day)
//		
//		print("Expected start: \(expectedWeekendStartDate)")
//		print("Expected end: \(expectedWeekendEndDate)")
//		
//		var daysToTest: [DateInRegion] = []
//		daysToTest.append(try! DateInRegion(components: [.year: 2015, .month: 11, .day: 8], fromRegion: amsterdam))
//		daysToTest.append(try! DateInRegion(components: [.year: 2015, .month: 11, .day: 7], fromRegion: amsterdam))
//		daysToTest.append(try! DateInRegion(components: [.year: 2015, .month: 11, .day: 6], fromRegion: amsterdam))
//		daysToTest.append(try! DateInRegion(components: [.year: 2015, .month: 11, .day: 5], fromRegion: amsterdam))
//		daysToTest.append(try! DateInRegion(components: [.year: 2015, .month: 11, .day: 4], fromRegion: amsterdam))
//		daysToTest.append(try! DateInRegion(components: [.year: 2015, .month: 11, .day: 3], fromRegion: amsterdam))
//		daysToTest.append(try! DateInRegion(components: [.year: 2015, .month: 11, .day: 2], fromRegion: amsterdam))
//		
//		
//		for dateToTest in daysToTest {
			//let foundWeekend = dateToTest.previousWeekend
//			print("start:\(foundWeekend?.startDate), end=\(foundWeekend?.endDate)")
//		}

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

