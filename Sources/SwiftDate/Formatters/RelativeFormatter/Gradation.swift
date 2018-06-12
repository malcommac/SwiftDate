//
//  Gradation.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 08/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public extension RelativeFormatter {
	
	public enum Unit: String {
		case now = "now"
		case second = "second"
		case minute = "minute"
		case hour = "hour"
		case halfHour = "half_hour"
		case day = "day"
		case week = "week"
		case month = "month"
		case year = "year"
		case quarter = "quarter"
	}
	
	public struct Gradation {
		
		public struct Entry {
			
			public typealias ThresholdFunction = ((TimeInterval) -> (Double?))
			public typealias FormatFunction = ((DateRepresentable) -> (String))

			public let unit: Unit
			public let threshold: Double?
			public let factor: Double
			public let granularity: Double?
			public let thresholdPrevious: [Unit: Double]?
			public let thresholdFunc: ThresholdFunction?
			public let format: FormatFunction?
			
			public func evaluateThreshold(_ now: TimeInterval) -> Double? {
				guard let function = self.thresholdFunc else {
					return threshold
				}
				return function(now)
			}
			
			public init(_ unit: Unit, threshold: Double?, factor: Double = 0,
						granularity: Double? = nil, prev: [Unit: Double]? = nil, format: FormatFunction? = nil ) {
				self.unit = unit
				self.threshold = threshold
				self.factor = factor
				self.granularity = granularity
				self.thresholdPrevious = prev
				self.thresholdFunc = nil
				self.format = format
			}
			
			public init(_ unit: Unit, threshold: ThresholdFunction?, factor: Double = 0,
						granularity: Double? = nil, prev: [Unit: Double]? = nil, format: FormatFunction? = nil ) {
				self.unit = unit
				self.thresholdFunc = threshold
				self.factor = factor
				self.granularity = granularity
				self.thresholdPrevious = prev
				self.threshold = nil
				self.format = format
			}
		}
		
		var data: [Entry]
		var count: Int {
			return self.data.count
		}

		public subscript(_ index: Int) -> Entry? {
			guard index < self.data.count, index >= 0 else { return nil }
			return self.data[index]
		}
		
		public init(_ steps: [Entry]) {
			self.data = steps
		}
		
		public static func canonical() -> Gradation {
			let ti1Day = 1.days.timeInterval
			let ti1Month = 1.months.timeInterval
			let ti1Year = 1.years.timeInterval
			return Gradation([
				Entry(.now,threshold: 0, factor: 1),
				Entry(.second,threshold: 0.5, factor: 1),
				Entry(.minute,threshold: 59.5, factor: 60),
				Entry(.hour,threshold: 59.5 * 60.0, factor: 60 * 60),
				Entry(.day,threshold: 23.5 * 60 * 60, factor: ti1Day),
				Entry(.week,threshold: 6.5 * ti1Day, factor: 7 * ti1Day),
				Entry(.month,threshold: 3.5 * 7 * ti1Day, factor: ti1Month),
				Entry(.year,threshold: 11.5 * ti1Month, factor: ti1Year)
			])
		}
		
		
		public static func convenient() -> Gradation {
			let ti1Day = 1.days.timeInterval
			let ti1Month = 1.months.timeInterval
			let ti1Year = 1.years.timeInterval
			return Gradation([
				Entry(.now,threshold: 0, factor: 1),
				Entry(.second,threshold: 1, factor: 1, prev: [.now : 1]),
				Entry(.minute,threshold: 45, factor: 60),
				Entry(.minute, threshold: 2.5 * 60, factor: 60, granularity: 5),
				Entry(.halfHour, threshold: 22.5 * 60, factor: 60, granularity: 5),
				Entry(.hour, threshold: 42.5 * 60, factor: 60 * 60, prev: [.minute : 52.5 * 60]),
				Entry(.day, threshold: (20.5 / 24) * ti1Day, factor: ti1Day),
				Entry(.week, threshold: 5.5 * ti1Day, factor: ti1Day),
				Entry(.month, threshold: 3.5 * 7 * ti1Day, factor: ti1Month),
				Entry(.year, threshold: 10.5 * ti1Month, factor: ti1Year)
			])
		}
	}
	
}
