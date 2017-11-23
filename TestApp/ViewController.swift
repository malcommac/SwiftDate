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
		
		let d1 = DateInRegion()
		let d2 = d1 + 5.minutes
		var opts = ColloquialDateFormatter.Options()
		opts.imminentRange = nil
		let colloquial = d2.colloquial(toDate: d1, options: opts)
		print("colloquial = \(colloquial)")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

