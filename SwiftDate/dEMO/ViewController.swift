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
		
		//from = 2017-04-01 15:07:52 UTC
		//to = 2017-04-03 14:07:52 UTC
		
		let to = Date()
		let from = Date(timeIntervalSince1970: to.timeIntervalSince1970 - 47 * 60 * 60)
		
		let fromDate = DateInRegion(absoluteDate: from, in: nil)
		let toDate = DateInRegion(absoluteDate: to, in: fromDate.region)
		let formatter = DateInRegionFormatter()
		formatter.localization = Localization(locale: fromDate.region.locale)
		formatter.imminentInterval = 1
		let col = try! formatter.colloquial(from: fromDate, to: toDate).colloquial
		
		print("col = \(col)")
	}

}

