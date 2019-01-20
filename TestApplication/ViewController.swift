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

		let x = DateInRegion.datesForWeekday(.monday, inMonth: 1, ofYear: 2019)
		print(x)
		//let x = DateInRegion.datesForWeekday(.monday, ofMonth: 1, ofYear: 2019)
		//print(x)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
