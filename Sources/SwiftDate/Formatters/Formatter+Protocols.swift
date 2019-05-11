//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import Foundation

public protocol DateToStringTrasformable {
	static func format(_ date: DateRepresentable, options: Any?) -> String
}

public protocol StringToDateTransformable {
	static func parse(_ string: String, region: Region?, options: Any?) -> DateInRegion?
}

// MARK: - Formatters

/// Format to represent a date to string
///
/// - iso: standard iso format. The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
/// - extended: Extended format. "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
/// - rss: The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
/// - altRSS: The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
/// - dotNet: The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
/// - httpHeader: The http header formatted date "EEE, dd MMM yyyy HH:mm:ss zzz" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
/// - custom: custom string format
/// - standard: A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
/// - date: Date only format (short = "2/27/17", medium = "Feb 27, 2017", long = "February 27, 2017", full = "Monday, February 27, 2017"
/// - time: Time only format (short = "2:22 PM", medium = "2:22:06 PM", long = "2:22:06 PM EST", full = "2:22:06 PM Eastern Standard Time"
/// - dateTime: Date/Time format (short = "2/27/17, 2:22 PM", medium = "Feb 27, 2017, 2:22:06 PM", long = "February 27, 2017 at 2:22:06 PM EST", full = "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
public enum DateToStringStyles {
	case iso(_: ISOFormatter.Options)
	case extended
	case rss
	case altRSS
	case dotNet
	case httpHeader
	case sql
	case date(_: DateFormatter.Style)
	case time(_: DateFormatter.Style)
	case dateTime(_: DateFormatter.Style)
	case custom(_: String)
	case standard
	case relative(style: RelativeFormatter.Style?)

	public func toString(_ date: DateRepresentable) -> String {
		switch self {
		case .iso(let opts):			return ISOFormatter.format(date, options: opts)
		case .extended:					return date.formatterForRegion(format: DateFormats.extended).string(from: date.date)
		case .rss:						return date.formatterForRegion(format: DateFormats.rss).string(from: date.date)
		case .altRSS:					return date.formatterForRegion(format: DateFormats.altRSS).string(from: date.date)
		case .sql:						return date.formatterForRegion(format: DateFormats.sql).string(from: date.date)
		case .dotNet:					return DOTNETFormatter.format(date, options: nil)
		case .httpHeader:				return date.formatterForRegion(format: DateFormats.httpHeader).string(from: date.date)
		case .custom(let format):		return date.formatterForRegion(format: format).string(from: date.date)
		case .standard:					return date.formatterForRegion(format: DateFormats.standard).string(from: date.date)
		case .date(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = style
				$0.timeStyle = .none
			}).string(from: date.date)
		case .time(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = .none
				$0.timeStyle = style
			}).string(from: date.date)
		case .dateTime(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = style
				$0.timeStyle = style
			}).string(from: date.date)
		case .relative(let style):
			return RelativeFormatter.format(date, options: style)
		}
	}

}

// MARK: - Parsers

/// String to date transform
///
/// - iso: standard automatic iso parser (evaluate the date components automatically)
/// - extended: Extended format. "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
/// - rss: The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
/// - altRSS: The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
/// - dotNet: The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
/// - httpHeader: The http header formatted date "EEE, dd MMM yyyy HH:mm:ss zzz" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
/// - strict: custom string format with lenient options active
/// - custom: custom string format
/// - standard: A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
public enum StringToDateStyles {
	case iso(_: ISOParser.Options)
	case extended
	case rss
	case altRSS
	case dotNet
	case sql
	case httpHeader
	case strict(_: String)
	case custom(_: String)
	case standard

	public func toDate(_ string: String, region: Region) -> DateInRegion? {
		switch self {
		case .iso(let options):				return ISOParser.parse(string, region: region, options: options)
		case .custom(let format):			return DateInRegion(string, format: format, region: region)
		case .extended:						return DateInRegion(string, format: DateFormats.extended, region: region)
		case .sql:							return DateInRegion(string, format: DateFormats.sql, region: region)
		case .rss:							return DateInRegion(string, format: DateFormats.rss, region: Region.ISO)?.convertTo(locale: region.locale)
		case .altRSS:						return DateInRegion(string, format: DateFormats.altRSS, region: Region.ISO)?.convertTo(locale: region.locale)
		case .dotNet:						return DOTNETParser.parse(string, region: region, options: nil)
		case .httpHeader:					return DateInRegion(string, format: DateFormats.httpHeader, region: region)
		case .standard:						return DateInRegion(string, format: DateFormats.standard, region: region)
		case .strict(let format):
			let formatter = DateFormatter.sharedFormatter(forRegion: region, format: format)
			formatter.isLenient = false
			guard let absDate = formatter.date(from: string) else { return nil }
			return DateInRegion(absDate, region: region)
		}
	}
}
