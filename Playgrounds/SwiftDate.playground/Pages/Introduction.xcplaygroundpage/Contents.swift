import Foundation
import SwiftDate


//let t: TimeInterval = (2.hours.timeInterval) + (34.minutes.timeInterval) + (5.seconds.timeInterval)
//let x = t.toString {
//	$0.maximumUnitCount = 4
//	$0.allowedUnits = [.day, .hour, .minute]
//	$0.collapsesLargestUnit = true
//	$0.unitsStyle = .abbreviated
//}

//let now2 = Date() - 3.minutes
//let x = now2.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian)
//let y = (now2 - 40.minutes).toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.italian)
//let y2 = (now2 - 40.minutes).toRelative(style: RelativeFormatter.timeStyle(), locale: Locales.english)
//

/*:
#### How `Date` works in Cocoa

Generally when you talk about dates you are brought to think about a particular instance of time in a particular location of the world. However, in order to get a fully generic implementationn Apple made `Date` fully indipendent from any particular geographic location, calendar or locale.

A plain `Date` object just represent an absolute value: in fact it count the number of seconds elapsed since January 1, 2001.

This is what we call **Universal Time because it represent the same moment everywhere around the world**.

You can see absolute time as the moment that someone in the USA has a telephone conversation with someone in Dubai; both have that conversation at the same moment (the absolute time) but the local time will be different due to time zones, different calendars, alphabets or notation methods.
*/

let now = Date()
print("\(now.timeIntervalSinceReferenceDate) seconds elapsed since Jan 1, 2001 @ 00:00 UTC")

/*:
However we often need to represent a date in a more specific context: a particular place in the world, printing them using the rules of a specified locale and more.
In order to accomplish it we need to introduce several other objects: a `Calendar`, a `TimeZone` and a `Locale`; combining these attributes we're finally ready to provide a **representation** of the date into the real world.

SwiftDate allows you to parse, create, manipulate and inspect dates in an easy and more natural way than Cocoa itself.
*/
