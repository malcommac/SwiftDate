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
		
		print(NSDate())
		print(NSDate().weekOfMonth)
		
		return
		
        let date = NSDate()
        
        _ = date.toString(format: DateFormat.Custom("YYYY-MM-DD"))

        
        _ = date+1.days
        let two_months_ago = (date-2.months)!
        print(two_months_ago.toLongDateString())
        
        
        
        let date_as_utc = date.toUTC() //UTC 时间
        let date_as_beijing = date_as_utc.toTimezone("GMT+0800") //北京时间
        
        print(date_as_utc.toLongTimeString())
        print(date_as_beijing?.toLongTimeString())
        
		let d = (NSDate()-1.hours)!
        
        print(d.year)
        
        
        let date1 = NSDate.date(fromString: "2015-07-26", format: DateFormat.Custom("YYYY-MM-DD"))
        let date2 = NSDate.date(fromString: "2015-07-27", format: DateFormat.Custom("YYYY-MM-DD"))
        
        if date2 > date1 {
            
            // TODO something
            print("Hello")

        }
        
        
		let abb = d.toRelativeString(abbreviated: true, maxUnits: 3)
		print("data: \(abb)")
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

