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
		
		let now = Date()
		
		let romeTz = TimeZoneName.europeRome.timeZone
		let nyTz = TimeZoneName.americaNewYork.timeZone
		
		let miof = ISO8601Parser()
		miof.timeZone = nyTz
		miof.formatOptions = [.withWeekOfYear,.withMonth,.withDashSeparatorInDate] // 2016-09-22
		let mio = miof.string(from: now)

		let suof = ISO8601DateFormatter()
		suof.timeZone = nyTz
//		suof.formatOptions = [.withWeekOfYear,.withMonth,.withDay,.withYear,.withTimeZone] // 2016-09-22
		suof.formatOptions = [.withWeekOfYear,.withMonth,.withDashSeparatorInDate] // 2016-09-22
		let suo = suof.string(from: now)
		
		print("MIO: \(mio)")
		print("SUO: \(suo)")

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

