//
//  Style.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 08/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Languages table.
/// In order to be fully compatible with Linux environment we need to
/// handle directly with .swift files instead of plain text files.
public protocol RelativeFormatterLang {

	/// Table with the data of the language.
	/// Data is structured in:
	/// { flavour: { unit : { data } } }
	var flavours: [String: Any] { get }

	/// Identifier of the language.
	/// Must be the languageIdentifier of the `Locale` instance.
	static var identifier: String { get }

	/// This is the rule to return singular or plural forms
	/// based upon the CDLC specs. Must return the appropriate
	/// value (other, few, none...)
	///
	/// - Parameter value: quantity to evaluate
	func quantifyKey(forValue value: Double) -> RelativeFormatter.PluralForm?

	/// Init
	init()
}

// MARK: - Style

public extension RelativeFormatter {

	enum PluralForm: String {
		case zero, one, two, few, many, other
	}

	/// Style for formatter
	struct Style {

		/// Flavours supported by the style, specified in order.
		/// The first available flavour for specified locale is used.
		/// If no flavour is available `.long` is used instead (this flavour
		/// MUST be part of every lang structure).
		public var flavours: [Flavour]

		/// Gradation specify how the unit are evaluated in order to get the
		/// best one to represent a given amount of time interval.
		/// By default `convenient()` is used.
		public var gradation: Gradation = .convenient()

		/// Allowed time units the style can use. Some styles may not include
		/// some time units (ie. `.quarter`) because they are not useful for
		/// a given representation.
		/// If not specified all the following units are set:
		/// `.now, .minute, .hour, .day, .week, .month, .year`
		public var allowedUnits: [Unit]?

		/// Create a new style.
		///
		/// - Parameters:
		///   - flavours: flavours of the style.
		///   - gradation: gradation rules.
		///   - units: allowed units.
		public init(flavours: [Flavour], gradation: Gradation, allowedUnits units: [Unit]? = nil) {
            self.flavours = flavours
			self.gradation = gradation
			allowedUnits = (units ?? [.now, .minute, .hour, .day, .week, .month, .year])
		}
	}

	/// Return the default style for relative formatter.
	///
	/// - Returns: style instance.
	static func defaultStyle() -> Style {
		return Style(flavours: [.longConvenient, .long], gradation: .convenient())
	}

	/// Return the time-only style for relative formatter.
	///
	/// - Returns: style instance.
	static func timeStyle() -> Style {
		return Style(flavours: [.longTime], gradation: .convenient())
	}
	/// Return the twitter style for relative formatter.
	///
	/// - Returns: style instance.
	static func twitterStyle() -> Style {
		return Style(flavours: [.tiny, .shortTime, .narrow, .shortTime], gradation: .twitter())
	}

}

// MARK: - Flavour

public extension RelativeFormatter {

	/// Supported flavours
	enum Flavour: String {
		case long 				= "long"
		case longTime 			= "long_time"
		case longConvenient	 	= "long_convenient"
		case short 				= "short"
		case shortTime 			= "short_time"
		case shortConvenient 	= "short_convenient"
		case narrow 			= "narrow"
		case tiny 				= "tiny"
		case quantify 			= "quantify"
	}

}

// MARK: - Gradation

public extension RelativeFormatter {

	/// Gradation is used to define a set of rules used to get the best
	/// representation of a given elapsed time interval (ie. the best
	/// representation for 300 seconds is in minutes, 5 minutes specifically).
	/// Rules are executed in order by the parser and the best one (< elapsed interval)
	/// is returned to be used by the formatter.
	struct Gradation {

		/// A single Gradation rule specification
		// swiftlint:disable nesting
		public struct Rule {

			public enum ThresholdType {
				case value(_: Double?)
				case function(_: ((TimeInterval) -> (Double?)))

				func evaluateForTimeInterval(_ elapsed: TimeInterval) -> Double? {
					switch self {
					case .value(let value): 		return value
					case .function(let function): 	return function(elapsed)
					}
				}

            }

            public enum RoundingStrategy {

                case regularRound
                case ceiling
                case flooring
                case custom((Double) -> Double)

                func roundValue(_ value: Double) -> Double {

                    switch self {
                    case .regularRound:                 return round(value)
                    case .ceiling:                      return ceil(value)
                    case .flooring:                     return floor(value)
                    case .custom(let roundingFunction): return roundingFunction(value)
                    }
                }
            }

			/// The time unit to which the rule refers.
			/// It's used to evaluate the factor.
			public var unit: Unit

			/// Threhsold value of the unit. When a difference between two dates
			/// is less than the threshold the unit before this is the best
			/// candidate to represent the time interval.
			public var threshold: ThresholdType?

			/// Granuality threshold of the unit
			public var granularity: Double?

            /// The rounding strategy that should be used prior to generating the relative time
            public var roundingStrategy: RoundingStrategy

			/// Relation with a previous threshold
			public var thresholdPrevious: [Unit: Double]?

			/// You can specify a custom formatter for a rule which return the
			/// string representation of a data with your own pattern.
			// swiftlint:disable nesting
			public typealias CustomFormatter = ((DateRepresentable) -> (String))
			public var customFormatter: CustomFormatter?

