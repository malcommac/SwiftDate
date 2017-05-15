//: Playground - noun: a place where people can play

import UIKit
import SwiftDate

let date_format = DateFormat.custom("yyyy-MM-dd HH:mm:SS")
let d1 = "2017-01-01 10:00:00".date(format: date_format)!
let d2 = "2017-01-01 11:20:00".date(format: date_format)!
let d3 = "2019-02-25 14:35:45".date(format: date_format)!

//: # Time Periods
//: Sometimes you may need to work with less discrete value than Dates. Life is  made up of spans of time.
//: In SwiftDate, time periods are represented by the `TimePeriod` class and come with a suite of methods which allows you to manage and work with them.

//: Time peroids consist of an Date start date and end date.
//: To initialize a time period, call the init function.
var t1 = TimePeriod(from: d1, to: d2)

//: You can also init a `TimePeriod` by passing a start/end date with a given duration.
//: Following example create a TimePeriod from `startDate` and a duration of 30 minutes:
var t2 = TimePeriod(to: d1, duration: 60*30)
var t3 = TimePeriod(from: d1, to: d1)
var t4 = TimePeriod(from: d1, to: d3)

//: ## Getting Info for Time Period
//: A host of methods have been extended to give information about an instance of TimePeriod. A few are listed below:

//: Has time period a start/end date?
let d1_hasStart = t1.hasStartDate
let d1_hasEnd = t1.hasEndDate
//: Does this time period represent an instant?
let d3_isInstant = t3.isMoment

//: You can also get the components of a time period
let diff = "Difference is \(t4.years!) years, \(t4.weeks!) weeks, \(t4.days!) days, \(t4.hours!) hours, \(t4.minutes!) and \(t4.seconds!) secs"

//: You can also make operations with time periods

let t5 = t4 + 3.
