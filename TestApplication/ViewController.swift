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

		let fromDate = DateInRegion().dateAtStartOf([.weekOfYear, .day])
		let toDate = fromDate.dateAtEndOf([.weekOfMonth, .day])
		let thisWeek = TimePeriod(start: fromDate, end: toDate)
//		let shiftedByOneWeek = thisWeek.shifted(by: 7.days)
//		print("")

		//Create collection
		/*DTTimePeriodCollection *collection = [DTTimePeriodCollection collection];
		
		//Create a few time periods
		DTTimePeriod *firstPeriod = [DTTimePeriod timePeriodWithStartDate:[dateFormatter dateFromString:@"2014 11 05 18:15:12.000"] endDate:[dateFormatter dateFromString:@"2015 11 05 18:15:12.000"]];
		DTTimePeriod *secondPeriod = [DTTimePeriod timePeriodWithStartDate:[dateFormatter dateFromString:@"2015 11 05 18:15:12.000"] endDate:[dateFormatter dateFromString:@"2016 11 05 18:15:12.000"]];
		
		//Add time periods to the colleciton
		[collection addTimePeriod:firstPeriod];
		[collection addTimePeriod:secondPeriod];
		
		//Retreive collection items
		DTTimePeriod *firstPeriod = collection[0];*/

		// Create collection
		let collection = TimePeriodCollection()

		// Create a few time periods
		let firstPeriod = TimePeriod(start: "2014-11-05 18:15:12".toDate()!, end: "2015-11-05 18:20:12".toDate()!)
		let secondPeriod = TimePeriod(start: "2014-11-05 18:30:12".toDate()!, end: "2015-11-05 18:35:12".toDate()!)
		collection.append([firstPeriod, secondPeriod])

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
