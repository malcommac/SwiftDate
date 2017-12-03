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

		let currentDate = Date()
		let test = currentDate + 3.month
		print((test - currentDate).in(.month))
		print((currentDate - test).in(.month))
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

