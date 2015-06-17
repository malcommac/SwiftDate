//
//  ViewController.swift
//  ExampleProject
//
//  Created by Mark Norgren on 5/21/15.
//
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
		let date = "2015-06-17T09:10:00.000Z".toDate(format: DateFormat.ISO8601)
		var d = NSDate()-1.hour
		var abb = d.toRelativeString(abbreviated: true, maxUnits: 3)
		println("data: \(abb)")
//		
//		let w = NSDate()-1.month
//		print("Prev month: \(w)")
//		
//		var w2 = NSDate().add("month",value:-1)
//		print(date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

