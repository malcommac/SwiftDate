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
		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, timezone: Zones.europeRome, locale: Locales.english)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
