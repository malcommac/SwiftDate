//
//  Date.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

#if os(Linux)

#else
internal enum AssociatedKeys: String {
	case customDateFormatter = "SwiftDate.CustomDateFormatter"
}
#endif

extension Date: DateRepresentable {

	/// Just return itself to be compliant with `DateRepresentable` protocol.
	public var date: Date { return self }

	/// For absolute Date object the default region is obtained from the global `defaultRegion` variable.
	public var region: Region {
		return SwiftDate.defaultRegion
	}

	#if os(Linux)
	public var customFormatter: DateFormatter? {
		get {
			debugPrint("Not supported on Linux")
			return nil
		}
		set { debugPrint("Not supported on Linux") }
	}
	#else
	/// Assign a custom formatter if you need a special behaviour during formatting of the object.
	/// Usually you will not need to do it, SwiftDate uses the local thread date formatter in order to
	/// optimize the formatting process. By default is `nil`.
	public var customFormatter: DateFormatter? {
		get {
			let fomatter: DateFormatter? = getAssociatedValue(key: AssociatedKeys.customDateFormatter.rawValue, object: self as AnyObject)
			return fomatter
		}
		set {
			set(associatedValue: newValue, key: AssociatedKeys.customDateFormatter.rawValue, object: self as AnyObject)
		}
	}
	#endif

	/// Extract the date components.
	public var dateComponents: DateComponents {
		return region.calendar.dateComponents(DateComponents.allComponentsSet, from: self)
	}

	/// Initialize a new date object from string expressed in given region.
	///
	/// - Parameters:
	///   - string: date expressed as string.
	///   - format: format of the date (`nil` uses provided list of auto formats patterns.
	///				Pass it if you can in order to optimize the parse task).
	///   - region: region in which the date is expressed. `nil` uses the `SwiftDate.defaultRegion`.
	public init?(_ string: String, format: String? = nil, region: Region = SwiftDate.defaultRegion) {
		guard let dateInRegion = DateInRegion(string, format: format, region: region) else { return nil }
		self = dateInRegion.date
	}

	/// Initialize a new date from the number of seconds passed since Unix Epoch.
	///
	/// - Parameter interval: seconds

	/// Initialize a new date from the number of seconds passed since Unix Epoch.
	///
	/// - Parameters:
	///   - interval: seconds from Unix epoch time.
	///   - region: region in which the date, `nil` uses the default region at UTC timezone
	public init(seconds interval: TimeInterval, region: Region = Region.UTC) {
		self = DateInRegion(seconds: interval, region: region).date
	}

	/// Initialize a new date corresponding to the number of milliseconds since the Unix Epoch.
	///
	/// - Parameters:
	///   - interval: seconds since the Unix Epoch timestamp.
	///   - region: region in which the date must be expressed, `nil` uses the default region at UTC timezone
	public init(milliseconds interval: Int, region: Region = Region.UTC) {
		self = DateInRegion(milliseconds: interval, region: region).date
	}

	/// Initialize a new date with the opportunity to configure single date components via builder pattern.
	/// Date is therfore expressed in passed region (`DateComponents`'s `timezone`,`calendar` and `locale` are ignored
	/// and overwritten by the region if not `nil`).
	///
	/// - Parameters:
	///   - configuration: configuration callback
	///   - region: region in which the date is expressed. Ignore to use `SwiftDate.defaultRegion`, `nil` to use `DateComponents` data.
	public init?(components configuration: ((inout DateComponents) -> Void), region: Region? = SwiftDate.defaultRegion) {
		guard let date = DateInRegion(components: configuration, region: region)?.date else { return nil }
		self = date
	}

	/// Initialize a new date with given components.
	///
	/// - Parameters:
	///   - components: components of the date.
	///   - region: region in which the date is expressed.
	///				Ignore to use `SwiftDate.defaultRegion`, `nil` to use `DateComponents` data.
	public init?(components: DateComponents, region: Region?) {
		guard let date = DateInRegion(components: components, region: region)?.date else { return nil }
		self = date
	}

	/// Initialize a new date with given components.
	public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int = 0, nanosecond: Int = 0, region: Region = SwiftDate.defaultRegion) {
		var components = DateComponents()
		components.year = year
		components.month = month
		components.day = day
		components.hour = hour
		components.minute = minute
		components.second = second
		components.nanosecond = nanosecond
		components.timeZone = region.timeZone
		components.calendar = region.calendar
		self = region.calendar.date(from: components)!
	}

	/// Express given absolute date in the context of the default region.
	///
	/// - Returns: `DateInRegion`
	public func inDefaultRegion() -> DateInRegion {
		return DateInRegion(self, region: SwiftDate.defaultRegion)
	}

	/// Express given absolute date in the context of passed region.
	///
	/// - Parameter region: destination region.
	/// - Returns: `DateInRegion`
	public func `in`(region: Region) -> DateInRegion {
		return DateInRegion(self, region: region)
	}

	/// Return a date in the distant future.
	///
	/// - Returns: Date instance.
	public static func past() -> Date {
		return Date.distantPast
	}

	/// Return a date in the distant past.
	///
	/// - Returns: Date instance.
	public static func future() -> Date {
		return Date.distantFuture
	}

}
