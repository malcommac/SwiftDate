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
		
		Date.setDefaultRegion(Region.GMT())
		let endMonth = Date().endOf(component: .month) // 2017-07-31 21:59:59 +0000
		var currentStartMonth = endMonth.prevMonth(at: .start)
		for _ in 0..<10 {
			currentStartMonth = currentStartMonth.nextMonth(at: .start)
			print(currentStartMonth)
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