			/// Create a new rule.
			///
			/// - Parameters:
			///   - unit: target time unit.
			///   - threshold: threshold value.
			///   - granularity: granularity value.
			///   - prev: relation with a previous rule in gradation lsit.
			///   - formatter: custom formatter.
			public init(_ unit: Unit,
                        threshold: ThresholdType?,
						granularity: Double? = nil,
                        roundingStrategy: RoundingStrategy = .regularRound,
                        prev: [Unit: Double]? = nil,
                        formatter: CustomFormatter? = nil ) {
				self.unit = unit
				self.threshold = threshold
				self.granularity = granularity
                self.roundingStrategy = roundingStrategy
				self.thresholdPrevious = prev
				self.customFormatter = formatter
			}

		}

		/// Gradation rules
		var rules: [Rule]

		/// Number of gradation rules
		var count: Int { return rules.count }

		/// Subscript by unit.
		/// Return the first rule for given unit.
		///
		/// - Parameter unit: unit to get.
		public subscript(_ unit: Unit) -> Rule? {
			return rules.first(where: { $0.unit == unit })
		}

		/// Subscript by index.
		/// Return the rule at given index, `nil` if index is invalid.
		///
		/// - Parameter index: index
		public subscript(_ index: Int) -> Rule? {
			guard index < rules.count, index >= 0 else { return nil }
			return rules[index]
		}

		/// Create a new gradition with a given set of ordered rules.
		///
		/// - Parameter rules: ordered rules.
		public init(_ rules: [Rule]) {
			self.rules = rules
		}

		/// Create a new gradation by removing the units from receiver which are not part of the given array.
		///
		/// - Parameter units: units to keep.
		/// - Returns: a new filtered `Gradation` instance.
		public func filtered(byUnits units: [Unit]) -> Gradation {
			return Gradation(rules.filter { units.contains($0.unit) })
		}

		/// Canonical gradation rules
		public static func canonical() -> Gradation {
			return Gradation([
				Rule(.now, threshold: .value(0)),
				Rule(.second, threshold: .value(0.5)),
				Rule(.minute, threshold: .value(59.5)),
				Rule(.hour, threshold: .value(59.5 * 60.0)),
				Rule(.day, threshold: .value(23.5 * 60 * 60)),
				Rule(.week, threshold: .value(6.5 * Unit.day.factor)),
				Rule(.month, threshold: .value(3.5 * 7 * Unit.day.factor)),
				Rule(.year, threshold: .value(1.5 * Unit.month.factor))
				])
		}

		/// Convenient gradation rules
		public static func convenient() -> Gradation {
			let list = Gradation([
				Rule(.now, threshold: .value(0)),
				Rule(.second, threshold: .value(1), prev: [.now: 1]),
				Rule(.minute, threshold: .value(45)),
				Rule(.minute, threshold: .value(2.5 * 60), granularity: 5),
				Rule(.halfHour, threshold: .value(22.5 * 60), granularity: 5),
				Rule(.hour, threshold: .value(42.5 * 60), prev: [.minute: 52.5 * 60]),
				Rule(.day, threshold: .value((20.5 / 24) * Unit.day.factor)),
				Rule(.week, threshold: .value(5.5 * Unit.day.factor)),
				Rule(.month, threshold: .value(3.5 * 7 * Unit.day.factor)),
				Rule(.year, threshold: .value(10.5 * Unit.month.factor))
				])
			return list
		}

		/// Twitter gradation rules
		public static func twitter() -> Gradation {
			return Gradation([
				Rule(.now, threshold: .value(0)),
				Rule(.second, threshold: .value(1), prev: [.now: 1]),
				Rule(.minute, threshold: .value(45)),
				Rule(.hour, threshold: .value(59.5 * 60.0)),
				Rule(.hour, threshold: .value((1.days.timeInterval - 0.5 * 1.hours.timeInterval))),
				Rule(.day, threshold: .value((20.5 / 24) * Unit.day.factor)),
				Rule(.other, threshold: .function({ now in
					// Jan 1st of the next year.
					let nextYear = (Date(timeIntervalSince1970: now) + 1.years).dateAtStartOf(.year)
					return (nextYear.timeIntervalSince1970 - now)
				}), formatter: { date in // "Apr 11, 2017"
					return date.toFormat("MMM dd, yyyy")
				})
			])
		}

	}

}

// MARK: - Unit

public extension RelativeFormatter {

	/// Units for relative formatter
	enum Unit: String {
		case now 		= "now"
		case second 	= "second"
		case minute 	= "minute"
		case hour 		= "hour"
		case halfHour 	= "half_hour"
		case day 		= "day"
		case week 		= "week"
		case month 		= "month"
		case year 		= "year"
		case quarter 	= "quarter"
		case other 		= ""

		/// Factor of conversion of the unit to seconds
		public var factor: Double {
			switch self {
			case .now, .second: return 1
			case .minute: 		return 1.minutes.timeInterval
			case .hour: 		return 1.hours.timeInterval
			case .halfHour: 	return (1.hours.timeInterval * 0.5)
			case .day: 			return 1.days.timeInterval
			case .week: 		return 1.weeks.timeInterval
			case .month: 		return 1.months.timeInterval
			case .year: 		return 1.years.timeInterval
			case .quarter: 		return (91.days.timeInterval + 6.hours.timeInterval)
			case .other:		return 0
			}
		}

	}

}

internal extension Double {

	/// Return -1 if number is negative, 1 if positive
	var sign: Int {
		return (self < 0 ? -1 : 1)
	}

}
