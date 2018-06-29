import Foundation
import SwiftDate

/*:
## Welcome to SwiftDate!

SwiftDate is the definitive toolchain to manage and work with Dates on all Apple platforms and even in Linux environments or Server Side Swift.

In the following guides you will learn the basic concepts behind the project (just a bunch of stuff we promise!) and you will be ready to integrate it in your next killer application (btw don't miss the opportunity to be listed in our HALL OF GLORIES.md).

This is an interactive playgtound so the best thing you can do is to open it in XCode and have fun with it!

### Table Of Contents

- How plain `Date` works in Cocoa
- Introducing `Region` & `DateInRegion`

#### How plain `Date` works in Cocoa

Generally when you talk about dates you are involved to think about a particular instance of time in a particular location of the world. However, in order to get a fully generic implementationn Apple made `Date` fully indipendent from any particular geographic location, calendar or locale.

A plain `Date` object just represent an absolute value: in fact it count the number of seconds elapsed since January 1, 2001.

This is what we call **Universal Time because it represent the same moment everywhere around the world**.

You can see absolute time as the moment that someone in the USA has a telephone conversation with someone in Dubai; both have that conversation at the same moment (the absolute time) but the local time will be different due to time zones, different calendars, alphabets or notation methods.
*/

//let t: TimeInterval = (2.hours.timeInterval) + (34.minutes.timeInterval) + (5.seconds.timeInterval)
//let x = t.toString {
//	$0.maximumUnitCount = 4
//	$0.allowedUnits = [.day, .hour, .minute]
//	$0.collapsesLargestUnit = true
//	$0.unitsStyle = .abbreviated
//}

let now2 = Date() - 3.minutes
let x = now2.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian)
let y = (now2 - 40.minutes).toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.italian)
let y2 = (now2 - 40.minutes).toRelative(style: RelativeFormatter.timeStyle(), locale: Locales.english)

let now = Date()
print("\(now.timeIntervalSinceReferenceDate) seconds elapsed since Jan 1, 2001 @ 00:00 UTC")
/*:
However we often need to represent a date in a more specific context: a particular place in the world, printing them using the rules of a specified locale and more.
In order to accomplish it we need to introduce several other objects: a `Calendar`, a `TimeZone` and a `Locale`; combining these attributes we're finally ready to provide a **representation** of the date into the real world.

Once you had understand it, having fun with dates is simple but unecessary complex; even formatting a simple date involves the existence of several lines of codes which made your code less easier to read.

The following code is required to print our `now` date in Rome timezone with the italian locale:
*/
let formatter = DateFormatter()
formatter.locale = Locale(identifier: "it_IT")
formatter.timeZone = TimeZone(identifier: "Europe/Rome")
formatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
formatter.dateFormat = "dd MMMM yyyy 'at' HH:mm"
let dateString = formatter.string(from: now)
print("Today is: \(dateString)")
/*:
Pretty akwaird uh?
A pretty similar stuff is made to parse a date or to extract specific time unit components from it taking care of the locale, calendar and timezone stuff:
*/
let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
let someComponents = calendar.dateComponents([.day, .weekOfMonth], from: now)
print("Current day: \(someComponents.day!), Week of Month: \(someComponents.weekOfMonth!)")
/*:
Even the date manipulation is 
*/
