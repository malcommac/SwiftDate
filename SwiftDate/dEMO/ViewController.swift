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
		
		let str = "2016-11-10T07:58:35.566Z"
		let format = try! str.date(format: .iso8601(options: .withInternetDateTimeExtended))
		print(format)
	}

}

